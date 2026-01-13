import 'medication.dart';

abstract class MedicationRepository {
  Future<List<MedicationSchedule>> getSchedulesForPet(String petId);
  Future<int> saveSchedule(MedicationSchedule schedule);
  Future<void> updateSchedule(MedicationSchedule schedule);
  Future<void> deleteSchedule(int id);
  
  Future<List<MedicationCheckIn>> getCheckInsForSchedule(int scheduleId);
  Future<void> saveCheckIn(MedicationCheckIn checkIn);
}
