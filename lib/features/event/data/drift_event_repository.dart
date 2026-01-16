import 'package:drift/drift.dart';
import '../../../data/app_database.dart' as db;
import '../domain/event.dart' as domain;
import '../domain/event_repository.dart';

class DriftEventRepository implements EventRepository {
  final db.AppDatabase _db;

  DriftEventRepository(this._db);

  @override
  Future<List<domain.Event>> getEventsForPet(String petId) async {
    final query = _db.select(_db.events)
      ..where((t) => t.petId.equals(petId))
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]);
    
    final results = await query.get();
    return results.map(_mapToEntity).toList();
  }

  @override
  Future<void> saveEvent(domain.Event event) async {
    await _db.into(_db.events).insert(
          db.EventsCompanion.insert(
            petId: event.petId,
            type: event.type,
            timestamp: Value(event.timestamp),
            frequency: Value(event.frequency),
            notes: Value(event.notes),
            photoPath: Value(event.photoPath),
            createdAt: Value(event.createdAt),
          ),
        );
  }

  @override
  Future<void> deleteEvent(int id) async {
    await (_db.delete(_db.events)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> deleteEventsForPet(String petId) async {
    await (_db.delete(_db.events)..where((t) => t.petId.equals(petId))).go();
  }

  domain.Event _mapToEntity(db.Event data) {
    return domain.Event(
      id: data.id,
      petId: data.petId,
      type: data.type,
      timestamp: data.timestamp,
      frequency: data.frequency,
      notes: data.notes,
      photoPath: data.photoPath,
      createdAt: data.createdAt,
    );
  }
}
