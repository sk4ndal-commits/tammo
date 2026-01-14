import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'localization_helpers.dart';
import 'care_phase_tile.dart';
import '../../features/export/domain/report_data.dart';
import '../../l10n/app_localizations.dart';

class ReportPreviewWidget extends StatelessWidget {
  final ReportData data;

  const ReportPreviewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMd();
    final dateTimeFormat = DateFormat.yMd().add_Hm();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Center(
          child: Column(
            children: [
              Text(
                l10n.reportTitle(data.pet.name),
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.reportPeriod(dateFormat.format(data.startDate), dateFormat.format(data.endDate)),
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary),
              ),
            ],
          ),
        ),
        const Divider(height: 32),

        // Pet Info
        _buildSectionTitle(l10n.onboardingTitle, theme),
        _buildInfoRow(l10n.speciesLabel, LocalizationHelpers.translateSpecies(context, data.pet.species), theme),
        if (data.pet.dateOfBirth != null)
          _buildInfoRow(l10n.birthDate, dateFormat.format(data.pet.dateOfBirth!), theme),
        if (data.pet.gender != null)
          _buildInfoRow(l10n.genderLabel, LocalizationHelpers.translateGender(context, data.pet.gender!), theme),
        if (data.pet.weight != null)
          _buildInfoRow(l10n.weightLabel, '${data.pet.weight} kg', theme),

        // Allergies
        if (data.includeAllergies && data.pet.allergies?.isNotEmpty == true) ...[
          const SizedBox(height: 24),
          _buildSectionTitle(l10n.includeAllergies, theme, color: theme.colorScheme.error),
          Text(
            data.pet.allergies!,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],

        // Symptoms
        if (data.includeSymptoms && data.events.isNotEmpty) ...[
          const SizedBox(height: 24),
          _buildSectionTitle(l10n.symptomLogTitle, theme),
          
          if (data.phases.isNotEmpty) ...[
            ...data.phases.map((phase) => CarePhaseTile(
              phase: phase,
              eventTileBuilder: (e) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(LocalizationHelpers.translateEventType(context, e.type)),
                  subtitle: Text(dateTimeFormat.format(e.timestamp)),
                  trailing: e.notes != null ? const Icon(Icons.notes) : null,
                  dense: true,
                ),
              ),
            )),
            if (data.events.where((e) => !data.phases.any((p) => p.events.any((pe) => pe.id == e.id))).isNotEmpty) ...[
               const SizedBox(height: 16),
               Text(l10n.lastEvents, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
               const SizedBox(height: 8),
               ...data.events.where((e) => !data.phases.any((p) => p.events.any((pe) => pe.id == e.id))).map((e) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(LocalizationHelpers.translateEventType(context, e.type)),
                  subtitle: Text(dateTimeFormat.format(e.timestamp)),
                  trailing: e.notes != null ? const Icon(Icons.notes) : null,
                  dense: true,
                ),
              )),
            ],
          ] else ...[
            ...data.events.map((e) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(LocalizationHelpers.translateEventType(context, e.type)),
                subtitle: Text(dateTimeFormat.format(e.timestamp)),
                trailing: e.notes != null ? const Icon(Icons.notes) : null,
                dense: true,
              ),
            )),
          ],
        ],

        // Medications
        if (data.includeMedications && data.medSchedules.isNotEmpty) ...[
          const SizedBox(height: 24),
          _buildSectionTitle(l10n.medicationPlanTitle, theme),
          ...data.medSchedules.map((s) {
            final cis = data.medicationCheckIns[s.id!] ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${s.medicationName} (${s.dosage})',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                if (cis.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(l10n.noEntriesYet, style: theme.textTheme.bodySmall),
                  )
                else
                  ...cis.map((ci) => Card(
                    margin: const EdgeInsets.only(left: 16.0, bottom: 4),
                    child: ListTile(
                      title: Text(ci.isTaken ? l10n.medicationTaken : l10n.medicationMissed),
                      subtitle: Text(dateTimeFormat.format(ci.timestamp)),
                      dense: true,
                      trailing: ci.notes != null ? const Icon(Icons.notes, size: 16) : null,
                    ),
                  )),
              ],
            );
          }),
        ],

        // Documents
        if (data.includeDocuments && data.documents.isNotEmpty) ...[
          const SizedBox(height: 24),
          _buildSectionTitle(l10n.documentsTitle, theme),
          ...data.documents.map((d) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(d.name),
              subtitle: Text('${LocalizationHelpers.translateDocumentType(context, d.type)} • ${dateFormat.format(d.date)}'),
              dense: true,
            ),
          )),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: color ?? theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text('$label:', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline)),
          const SizedBox(width: 8),
          Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
