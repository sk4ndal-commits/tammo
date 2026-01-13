class Event {
  final int? id;
  final String petId;
  final String type;
  final DateTime timestamp;
  final int frequency;
  final String? notes;
  final String? photoPath;
  final DateTime createdAt;

  Event({
    this.id,
    required this.petId,
    required this.type,
    required this.timestamp,
    this.frequency = 1,
    this.notes,
    this.photoPath,
    required this.createdAt,
  });

  Event copyWith({
    int? id,
    String? petId,
    String? type,
    DateTime? timestamp,
    int? frequency,
    String? notes,
    String? photoPath,
    DateTime? createdAt,
  }) {
    return Event(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      frequency: frequency ?? this.frequency,
      notes: notes ?? this.notes,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
