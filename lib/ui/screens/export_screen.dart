import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/export/application/export_service.dart';
import '../../features/export/domain/report_data.dart';
import '../widgets/report_preview_widget.dart';

class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  bool _includeSymptoms = true;
  bool _includeMedications = true;
  bool _includeAllergies = true;
  bool _includeDocuments = true;
  bool _selectAll = true;
  bool _isLoading = false;
  bool _isGeneratingPdf = false;
  ReportData? _previewData;

  void _toggleSelectAll(bool? value) {
    if (value == null) return;
    setState(() {
      _selectAll = value;
      _includeSymptoms = value;
      _includeMedications = value;
      _includeAllergies = value;
      _includeDocuments = value;
      _previewData = null;
    });
  }

  void _updateSelectAllState() {
    setState(() {
      _selectAll = _includeSymptoms && _includeMedications && _includeAllergies && _includeDocuments;
      _previewData = null;
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _previewData = null;
      });
    }
  }

  Future<void> _fetchPreviewData() async {
    final pet = ref.read(petControllerProvider).value?.activePet;
    if (pet == null) return;

    setState(() => _isLoading = true);

    try {
      final data = await ref.read(exportServiceProvider).fetchReportData(
            pet: pet,
            start: _startDate,
            end: _endDate,
            includeSymptoms: _includeSymptoms,
            includeMedications: _includeMedications,
            includeAllergies: _includeAllergies,
            includeDocuments: _includeDocuments,
          );
      setState(() {
        _previewData = data;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _generatePdf() async {
    if (_previewData == null) return;

    setState(() => _isGeneratingPdf = true);

    final l10n = AppLocalizations.of(context)!;
    try {
      final pdfBytes = await ref.read(exportServiceProvider).generatePdf(
            data: _previewData!,
            l10n: l10n,
          );

      final directory = await getTemporaryDirectory();
      final filePath =
          '${directory.path}/tammo_report_${_previewData!.pet.name}_${DateFormat('yyyyMMdd').format(DateTime.now())}.pdf';
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      if (mounted) {
        await Share.shareXFiles(
          [XFile(filePath)],
          subject: l10n.reportTitle(_previewData!.pet.name),
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.exportSuccess),
            behavior: SnackBarBehavior.floating,
            width: 200,
            duration: const Duration(seconds: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGeneratingPdf = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.exportTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.exportSubtitle,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(l10n.period),
                subtitle: Text(
                    '${DateFormat.yMd().format(_startDate)} - ${DateFormat.yMd().format(_endDate)}'),
                trailing: const Icon(Icons.edit),
                onTap: () => _selectDateRange(context),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: Text(_selectAll ? l10n.deselectAll : l10n.selectAll),
              value: _selectAll,
              onChanged: _toggleSelectAll,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Divider(),
            SwitchListTile(
              title: Text(l10n.includeSymptoms),
              value: _includeSymptoms,
              onChanged: (val) {
                setState(() => _includeSymptoms = val);
                _updateSelectAllState();
              },
            ),
            SwitchListTile(
              title: Text(l10n.includeMedications),
              value: _includeMedications,
              onChanged: (val) {
                setState(() => _includeMedications = val);
                _updateSelectAllState();
              },
            ),
            SwitchListTile(
              title: Text(l10n.includeAllergies),
              value: _includeAllergies,
              onChanged: (val) {
                setState(() => _includeAllergies = val);
                _updateSelectAllState();
              },
            ),
            SwitchListTile(
              title: Text(l10n.includeDocuments),
              value: _includeDocuments,
              onChanged: (val) {
                setState(() => _includeDocuments = val);
                _updateSelectAllState();
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchPreviewData,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(l10n.showTimeline), // Using an existing key "Show Timeline"
            ),
            if (_previewData != null) ...[
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              ReportPreviewWidget(data: _previewData!),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _isGeneratingPdf ? null : _generatePdf,
                icon: _isGeneratingPdf
                    ? const SizedBox(
                        width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.picture_as_pdf),
                label: Text(l10n.generatePdf),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
