import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'app_database.g.dart';

class Pets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get petId => text().unique()(); // Eindeutige pet_id für Skalierbarkeit
  TextColumn get name => text()();
  TextColumn get species => text()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get gender => text().nullable()();
  RealColumn get weight => real().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get allergies => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get petId => text().references(Pets, #petId)();
  TextColumn get type => text()(); // z.B. 'vomiting', 'diarrhea', 'appetite', 'behavior'
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  IntColumn get frequency => integer().withDefault(const Constant(1))();
  TextColumn get notes => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class MedicationSchedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get petId => text().references(Pets, #petId)();
  TextColumn get medicationName => text()();
  TextColumn get dosage => text()();
  TextColumn get frequency => text()(); // z.B. '1x daily', '2x daily'
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get reminderTimes => text()(); // JSON list of times, e.g. ["08:00", "20:00"]
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class MedicationCheckIns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get scheduleId => integer().references(MedicationSchedules, #id)();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get plannedTimestamp => dateTime()();
  BoolColumn get isTaken => boolean().withDefault(const Constant(true))();
  TextColumn get notes => text().nullable()();
}

class FeedingSchedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get petId => text().references(Pets, #petId)();
  TextColumn get foodType => text()(); // z.B. 'Trockenfutter', 'Nassfutter'
  TextColumn get amount => text()(); // z.B. '50g'
  TextColumn get reminderTimes => text()(); // JSON list of times, e.g. ["07:00", "19:00"]
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class FeedingCheckIns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get scheduleId => integer().references(FeedingSchedules, #id)();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get plannedTimestamp => dateTime()();
  TextColumn get notes => text().nullable()();
}

class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get petId => text().references(Pets, #petId)();
  TextColumn get name => text()();
  TextColumn get type => text()(); // z.B. 'Befund', 'Rechnung', 'Impfung'
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get filePath => text()();
  TextColumn get tags => text().nullable()(); // Gespeichert als JSON Liste
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Pets, Events, MedicationSchedules, MedicationCheckIns, FeedingSchedules, FeedingCheckIns, Documents])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.createTable(medicationSchedules);
          await m.createTable(medicationCheckIns);
          await m.createTable(feedingSchedules);
          await m.createTable(feedingCheckIns);
          await m.createTable(events);
        }
        if (from < 3) {
          await m.createTable(documents);
        }
        if (from < 4) {
          await m.addColumn(pets, pets.allergies);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
