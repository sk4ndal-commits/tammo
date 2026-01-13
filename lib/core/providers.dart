import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/app_database.dart';
import '../features/pet/data/drift_pet_repository.dart';
import '../features/pet/domain/pet_repository.dart';
import '../features/event/data/drift_event_repository.dart';
import '../features/event/domain/event_repository.dart';
import '../features/medication/data/drift_medication_repository.dart';
import '../features/medication/domain/medication_repository.dart';
import '../features/feeding/data/drift_feeding_repository.dart';
import '../features/feeding/domain/feeding_repository.dart';
import '../features/document/data/drift_document_repository.dart';
import '../features/document/domain/document_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final petRepositoryProvider = Provider<PetRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftPetRepository(db);
});

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftEventRepository(db);
});

final medicationRepositoryProvider = Provider<MedicationRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftMedicationRepository(db);
});

final feedingRepositoryProvider = Provider<FeedingRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftFeedingRepository(db);
});

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftDocumentRepository(db);
});
