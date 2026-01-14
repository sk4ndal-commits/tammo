class FeedingSchedule {
  final int? id;
  final String petId;
  final String foodType;
  final String amount;
  final List<String> reminderTimes;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;

  FeedingSchedule({
    this.id,
    required this.petId,
    required this.foodType,
    required this.amount,
    required this.reminderTimes,
    this.notes,
    this.isActive = true,
    required this.createdAt,
  });

  FeedingSchedule copyWith({
    int? id,
    String? petId,
    String? foodType,
    String? amount,
    List<String>? reminderTimes,
    String? notes,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return FeedingSchedule(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      foodType: foodType ?? this.foodType,
      amount: amount ?? this.amount,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FeedingCheckIn {
  final int? id;
  final int scheduleId;
  final DateTime timestamp;
  final DateTime plannedTimestamp;
  final String? notes;

  FeedingCheckIn({
    this.id,
    required this.scheduleId,
    required this.timestamp,
    required this.plannedTimestamp,
    this.notes,
  });
}
