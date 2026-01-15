import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers.dart';
import '../../../data/app_database.dart';
import '../domain/backup_data.dart';
import '../data/supabase_provider.dart';

final backupServiceProvider = Provider<BackupService>((ref) {
  final db = ref.watch(databaseProvider);
  final supabase = ref.watch(supabaseClientProvider);
  return BackupService(db, supabase);
});

class BackupService {
  final AppDatabase _db;
  final SupabaseClient _supabase;

  BackupService(this._db, this._supabase);

  Future<void> signUp(String email, String password) async {
    await _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signIn(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> uploadBackup() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    final backupData = await _prepareBackupData();
    
    await _supabase
        .from('backups')
        .upsert({
          'user_id': user.id,
          'data': backupData.toJson(),
          'updated_at': DateTime.now().toIso8601String(),
        });
  }

  Future<void> restoreBackup() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    final response = await _supabase
        .from('backups')
        .select('data')
        .eq('user_id', user.id)
        .maybeSingle();

    if (response != null && response['data'] != null) {
      final backupData = BackupData.fromJson(response['data'] as Map<String, dynamic>);
      await _applyBackupData(backupData);
    }
  }

  Future<BackupData> _prepareBackupData() async {
    final pets = await _db.select(_db.pets).get();
    final events = await _db.select(_db.events).get();
    final medSchedules = await _db.select(_db.medicationSchedules).get();
    final medCheckIns = await _db.select(_db.medicationCheckIns).get();
    final feedingSchedules = await _db.select(_db.feedingSchedules).get();
    final feedingCheckIns = await _db.select(_db.feedingCheckIns).get();
    final documents = await _db.select(_db.documents).get();

    return BackupData(
      pets: pets.map((e) => e.toJson()).toList(),
      events: events.map((e) => e.toJson()).toList(),
      medicationSchedules: medSchedules.map((e) => e.toJson()).toList(),
      medicationCheckIns: medCheckIns.map((e) => e.toJson()).toList(),
      feedingSchedules: feedingSchedules.map((e) => e.toJson()).toList(),
      feedingCheckIns: feedingCheckIns.map((e) => e.toJson()).toList(),
      documents: documents.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> _applyBackupData(BackupData data) async {
    await _db.transaction(() async {
      // Lösche vorhandene Daten (oder implementiere intelligenten Merge)
      // Für Restore-Flow im MVP löschen wir und laden neu, um Konsistenz zu garantieren.
      await _db.delete(_db.pets).go();
      await _db.delete(_db.events).go();
      await _db.delete(_db.medicationSchedules).go();
      await _db.delete(_db.medicationCheckIns).go();
      await _db.delete(_db.feedingSchedules).go();
      await _db.delete(_db.feedingCheckIns).go();
      await _db.delete(_db.documents).go();

      for (final petJson in data.pets) {
        await _db.into(_db.pets).insert(Pet.fromJson(petJson));
      }
      for (final eventJson in data.events) {
        await _db.into(_db.events).insert(Event.fromJson(eventJson));
      }
      for (final medScheduleJson in data.medicationSchedules) {
        await _db.into(_db.medicationSchedules).insert(MedicationSchedule.fromJson(medScheduleJson));
      }
      for (final medCheckInJson in data.medicationCheckIns) {
        await _db.into(_db.medicationCheckIns).insert(MedicationCheckIn.fromJson(medCheckInJson));
      }
      for (final feedingScheduleJson in data.feedingSchedules) {
        await _db.into(_db.feedingSchedules).insert(FeedingSchedule.fromJson(feedingScheduleJson));
      }
      for (final feedingCheckInJson in data.feedingCheckIns) {
        await _db.into(_db.feedingCheckIns).insert(FeedingCheckIn.fromJson(feedingCheckInJson));
      }
      for (final documentJson in data.documents) {
        await _db.into(_db.documents).insert(Document.fromJson(documentJson));
      }
    });
  }
}
