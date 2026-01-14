import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'dart:typed_data';
import '../../../l10n/app_localizations.dart';
import '../../../ui/widgets/localization_helpers.dart';

import '../../../core/providers.dart';
import '../domain/report_data.dart';
import '../../event/application/narrative_engine.dart';
import '../../pet/domain/pet.dart';
import '../../event/domain/event.dart';
import '../../medication/domain/medication.dart';
import '../../document/domain/document.dart';

class ExportService {
  final Ref _ref;

  ExportService(this._ref);

  Future<ReportData> fetchReportData({
    required Pet pet,
    required DateTime start,
    required DateTime end,
    required bool includeSymptoms,
    required bool includeMedications,
    required bool includeAllergies,
    required bool includeDocuments,
  }) async {
    // Fetch data
    List<Event> events = [];
    if (includeSymptoms) {
      events = await _ref.read(eventRepositoryProvider).getEventsForPet(pet.petId);
      events = events
          .where((e) =>
              e.timestamp.isAfter(start) &&
              e.timestamp.isBefore(end.add(const Duration(days: 1))))
          .toList();
      events.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    }

    final List<MedicationSchedule> medSchedules;
    final Map<int, List<MedicationCheckIn>> checkIns = {};
    if (includeMedications) {
      medSchedules = await _ref.read(medicationRepositoryProvider).getSchedulesForPet(pet.petId);
      for (final schedule in medSchedules) {
        if (schedule.id == null) continue;
        final cis = await _ref.read(medicationRepositoryProvider).getCheckInsForSchedule(schedule.id!);
        checkIns[schedule.id!] = cis
            .where((ci) =>
                ci.timestamp.isAfter(start) &&
                ci.timestamp.isBefore(end.add(const Duration(days: 1))))
            .toList();
      }
    } else {
      medSchedules = [];
    }

    List<Document> documents = [];
    if (includeDocuments) {
      documents = await _ref.read(documentRepositoryProvider).getDocumentsForPet(pet.petId);
      documents = documents
          .where((d) => d.date.isAfter(start) && d.date.isBefore(end.add(const Duration(days: 1))))
          .toList();
      documents.sort((a, b) => b.date.compareTo(a.date));
    }

    // Detect phases
    final allEvents = await _ref.read(eventRepositoryProvider).getEventsForPet(pet.petId);
    final allMedSchedules = await _ref.read(medicationRepositoryProvider).getSchedulesForPet(pet.petId);
    final phases = NarrativeEngine.detectPhases(
      events: allEvents,
      medicationSchedules: allMedSchedules,
    ).where((p) => 
        (p.startDate.isAfter(start) && p.startDate.isBefore(end.add(const Duration(days: 1)))) ||
        (p.endDate != null && p.endDate!.isAfter(start) && p.endDate!.isBefore(end.add(const Duration(days: 1)))) ||
        (p.endDate == null && p.startDate.isBefore(end))
    ).toList();

    return ReportData(
      pet: pet,
      startDate: start,
      endDate: end,
      events: events,
      phases: phases,
      medSchedules: medSchedules,
      medicationCheckIns: checkIns,
      documents: documents,
      includeSymptoms: includeSymptoms,
      includeMedications: includeMedications,
      includeAllergies: includeAllergies,
      includeDocuments: includeDocuments,
    );
  }

