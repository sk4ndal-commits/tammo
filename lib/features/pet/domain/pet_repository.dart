import 'pet.dart';

abstract class PetRepository {
  Future<Pet?> getActivePet();
  Future<void> savePet(Pet pet);
  Future<void> updatePet(Pet pet);
}
