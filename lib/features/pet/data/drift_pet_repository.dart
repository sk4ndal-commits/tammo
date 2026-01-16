import 'package:drift/drift.dart';
import '../../../data/app_database.dart' as db;
import '../domain/pet.dart' as domain;
import '../domain/pet_repository.dart';
import '../../event/domain/event_repository.dart';
import '../../medication/domain/medication_repository.dart';
import '../../feeding/domain/feeding_repository.dart';
import '../../document/domain/document_repository.dart';

class DriftPetRepository implements PetRepository {
  final db.AppDatabase _db;
  final EventRepository? _eventRepository;
  final MedicationRepository? _medicationRepository;
  final FeedingRepository? _feedingRepository;
  final DocumentRepository? _documentRepository;

  DriftPetRepository(
    this._db, {
    EventRepository? eventRepository,
    MedicationRepository? medicationRepository,
    FeedingRepository? feedingRepository,
    DocumentRepository? documentRepository,
  })  : _eventRepository = eventRepository,
        _medicationRepository = medicationRepository,
        _feedingRepository = feedingRepository,
        _documentRepository = documentRepository;

  @override
  Future<List<domain.Pet>> getAllPets() async {
    final results = await _db.select(_db.pets).get();
    return results.map(_mapToEntity).toList();
  }

  @override
  Future<void> deletePet(String petId) async {
    await _db.transaction(() async {
      // Manual cascade delete for all related data
      // Children must be deleted before parents to satisfy foreign key constraints

      // 1. Delete Events
      if (_eventRepository != null) {
        await _eventRepository!.deleteEventsForPet(petId);
      } else {
        await (_db.delete(_db.events)..where((t) => t.petId.equals(petId))).go();
      }

      // 2. Delete Medication Check-ins and then Schedules
      if (_medicationRepository != null) {
        await _medicationRepository!.deleteCheckInsForPet(petId);
        await _medicationRepository!.deleteSchedulesForPet(petId);
      } else {
        // Fallback if repository not provided (should not happen with current DI)
        final scheduleIds = await (_db.selectOnly(_db.medicationSchedules)
              ..addColumns([_db.medicationSchedules.id])
              ..where(_db.medicationSchedules.petId.equals(petId)))
            .get();
        final ids = scheduleIds.map((r) => r.read(_db.medicationSchedules.id)!).toList();
        if (ids.isNotEmpty) {
          await (_db.delete(_db.medicationCheckIns)..where((t) => t.scheduleId.isIn(ids))).go();
        }
        await (_db.delete(_db.medicationSchedules)..where((t) => t.petId.equals(petId))).go();
      }

      // 3. Delete Feeding Check-ins and then Schedules
      if (_feedingRepository != null) {
        await _feedingRepository!.deleteCheckInsForPet(petId);
        await _feedingRepository!.deleteSchedulesForPet(petId);
      } else {
        final scheduleIds = await (_db.selectOnly(_db.feedingSchedules)
              ..addColumns([_db.feedingSchedules.id])
              ..where(_db.feedingSchedules.petId.equals(petId)))
            .get();
        final ids = scheduleIds.map((r) => r.read(_db.feedingSchedules.id)!).toList();
        if (ids.isNotEmpty) {
          await (_db.delete(_db.feedingCheckIns)..where((t) => t.scheduleId.isIn(ids))).go();
        }
        await (_db.delete(_db.feedingSchedules)..where((t) => t.petId.equals(petId))).go();
      }

      // 4. Delete Documents
      if (_documentRepository != null) {
        await _documentRepository!.deleteDocumentsForPet(petId);
      } else {
        await (_db.delete(_db.documents)..where((t) => t.petId.equals(petId))).go();
      }

      // 5. Finally delete the pet itself
      await (_db.delete(_db.pets)..where((t) => t.petId.equals(petId))).go();
    });
  }

  @override
  Future<void> savePet(domain.Pet pet) async {
    await _db.into(_db.pets).insert(
          db.PetsCompanion.insert(
            petId: pet.petId,
            name: pet.name,
            species: pet.species,
            dateOfBirth: Value(pet.dateOfBirth),
            gender: Value(pet.gender),
            weight: Value(pet.weight),
            photoPath: Value(pet.photoPath),
            allergies: Value(pet.allergies),
            notes: Value(pet.notes),
            createdAt: Value(pet.createdAt),
            updatedAt: Value(pet.updatedAt),
          ),
        );
  }

  @override
  Future<void> updatePet(domain.Pet pet) async {
    await (_db.update(_db.pets)..where((t) => t.petId.equals(pet.petId))).write(
          db.PetsCompanion(
            name: Value(pet.name),
            species: Value(pet.species),
            dateOfBirth: Value(pet.dateOfBirth),
            gender: Value(pet.gender),
            weight: Value(pet.weight),
            photoPath: Value(pet.photoPath),
            allergies: Value(pet.allergies),
            notes: Value(pet.notes),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  domain.Pet _mapToEntity(db.Pet data) {
    return domain.Pet(
      petId: data.petId,
      name: data.name,
      species: data.species,
      dateOfBirth: data.dateOfBirth,
      gender: data.gender,
      weight: data.weight,
      photoPath: data.photoPath,
      allergies: data.allergies,
      notes: data.notes,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
