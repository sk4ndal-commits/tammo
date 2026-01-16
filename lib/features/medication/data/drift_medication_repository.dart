import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../data/app_database.dart' as db;
import '../domain/medication.dart' as domain;
import '../domain/medication_repository.dart';

class DriftMedicationRepository implements MedicationRepository {
  final db.AppDatabase _db;

  DriftMedicationRepository(this._db);

  @override
  Future<List<domain.MedicationSchedule>> getSchedulesForPet(String petId) async {
    final query = _db.select(_db.medicationSchedules)..where((t) => t.petId.equals(petId));
    final results = await query.get();
    return results.map(_mapScheduleToEntity).toList();
  }

  @override
  Future<int> saveSchedule(domain.MedicationSchedule schedule) {
    return _db.into(_db.medicationSchedules).insert(
          db.MedicationSchedulesCompanion.insert(
            petId: schedule.petId,
            medicationName: schedule.medicationName,
            dosage: schedule.dosage,
            frequency: schedule.frequency,
            startDate: schedule.startDate,
            endDate: Value(schedule.endDate),
            reminderTimes: jsonEncode(schedule.reminderTimes),
            isActive: Value(schedule.isActive),
            createdAt: Value(schedule.createdAt),
          ),
        );
  }

  @override
  Future<void> updateSchedule(domain.MedicationSchedule schedule) async {
    if (schedule.id == null) return;
    await (_db.update(_db.medicationSchedules)..where((t) => t.id.equals(schedule.id!))).write(
          db.MedicationSchedulesCompanion(
            medicationName: Value(schedule.medicationName),
            dosage: Value(schedule.dosage),
            frequency: Value(schedule.frequency),
            startDate: Value(schedule.startDate),
            endDate: Value(schedule.endDate),
            reminderTimes: Value(jsonEncode(schedule.reminderTimes)),
            isActive: Value(schedule.isActive),
          ),
        );
  }

  @override
  Future<void> deleteSchedule(int id) async {
    await (_db.delete(_db.medicationSchedules)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<domain.MedicationCheckIn>> getCheckInsForSchedule(int scheduleId) async {
    final query = _db.select(_db.medicationCheckIns)..where((t) => t.scheduleId.equals(scheduleId));
    final results = await query.get();
    return results.map(_mapCheckInToEntity).toList();
  }

  @override
  Future<int> saveCheckIn(domain.MedicationCheckIn checkIn) async {
    return _db.into(_db.medicationCheckIns).insert(
          db.MedicationCheckInsCompanion.insert(
            scheduleId: checkIn.scheduleId,
            timestamp: Value(checkIn.timestamp),
            plannedTimestamp: checkIn.plannedTimestamp,
            isTaken: Value(checkIn.isTaken),
            completedBy: Value(checkIn.completedBy),
            completedByName: Value(checkIn.completedByName),
            notes: Value(checkIn.notes),
          ),
        );
  }

  @override
  Future<void> deleteCheckIn(int id) async {
    await (_db.delete(_db.medicationCheckIns)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> deleteSchedulesForPet(String petId) async {
    await (_db.delete(_db.medicationSchedules)..where((t) => t.petId.equals(petId))).go();
  }

  @override
  Future<void> deleteCheckInsForPet(String petId) async {
    final scheduleIdsQuery = _db.selectOnly(_db.medicationSchedules)
      ..addColumns([_db.medicationSchedules.id])
      ..where(_db.medicationSchedules.petId.equals(petId));
    
    final scheduleIds = (await scheduleIdsQuery.get()).map((r) => r.read(_db.medicationSchedules.id)!).toList();
    
    if (scheduleIds.isNotEmpty) {
      await (_db.delete(_db.medicationCheckIns)..where((t) => t.scheduleId.isIn(scheduleIds))).go();
    }
  }

  domain.MedicationSchedule _mapScheduleToEntity(db.MedicationSchedule data) {
    return domain.MedicationSchedule(
      id: data.id,
      petId: data.petId,
      medicationName: data.medicationName,
      dosage: data.dosage,
      frequency: data.frequency,
      startDate: data.startDate,
      endDate: data.endDate,
      reminderTimes: (jsonDecode(data.reminderTimes) as List).cast<String>(),
      isActive: data.isActive,
      createdAt: data.createdAt,
    );
  }

  domain.MedicationCheckIn _mapCheckInToEntity(db.MedicationCheckIn data) {
    return domain.MedicationCheckIn(
      id: data.id,
      scheduleId: data.scheduleId,
      timestamp: data.timestamp,
      plannedTimestamp: data.plannedTimestamp,
      isTaken: data.isTaken,
      completedBy: data.completedBy,
      completedByName: data.completedByName,
      notes: data.notes,
    );
  }
}