  Future<Uint8List> generatePdf({
    required ReportData data,
    required AppLocalizations l10n,
  }) async {
    final pdf = pw.Document();
    final pet = data.pet;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          final dateFormat = DateFormat.yMd();
          return [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(l10n.reportTitle(pet.name),
                      style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  pw.Text(DateFormat.yMd().format(DateTime.now())),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('${l10n.speciesLabel}: ${LocalizationHelpers.translateSpeciesWithL10n(l10n, pet.species)}'),
            if (pet.dateOfBirth != null)
              pw.Text('${l10n.birthDate}: ${dateFormat.format(pet.dateOfBirth!)}'),
            if (pet.gender != null) pw.Text('${l10n.genderLabel}: ${LocalizationHelpers.translateGenderWithL10n(l10n, pet.gender)}'),
            if (pet.weight != null) pw.Text('${l10n.weightLabel}: ${pet.weight} kg'),
            pw.SizedBox(height: 10),
            pw.Text(l10n.reportPeriod(dateFormat.format(data.startDate), dateFormat.format(data.endDate))),
            if (data.includeAllergies && pet.allergies?.isNotEmpty == true) ...[
              pw.SizedBox(height: 20),
              pw.Header(level: 1, text: l10n.includeAllergies),
              pw.Text(pet.allergies!,
                  style: pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold)),
            ],
            if (data.includeSymptoms && data.events.isNotEmpty) ...[
              pw.SizedBox(height: 20),
              pw.Header(level: 1, text: l10n.symptomLogTitle),
              
              if (data.phases.isNotEmpty) ...[
                ...data.phases.map((phase) {
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 10),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.grey200,
                          borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  l10n.phaseTitle(LocalizationHelpers.translateEventTypeWithL10n(l10n, phase.dominantTopic)),
                                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                ),
                                pw.Text(
                                  '${dateFormat.format(phase.startDate)} - ${phase.endDate != null ? dateFormat.format(phase.endDate!) : l10n.phaseOngoing}',
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            pw.Text(
                              l10n.phaseSummary(phase.events.length, phase.planIdsStarted.length + phase.planIdsEnded.length),
                              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                            ),
                          ],
                        ),
                      ),
                      pw.TableHelper.fromTextArray(
                        headers: [l10n.eventDateLabel, l10n.eventTypeLabel, l10n.notesLabel],
                        data: phase.events
                            .map((e) => [
                                  dateFormat.add_Hm().format(e.timestamp),
                                  LocalizationHelpers.translateEventTypeWithL10n(l10n, e.type),
                                  e.notes ?? '',
                                ])
                            .toList(),
                      ),
                      pw.SizedBox(height: 5),
                    ],
                  );
                }),
                
                // Individual events that are NOT in a phase
                if (data.events.where((e) => !data.phases.any((p) => p.events.any((pe) => pe.id == e.id))).isNotEmpty) ...[
                  pw.SizedBox(height: 10),
                  pw.Text(l10n.lastEvents, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.TableHelper.fromTextArray(
                    headers: [l10n.eventDateLabel, l10n.eventTypeLabel, l10n.notesLabel],
                    data: data.events
                        .where((e) => !data.phases.any((p) => p.events.any((pe) => pe.id == e.id)))
                        .map((e) => [
                              dateFormat.add_Hm().format(e.timestamp),
                              LocalizationHelpers.translateEventTypeWithL10n(l10n, e.type),
                              e.notes ?? '',
                            ])
                        .toList(),
                  ),
                ],
              ] else ...[
                pw.TableHelper.fromTextArray(
                  headers: [l10n.eventDateLabel, l10n.eventTypeLabel, l10n.notesLabel],
                  data: data.events
                      .map((e) => [
                            dateFormat.add_Hm().format(e.timestamp),
                            LocalizationHelpers.translateEventTypeWithL10n(l10n, e.type),
                            e.notes ?? '',
                          ])
                      .toList(),
                ),
              ],
            ],
            if (data.includeMedications && data.medSchedules.isNotEmpty) ...[
              pw.SizedBox(height: 20),
              pw.Header(level: 1, text: l10n.medicationPlanTitle),
              ...data.medSchedules.map((s) {
                final cis = data.medicationCheckIns[s.id!] ?? [];
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 10),
                    pw.Text('${s.medicationName} (${s.dosage}) - ${s.frequency}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    if (cis.isNotEmpty)
                      pw.TableHelper.fromTextArray(
                        headers: [l10n.eventDateLabel, 'Status', l10n.notesLabel],
                        data: cis
                            .map((ci) => [
                                  dateFormat.add_Hm().format(ci.timestamp),
                                  ci.isTaken ? l10n.medicationTaken : l10n.medicationMissed,
                                  ci.notes ?? '',
                                ])
                            .toList(),
                      )
                    else
                      pw.Text(l10n.noEntriesYet,
                          style: pw.TextStyle(fontStyle: pw.FontStyle.italic, fontSize: 10)),
                  ],
                );
              }),
            ],
            if (data.includeDocuments && data.documents.isNotEmpty) ...[
              pw.SizedBox(height: 20),
              pw.Header(level: 1, text: l10n.documentsTitle),
              pw.TableHelper.fromTextArray(
                headers: [l10n.eventDateLabel, l10n.documentNameLabel, l10n.documentTypeLabel],
                data: data.documents
                    .map((d) => [
                          dateFormat.format(d.date),
                          d.name,
                          LocalizationHelpers.translateDocumentTypeWithL10n(l10n, d.type),
                        ])
                    .toList(),
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
