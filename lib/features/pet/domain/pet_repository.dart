import 'pet.dart';

abstract class PetRepository {
  Future<List<Pet>> getAllPets();
  Future<void> savePet(Pet pet);
  Future<void> updatePet(Pet pet);
  Future<void> deletePet(String petId);
}
