class MedicationSchedule {
  final int? id;
  final String petId;
  final String medicationName;
  final String dosage;
  final String frequency;
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> reminderTimes;
  final bool isActive;
  final DateTime createdAt;

  MedicationSchedule({
    this.id,
    required this.petId,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    this.endDate,
    required this.reminderTimes,
    this.isActive = true,
    required this.createdAt,
  });

  MedicationSchedule copyWith({
    int? id,
    String? petId,
    String? medicationName,
    String? dosage,
    String? frequency,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? reminderTimes,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return MedicationSchedule(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MedicationCheckIn {
  final int? id;
  final int scheduleId;
  final DateTime timestamp;
  final DateTime plannedTimestamp;
  final bool isTaken;
  final String? completedBy; // user_id oder eindeutiger Identifier
  final String? completedByName; // Anzeigename für UI ("Alex", "Maria")
  final String? notes;

  MedicationCheckIn({
    this.id,
    required this.scheduleId,
    required this.timestamp,
    required this.plannedTimestamp,
    this.isTaken = true,
    this.completedBy,
    this.completedByName,
    this.notes,
  });

  MedicationCheckIn copyWith({
    int? id,
    int? scheduleId,
    DateTime? timestamp,
    DateTime? plannedTimestamp,
    bool? isTaken,
    String? completedBy,
    String? completedByName,
    String? notes,
  }) {
    return MedicationCheckIn(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      timestamp: timestamp ?? this.timestamp,
      plannedTimestamp: plannedTimestamp ?? this.plannedTimestamp,
      isTaken: isTaken ?? this.isTaken,
      completedBy: completedBy ?? this.completedBy,
      completedByName: completedByName ?? this.completedByName,
      notes: notes ?? this.notes,
    );
  }
}
