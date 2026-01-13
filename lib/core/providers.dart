import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/app_database.dart';
import '../features/pet/data/drift_pet_repository.dart';
import '../features/pet/domain/pet_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final petRepositoryProvider = Provider<PetRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftPetRepository(db);
});
