import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'dart:typed_data';

import '../../../core/providers.dart';
import '../../pet/domain/pet.dart';
import '../../event/domain/event.dart';
import '../../medication/domain/medication.dart';
import '../../document/domain/document.dart';

class ExportService {
  final Ref _ref;

  ExportService(this._ref);

  Future<Uint8List> generatePdf({
    required Pet pet,
    required DateTime start,
    required DateTime end,
    required bool includeSymptoms,
    required bool includeMedications,
    required bool includeDocuments,
  }) async {
    final pdf = pw.Document();

    // Fetch data
    List<Event> events = [];
    if (includeSymptoms) {
      events = await _ref.read(eventRepositoryProvider).getEventsForPet(pet.petId);
      events = events.where((e) => e.timestamp.isAfter(start) && e.timestamp.isBefore(end)).toList();
      events.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    }

    final List<MedicationSchedule> medSchedules;
    final Map<int, List<MedicationCheckIn>> checkIns = {};
    if (includeMedications) {
      medSchedules = await _ref.read(medicationRepositoryProvider).getSchedulesForPet(pet.petId);
      for (final schedule in medSchedules) {
        if (schedule.id == null) continue;
        final cis = await _ref.read(medicationRepositoryProvider).getCheckInsForSchedule(schedule.id!);
        checkIns[schedule.id!] = cis.where((ci) => ci.timestamp.isAfter(start) && ci.timestamp.isBefore(end)).toList();
      }
    } else {
      medSchedules = [];
    }

    List<Document> documents = [];
    if (includeDocuments) {
      documents = await _ref.read(documentRepositoryProvider).getDocumentsForPet(pet.petId);
      documents = documents.where((d) => d.date.isAfter(start) && d.date.isBefore(end)).toList();
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Tammo - Health Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  pw.Text(DateFormat.yMd().format(DateTime.now())),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Pet: ${pet.name}', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.Text('Species: ${pet.species}'),
            if (pet.dateOfBirth != null) pw.Text('DOB: ${DateFormat.yMd().format(pet.dateOfBirth!)}'),
            pw.Text('Report Period: ${DateFormat.yMd().format(start)} - ${DateFormat.yMd().format(end)}'),
            pw.SizedBox(height: 20),

            if (includeSymptoms && events.isNotEmpty) ...[
              pw.Header(level: 1, text: 'Symptoms & Events'),
              pw.TableHelper.fromTextArray(
                headers: ['Date', 'Type', 'Frequency', 'Notes'],
                data: events.map((e) => [
                  DateFormat.yMd().add_Hm().format(e.timestamp),
                  e.type,
                  e.frequency.toString(),
                  e.notes ?? '',
                ]).toList(),
              ),
              pw.SizedBox(height: 20),
            ],

            if (includeMedications && medSchedules.isNotEmpty) ...[
              pw.Header(level: 1, text: 'Medications'),
              ...medSchedules.map((s) {
                final cis = checkIns[s.id!] ?? [];
                if (cis.isEmpty) return pw.SizedBox();
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('${s.medicationName} (${s.dosage})', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.TableHelper.fromTextArray(
                      headers: ['Date', 'Status', 'Notes'],
                      data: cis.map((ci) => [
                        DateFormat.yMd().add_Hm().format(ci.timestamp),
                        ci.isTaken ? 'Taken' : 'Missed',
                        ci.notes ?? '',
                      ]).toList(),
                    ),
                    pw.SizedBox(height: 10),
                  ],
                );
              }),
              pw.SizedBox(height: 20),
            ],

            if (includeDocuments && documents.isNotEmpty) ...[
              pw.Header(level: 1, text: 'Documents'),
              pw.TableHelper.fromTextArray(
                headers: ['Date', 'Name', 'Type', 'Tags'],
                data: documents.map((d) => [
                  DateFormat.yMd().format(d.date),
                  d.name,
                  d.type,
                  d.tags,
                ]).toList(),
              ),
            ],
          ];
        },
      ),
    );

    return pdf.save();
  }
}

final exportServiceProvider = Provider<ExportService>((ref) {
  return ExportService(ref);
});
