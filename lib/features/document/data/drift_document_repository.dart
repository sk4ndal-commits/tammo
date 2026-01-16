import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../data/app_database.dart' as db;
import '../domain/document.dart' as domain;
import '../domain/document_repository.dart';

class DriftDocumentRepository implements DocumentRepository {
  final db.AppDatabase _db;

  DriftDocumentRepository(this._db);

  @override
  Future<List<domain.Document>> getDocumentsForPet(String petId) async {
    final query = _db.select(_db.documents)..where((t) => t.petId.equals(petId));
    final results = await query.get();
    return results.map(_mapToEntity).toList();
  }

  @override
  Future<int> saveDocument(domain.Document document) {
    return _db.into(_db.documents).insert(
          db.DocumentsCompanion.insert(
            petId: document.petId,
            name: document.name,
            type: document.type,
            date: Value(document.date),
            filePath: document.filePath,
            tags: Value(jsonEncode(document.tags)),
            notes: Value(document.notes),
            createdAt: Value(document.createdAt),
          ),
        );
  }

  @override
  Future<void> deleteDocument(int id) async {
    await (_db.delete(_db.documents)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> deleteDocumentsForPet(String petId) async {
    await (_db.delete(_db.documents)..where((t) => t.petId.equals(petId))).go();
  }

  @override
  Future<domain.Document?> getDocumentById(int id) async {
    final query = _db.select(_db.documents)..where((t) => t.id.equals(id));
    final result = await query.getSingleOrNull();
    if (result == null) return null;
    return _mapToEntity(result);
  }

  domain.Document _mapToEntity(db.Document data) {
    return domain.Document(
      id: data.id,
      petId: data.petId,
      name: data.name,
      type: data.type,
      date: data.date,
      filePath: data.filePath,
      tags: (jsonDecode(data.tags ?? '[]') as List).cast<String>(),
      notes: data.notes,
      createdAt: data.createdAt,
    );
  }
}
