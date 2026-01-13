import 'event.dart';

abstract class EventRepository {
  Future<List<Event>> getEventsForPet(String petId);
  Future<void> saveEvent(Event event);
  Future<void> deleteEvent(int id);
}
