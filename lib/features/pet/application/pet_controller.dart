import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers.dart';
import '../domain/pet.dart';

class PetControllerState {
  final List<Pet> allPets;
  final Pet? activePet;

  PetControllerState({
    required this.allPets,
    this.activePet,
  });

  PetControllerState copyWith({
    List<Pet>? allPets,
    Pet? activePet,
    bool clearActivePet = false,
  }) {
    return PetControllerState(
      allPets: allPets ?? this.allPets,
      activePet: clearActivePet ? null : (activePet ?? this.activePet),
    );
  }
}

class PetController extends StateNotifier<AsyncValue<PetControllerState>> {
  final Ref _ref;

  PetController(this._ref) : super(const AsyncValue.loading()) {
    loadPets();
  }

  Future<void> loadPets() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final pets = await _ref.read(petRepositoryProvider).getAllPets();
      final activePet = pets.isNotEmpty ? pets.first : null;
      return PetControllerState(allPets: pets, activePet: activePet);
    });
  }

  void setActivePet(Pet pet) {
    state.whenData((currentState) {
      state = AsyncValue.data(currentState.copyWith(activePet: pet));
    });
  }

  Future<void> createPet({
    required String name,
    required String species,
    DateTime? dateOfBirth,
    String? gender,
    double? weight,
    String? photoPath,
    String? allergies,
    String? notes,
  }) async {
    final newPet = Pet(
      petId: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      species: species,
      dateOfBirth: dateOfBirth,
      gender: gender,
      weight: weight,
      photoPath: photoPath,
      allergies: allergies,
      notes: notes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _ref.read(petRepositoryProvider).savePet(newPet);
    await loadPets();
    // Automatisch das neu erstellte Tier als aktiv setzen
    setActivePet(newPet);
  }

  Future<void> updatePet({
    required String name,
    required String species,
    DateTime? dateOfBirth,
    String? gender,
    double? weight,
    String? photoPath,
    String? allergies,
    String? notes,
  }) async {
    final currentPet = state.value?.activePet;
    if (currentPet == null) return;

    final updatedPet = currentPet.copyWith(
      name: name,
      species: species,
      dateOfBirth: dateOfBirth,
      gender: gender,
      weight: weight,
      photoPath: photoPath,
      allergies: allergies,
      notes: notes,
      updatedAt: DateTime.now(),
    );

    await _ref.read(petRepositoryProvider).updatePet(updatedPet);
    await loadPets();
    setActivePet(updatedPet);
  }

  Future<void> deletePet(String petId) async {
    await _ref.read(petRepositoryProvider).deletePet(petId);
    await loadPets();
  }
}

final petControllerProvider = StateNotifierProvider<PetController, AsyncValue<PetControllerState>>((ref) {
  return PetController(ref);
});
