class Document {
  final int? id;
  final String petId;
  final String name;
  final String type; // e.g., 'Finding', 'Invoice', 'Vaccination', 'Other'
  final DateTime date;
  final String filePath;
  final List<String> tags;
  final String? notes;
  final DateTime createdAt;

  Document({
    this.id,
    required this.petId,
    required this.name,
    required this.type,
    required this.date,
    required this.filePath,
    required this.tags,
    this.notes,
    required this.createdAt,
  });

  Document copyWith({
    int? id,
    String? petId,
    String? name,
    String? type,
    DateTime? date,
    String? filePath,
    List<String>? tags,
    String? notes,
    DateTime? createdAt,
  }) {
    return Document(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      name: name ?? this.name,
      type: type ?? this.type,
      date: date ?? this.date,
      filePath: filePath ?? this.filePath,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
