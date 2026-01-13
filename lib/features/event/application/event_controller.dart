import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers.dart';
import '../../pet/application/pet_controller.dart';
import '../domain/event.dart';

class EventController extends StateNotifier<AsyncValue<List<Event>>> {
  final Ref _ref;

  EventController(this._ref) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    // Wenn sich das Tier ändert, laden wir die Events neu
    _ref.listen(petControllerProvider, (previous, next) {
      final newPet = next.value?.activePet;
      final oldPet = previous?.value?.activePet;
      if (newPet?.petId != oldPet?.petId) {
        loadEvents();
      }
    });
    loadEvents();
  }

  Future<void> loadEvents() async {
    final pet = _ref.read(petControllerProvider).value?.activePet;
    if (pet == null) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => 
      _ref.read(eventRepositoryProvider).getEventsForPet(pet.petId)
    );
  }

  Future<void> addEvent({
    required String type,
    required DateTime timestamp,
    int frequency = 1,
    String? notes,
    String? photoPath,
  }) async {
    final pet = _ref.read(petControllerProvider).value?.activePet;
    if (pet == null) return;

    final newEvent = Event(
      petId: pet.petId,
      type: type,
      timestamp: timestamp,
      frequency: frequency,
      notes: notes,
      photoPath: photoPath,
      createdAt: DateTime.now(),
    );

    await _ref.read(eventRepositoryProvider).saveEvent(newEvent);
    await loadEvents();
  }

  Future<void> deleteEvent(int id) async {
    await _ref.read(eventRepositoryProvider).deleteEvent(id);
    await loadEvents();
  }
}

final eventControllerProvider = StateNotifierProvider<EventController, AsyncValue<List<Event>>>((ref) {
  return EventController(ref);
});
