class Pet {
  final String petId;
  final String name;
  final String species;
  final DateTime? dateOfBirth;
  final String? gender;
  final double? weight;
  final String? photoPath;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pet({
    required this.petId,
    required this.name,
    required this.species,
    this.dateOfBirth,
    this.gender,
    this.weight,
    this.photoPath,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Pet copyWith({
    String? name,
    String? species,
    DateTime? dateOfBirth,
    String? gender,
    double? weight,
    String? photoPath,
    String? notes,
    DateTime? updatedAt,
  }) {
    return Pet(
      petId: petId,
      name: name ?? this.name,
      species: species ?? this.species,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
