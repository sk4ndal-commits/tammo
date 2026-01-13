import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../data/app_database.dart' as db;
import '../domain/feeding.dart';
import '../domain/feeding_repository.dart';

class DriftFeedingRepository implements FeedingRepository {
  final db.AppDatabase _db;

  DriftFeedingRepository(this._db);

  @override
  Future<List<FeedingSchedule>> getFeedingSchedules(String petId) async {
    final query = _db.select(_db.feedingSchedules)
      ..where((t) => t.petId.equals(petId));
    final results = await query.get();
    return results.map(_mapScheduleToEntity).toList();
  }

  @override
  Future<void> saveFeedingSchedule(FeedingSchedule schedule) async {
    await _db.into(_db.feedingSchedules).insert(
          db.FeedingSchedulesCompanion.insert(
            petId: schedule.petId,
            foodType: schedule.foodType,
            amount: schedule.amount,
            reminderTimes: jsonEncode(schedule.reminderTimes),
            notes: Value(schedule.notes),
            isActive: Value(schedule.isActive),
            createdAt: Value(schedule.createdAt),
          ),
        );
  }

  @override
  Future<void> updateFeedingSchedule(FeedingSchedule schedule) async {
    if (schedule.id == null) return;
    await (_db.update(_db.feedingSchedules)..where((t) => t.id.equals(schedule.id!))).write(
          db.FeedingSchedulesCompanion(
            foodType: Value(schedule.foodType),
            amount: Value(schedule.amount),
            reminderTimes: Value(jsonEncode(schedule.reminderTimes)),
            notes: Value(schedule.notes),
            isActive: Value(schedule.isActive),
          ),
        );
  }

  @override
  Future<void> deleteFeedingSchedule(int id) async {
    await (_db.delete(_db.feedingSchedules)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<FeedingCheckIn>> getCheckInsForSchedule(int scheduleId) async {
    final query = _db.select(_db.feedingCheckIns)
      ..where((t) => t.scheduleId.equals(scheduleId));
    final results = await query.get();
    return results.map(_mapCheckInToEntity).toList();
  }

  @override
  Future<int> saveCheckIn(FeedingCheckIn checkIn) async {
    return _db.into(_db.feedingCheckIns).insert(
          db.FeedingCheckInsCompanion.insert(
            scheduleId: checkIn.scheduleId,
            timestamp: Value(checkIn.timestamp),
            plannedTimestamp: checkIn.plannedTimestamp,
            notes: Value(checkIn.notes),
          ),
        );
  }

  @override
  Future<void> deleteCheckIn(int id) async {
    await (_db.delete(_db.feedingCheckIns)..where((t) => t.id.equals(id))).go();
  }

  FeedingSchedule _mapScheduleToEntity(db.FeedingSchedule data) {
    return FeedingSchedule(
      id: data.id,
      petId: data.petId,
      foodType: data.foodType,
      amount: data.amount,
      reminderTimes: List<String>.from(jsonDecode(data.reminderTimes) as Iterable),
      notes: data.notes,
      isActive: data.isActive,
      createdAt: data.createdAt,
    );
  }

  FeedingCheckIn _mapCheckInToEntity(db.FeedingCheckIn data) {
    return FeedingCheckIn(
      id: data.id,
      scheduleId: data.scheduleId,
      timestamp: data.timestamp,
      plannedTimestamp: data.plannedTimestamp,
      notes: data.notes,
    );
  }
}
