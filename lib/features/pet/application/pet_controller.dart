import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers.dart';
import '../domain/pet.dart';

class PetController extends StateNotifier<AsyncValue<Pet?>> {
  final Ref _ref;

  PetController(this._ref) : super(const AsyncValue.loading()) {
    loadPet();
  }

  Future<void> loadPet() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _ref.read(petRepositoryProvider).getActivePet());
  }

  Future<void> createPet({
    required String name,
    required String species,
    DateTime? dateOfBirth,
    String? gender,
    double? weight,
    String? photoPath,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    final newPet = Pet(
      petId: DateTime.now().millisecondsSinceEpoch.toString(), // Einfache eindeutige ID
      name: name,
      species: species,
      dateOfBirth: dateOfBirth,
      gender: gender,
      weight: weight,
      photoPath: photoPath,
      notes: notes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    state = await AsyncValue.guard(() async {
      await _ref.read(petRepositoryProvider).savePet(newPet);
      return newPet;
    });
  }

  Future<void> updatePet({
    required String name,
    required String species,
    DateTime? dateOfBirth,
    String? gender,
    double? weight,
    String? photoPath,
    String? notes,
  }) async {
    final currentPet = state.value;
    if (currentPet == null) return;

    final updatedPet = currentPet.copyWith(
      name: name,
      species: species,
      dateOfBirth: dateOfBirth,
      gender: gender,
      weight: weight,
      photoPath: photoPath,
      notes: notes,
      updatedAt: DateTime.now(),
    );

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _ref.read(petRepositoryProvider).updatePet(updatedPet);
      return updatedPet;
    });
  }
}

final petControllerProvider = StateNotifierProvider<PetController, AsyncValue<Pet?>>((ref) {
  return PetController(ref);
});
