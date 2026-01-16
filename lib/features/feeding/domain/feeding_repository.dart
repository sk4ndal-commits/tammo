import '../domain/feeding.dart';

abstract class FeedingRepository {
  Future<List<FeedingSchedule>> getFeedingSchedules(String petId);
  Future<int> saveFeedingSchedule(FeedingSchedule schedule);
  Future<void> updateFeedingSchedule(FeedingSchedule schedule);
  Future<void> deleteFeedingSchedule(int id);
  Future<List<FeedingCheckIn>> getCheckInsForSchedule(int scheduleId);
  Future<int> saveCheckIn(FeedingCheckIn checkIn);
  Future<void> deleteCheckIn(int id);
  Future<void> deleteSchedulesForPet(String petId);
  Future<void> deleteCheckInsForPet(String petId);
}
