import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../core/providers.dart';
import '../../pet/application/pet_controller.dart';
import '../domain/document.dart';

class DocumentController extends StateNotifier<AsyncValue<List<Document>>> {
  final Ref _ref;

  DocumentController(this._ref) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _ref.listen(petControllerProvider, (previous, next) {
      final newPet = next.value?.activePet;
      final oldPet = previous?.value?.activePet;
      if (newPet?.petId != oldPet?.petId) {
        loadDocuments();
      }
    });
    loadDocuments();
  }

  Future<void> loadDocuments() async {
    final pet = _ref.read(petControllerProvider).value?.activePet;
    if (pet == null) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => _ref.read(documentRepositoryProvider).getDocumentsForPet(pet.petId));
  }

  Future<void> uploadDocument({
    required String name,
    required String type,
    required DateTime date,
    required File file,
    required List<String> tags,
    String? notes,
  }) async {
    final pet = _ref.read(petControllerProvider).value?.activePet;
    if (pet == null) return;

    // We copy the file to the app's document directory to ensure offline availability
    final appDocDir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${p.basename(file.path)}';
    final savedFile = await file.copy(p.join(appDocDir.path, fileName));

    final document = Document(
      petId: pet.petId,
      name: name,
      type: type,
      date: date,
      filePath: savedFile.path,
      tags: tags,
      notes: notes,
      createdAt: DateTime.now(),
    );

    await _ref.read(documentRepositoryProvider).saveDocument(document);
    await loadDocuments();
  }

  Future<void> deleteDocument(Document document) async {
    if (document.id == null) return;
    
    // Delete local file
    final file = File(document.filePath);
    if (await file.exists()) {
      await file.delete();
    }

    await _ref.read(documentRepositoryProvider).deleteDocument(document.id!);
    await loadDocuments();
  }
}

final documentControllerProvider =
    StateNotifierProvider<DocumentController, AsyncValue<List<Document>>>((ref) {
  return DocumentController(ref);
});
