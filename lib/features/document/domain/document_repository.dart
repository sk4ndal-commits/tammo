import 'document.dart';

abstract class DocumentRepository {
  Future<List<Document>> getDocumentsForPet(String petId);
  Future<int> saveDocument(Document document);
  Future<void> deleteDocument(int id);
  Future<Document?> getDocumentById(int id);
  Future<void> deleteDocumentsForPet(String petId);
}
