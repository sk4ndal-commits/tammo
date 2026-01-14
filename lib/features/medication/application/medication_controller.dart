import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers.dart';
import '../../../core/notification_service.dart';
import '../../pet/application/pet_controller.dart';
import '../domain/medication.dart';

class MedicationController extends StateNotifier<AsyncValue<List<MedicationSchedule>>> {
  final Ref _ref;

  MedicationController(this._ref) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _ref.listen(petControllerProvider, (previous, next) {
      final newPet = next.value?.activePet;
      final oldPet = previous?.value?.activePet;
      if (newPet?.petId != oldPet?.petId) {
        loadSchedules();
      }
    });
    loadSchedules();
  }

  Future<void> loadSchedules() async {
    final pet = _ref.read(petControllerProvider).value?.activePet;
    if (pet == null) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _ref.read(medicationRepositoryProvider).getSchedulesForPet(pet.petId));
  }

  Future<void> createSchedule({
    required String medicationName,
    required String dosage,
    required String frequency,
    required DateTime startDate,
    DateTime? endDate,
    required List<String> reminderTimes,
  }) async {
    final pet = _ref.read(petControllerProvider).value?.activePet;
    if (pet == null) return;

    final schedule = MedicationSchedule(
      petId: pet.petId,
      medicationName: medicationName,
      dosage: dosage,
      frequency: frequency,
      startDate: startDate,
      endDate: endDate,
      reminderTimes: reminderTimes,
      createdAt: DateTime.now(),
    );

    final id = await _ref.read(medicationRepositoryProvider).saveSchedule(schedule);
    
    // Benachrichtigungen planen
    for (var i = 0; i < reminderTimes.length; i++) {
      final timeParts = reminderTimes[i].split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      
      await NotificationService().scheduleDailyNotification(
        id: id * 100 + i, // Eindeutige ID für die Benachrichtigung
        title: 'Tammo: ${pet.name}',
        body: '$medicationName ($dosage)',
        hour: hour,
        minute: minute,
      );
    }

    await loadSchedules();
  }

  Future<void> deleteSchedule(int id) async {
    // Benachrichtigungen stornieren (wir wissen nicht wie viele, also probieren wir ein paar)
    // In einer echten App würden wir die Anzahl der Erinnerungszeiten speichern
    for (var i = 0; i < 10; i++) {
      await NotificationService().cancelNotification(id * 100 + i);
    }
    
    await _ref.read(medicationRepositoryProvider).deleteSchedule(id);
    await loadSchedules();
  }

  Future<void> updateSchedule(MedicationSchedule schedule) async {
    // Re-schedule notifications
    final pet = _ref.read(petControllerProvider).value?.activePet;
    if (pet != null) {
      // Cancel old ones first (best effort)
      for (var i = 0; i < 10; i++) {
        await NotificationService().cancelNotification(schedule.id! * 100 + i);
      }

      if (schedule.isActive) {
        for (var i = 0; i < schedule.reminderTimes.length; i++) {
          final timeParts = schedule.reminderTimes[i].split(':');
          await NotificationService().scheduleDailyNotification(
            id: schedule.id! * 100 + i,
            title: 'Tammo: ${pet.name}',
            body: '${schedule.medicationName} (${schedule.dosage})',
            hour: int.parse(timeParts[0]),
            minute: int.parse(timeParts[1]),
          );
        }
      }
    }

    await _ref.read(medicationRepositoryProvider).updateSchedule(schedule);
    await loadSchedules();
  }

  Future<void> toggleActive(MedicationSchedule schedule) async {
    final updated = schedule.copyWith(isActive: !schedule.isActive);
    await updateSchedule(updated);
  }

  Future<int> checkIn({
    required int scheduleId,
    required DateTime plannedTimestamp,
    bool isTaken = true,
    String? notes,
  }) async {
    final checkIn = MedicationCheckIn(
      scheduleId: scheduleId,
      timestamp: DateTime.now(),
      plannedTimestamp: plannedTimestamp,
      isTaken: isTaken,
      notes: notes,
    );

    final id = await _ref.read(medicationRepositoryProvider).saveCheckIn(checkIn);
    _ref.invalidate(medicationCheckInsProvider(scheduleId));
    await loadSchedules(); // Refresh to update Home Screen
    return id;
  }

  Future<void> undoCheckIn(int checkInId, int scheduleId) async {
    await _ref.read(medicationRepositoryProvider).deleteCheckIn(checkInId);
    _ref.invalidate(medicationCheckInsProvider(scheduleId));
    await loadSchedules(); // Refresh to update Home Screen
  }
}

final medicationControllerProvider = StateNotifierProvider<MedicationController, AsyncValue<List<MedicationSchedule>>>((ref) {
  return MedicationController(ref);
});

final medicationCheckInsProvider = FutureProvider.family<List<MedicationCheckIn>, int>((ref, scheduleId) async {
  return ref.watch(medicationRepositoryProvider).getCheckInsForSchedule(scheduleId);
});
