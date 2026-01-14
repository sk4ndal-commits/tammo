import '../../pet/domain/pet.dart';
import '../../event/domain/event.dart';
import '../../medication/domain/medication.dart';
import '../../document/domain/document.dart';

class ReportData {
  final Pet pet;
  final DateTime startDate;
  final DateTime endDate;
  final List<Event> events;
  final List<MedicationSchedule> medSchedules;
  final Map<int, List<MedicationCheckIn>> medicationCheckIns;
  final List<Document> documents;
  final bool includeSymptoms;
  final bool includeMedications;
  final bool includeAllergies;
  final bool includeDocuments;

  ReportData({
    required this.pet,
    required this.startDate,
    required this.endDate,
    required this.events,
    required this.medSchedules,
    required this.medicationCheckIns,
    required this.documents,
    required this.includeSymptoms,
    required this.includeMedications,
    required this.includeAllergies,
    required this.includeDocuments,
  });
}
