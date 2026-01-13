import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers.dart';
import '../../../core/notification_service.dart';
import '../../pet/application/pet_controller.dart';
import '../domain/feeding.dart';

class FeedingController extends StateNotifier<AsyncValue<List<FeedingSchedule>>> {
  final Ref _ref;

  FeedingController(this._ref) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _ref.listen(petControllerProvider, (previous, next) {
      if (next.value?.petId != previous?.value?.petId) {
        _loadSchedules();
      }
    });
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final pet = _ref.read(petControllerProvider).value;
    if (pet == null) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _ref.read(feedingRepositoryProvider).getFeedingSchedules(pet.petId),
    );
  }

  Future<void> createFeedingSchedule({
    required String foodType,
    required String amount,
    required List<String> reminderTimes,
    String? notes,
  }) async {
    final pet = _ref.read(petControllerProvider).value;
    if (pet == null) return;

    final schedule = FeedingSchedule(
      petId: pet.petId,
      foodType: foodType,
      amount: amount,
      reminderTimes: reminderTimes,
      notes: notes,
      createdAt: DateTime.now(),
    );

    await AsyncValue.guard(() async {
      await _ref.read(feedingRepositoryProvider).saveFeedingSchedule(schedule);
      
      // Schedule notifications
      for (final time in reminderTimes) {
        final parts = time.split(':');
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        
        await NotificationService().scheduleDailyNotification(
          id: DateTime.now().millisecondsSinceEpoch % 100000, // Basic unique ID
          title: 'Fütterung für ${pet.name}',
          body: '$amount $foodType ist fällig.',
          hour: hour,
          minute: minute,
        );
      }
      
      return _loadSchedules();
    });
  }

  Future<int?> checkIn({
    required int scheduleId,
    required DateTime plannedTimestamp,
    String? notes,
  }) async {
    final checkIn = FeedingCheckIn(
      scheduleId: scheduleId,
      timestamp: DateTime.now(),
      plannedTimestamp: plannedTimestamp,
      notes: notes,
    );

    final result = await AsyncValue.guard(() async {
      final id = await _ref.read(feedingRepositoryProvider).saveCheckIn(checkIn);
      _ref.invalidate(feedingCheckInsProvider(scheduleId));
      await _loadSchedules(); // Refresh to update Home Screen
      return id;
    });
    return result.value;
  }

  Future<void> undoCheckIn(int checkInId, int scheduleId) async {
    await AsyncValue.guard(() async {
      await _ref.read(feedingRepositoryProvider).deleteCheckIn(checkInId);
      _ref.invalidate(feedingCheckInsProvider(scheduleId));
      await _loadSchedules(); // Refresh to update Home Screen
    });
  }
}

final feedingControllerProvider =
    StateNotifierProvider<FeedingController, AsyncValue<List<FeedingSchedule>>>((ref) {
  return FeedingController(ref);
});

final feedingCheckInsProvider =
    FutureProvider.family<List<FeedingCheckIn>, int>((ref, scheduleId) async {
  return ref.read(feedingRepositoryProvider).getCheckInsForSchedule(scheduleId);
});
