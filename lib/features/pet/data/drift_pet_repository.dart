import 'package:drift/drift.dart';
import '../../../data/app_database.dart' as db;
import '../domain/pet.dart' as domain;
import '../domain/pet_repository.dart';

class DriftPetRepository implements PetRepository {
  final db.AppDatabase _db;

  DriftPetRepository(this._db);

  @override
  Future<domain.Pet?> getActivePet() async {
    // Da wir vorerst nur ein Haustier unterstützen, nehmen wir das erste.
    final petData = await _db.select(_db.pets).getSingleOrNull();
    if (petData == null) return null;
    return _mapToEntity(petData);
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
      notes: data.notes,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
