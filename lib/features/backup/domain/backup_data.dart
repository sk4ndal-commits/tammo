class BackupData {
  final List<Map<String, dynamic>> pets;
  final List<Map<String, dynamic>> events;
  final List<Map<String, dynamic>> medicationSchedules;
  final List<Map<String, dynamic>> medicationCheckIns;
  final List<Map<String, dynamic>> feedingSchedules;
  final List<Map<String, dynamic>> feedingCheckIns;
  final List<Map<String, dynamic>> documents;

  BackupData({
    required this.pets,
    required this.events,
    required this.medicationSchedules,
    required this.medicationCheckIns,
    required this.feedingSchedules,
    required this.feedingCheckIns,
    required this.documents,
  });

  Map<String, dynamic> toJson() {
    return {
      'pets': pets,
      'events': events,
      'medicationSchedules': medicationSchedules,
      'medicationCheckIns': medicationCheckIns,
      'feedingSchedules': feedingSchedules,
      'feedingCheckIns': feedingCheckIns,
      'documents': documents,
    };
  }

  factory BackupData.fromJson(Map<String, dynamic> json) {
    return BackupData(
      pets: List<Map<String, dynamic>>.from(json['pets'] ?? []),
      events: List<Map<String, dynamic>>.from(json['events'] ?? []),
      medicationSchedules: List<Map<String, dynamic>>.from(json['medicationSchedules'] ?? []),
      medicationCheckIns: List<Map<String, dynamic>>.from(json['medicationCheckIns'] ?? []),
      feedingSchedules: List<Map<String, dynamic>>.from(json['feedingSchedules'] ?? []),
      feedingCheckIns: List<Map<String, dynamic>>.from(json['feedingCheckIns'] ?? []),
      documents: List<Map<String, dynamic>>.from(json['documents'] ?? []),
    );
  }
}
