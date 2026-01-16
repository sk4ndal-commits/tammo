import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/providers.dart';
import '../../pet/application/pet_controller.dart';
import '../../../data/app_database.dart';
import '../domain/backup_data.dart';
import '../data/supabase_provider.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref);
});

final backupStatusProvider = StateProvider<String?>((ref) => null);

final lastBackupTimeProvider = FutureProvider<DateTime?>((ref) async {
  final backupService = ref.watch(backupServiceProvider);
  return backupService.getLastBackupTime();
});

class BackupService {
  final Ref _ref;
  static const String _lastBackupTimeKey = 'last_backup_time';
  static const String _lastBackupHashKey = 'last_backup_hash';

  BackupService(this._ref);

  AppDatabase get _db => _ref.read(databaseProvider);
  SupabaseClient get _supabase => _ref.read(supabaseClientProvider);

  Future<void> signUp(String email, String password) async {
    await _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signIn(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> uploadBackup({bool force = false}) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    final backupData = await _prepareBackupData();
    final jsonData = backupData.toJson();
    final currentHash = _calculateHash(jsonData);

    final prefs = await SharedPreferences.getInstance();
    final lastHash = prefs.getString(_lastBackupHashKey);

    if (!force && lastHash == currentHash) {
      // No changes, skip upload but update last backup time if it was never set
      if (prefs.getString(_lastBackupTimeKey) == null) {
        await prefs.setString(_lastBackupTimeKey, DateTime.now().toIso8601String());
        _ref.invalidate(lastBackupTimeProvider);
      }
      return;
    }
    
    await _supabase
        .from('backups')
        .upsert({
          'user_id': user.id,
          'data': jsonData,
          'updated_at': DateTime.now().toIso8601String(),
        });

    await prefs.setString(_lastBackupTimeKey, DateTime.now().toIso8601String());
    await prefs.setString(_lastBackupHashKey, currentHash);
    _ref.invalidate(lastBackupTimeProvider);
  }

  String _calculateHash(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    return sha256.convert(utf8.encode(jsonString)).toString();
  }

  Future<DateTime?> getLastBackupTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timeStr = prefs.getString(_lastBackupTimeKey);
    return timeStr != null ? DateTime.parse(timeStr) : null;
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

      // Reset local sync state after restore
      final prefs = await SharedPreferences.getInstance();
      final currentHash = _calculateHash(response['data'] as Map<String, dynamic>);
      await prefs.setString(_lastBackupTimeKey, DateTime.now().toIso8601String());
      await prefs.setString(_lastBackupHashKey, currentHash);
      
      // Invalidate providers to refresh UI with restored data
      _ref.invalidate(lastBackupTimeProvider);
      // We need to reload all data in the app controllers
      _ref.read(petControllerProvider.notifier).loadPets();
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
