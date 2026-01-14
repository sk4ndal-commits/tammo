import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/medication/application/medication_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/toast_utils.dart';

class MedicationPlanScreen extends ConsumerStatefulWidget {
  const MedicationPlanScreen({super.key});

  @override
  ConsumerState<MedicationPlanScreen> createState() => _MedicationPlanScreenState();
}

class _MedicationPlanScreenState extends ConsumerState<MedicationPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  
  String _frequency = '1x'; // '1x', '2x', 'individual'
  final Map<String, bool> _dayTimes = {
    'morning': true,
    'noon': false,
    'evening': false,
  };
  final List<TimeOfDay> _customTimes = [];
  
  DateTime _startDate = DateTime.now();
  bool _isStartDateToday = true;
  
  DateTime? _endDate;
  bool _isUnlimited = true;

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  void _updateFrequency(String? value) {
    if (value == null) return;
    setState(() {
      _frequency = value;
      if (value == '1x') {
        _dayTimes['morning'] = true;
        _dayTimes['noon'] = false;
        _dayTimes['evening'] = false;
        _customTimes.clear();
      } else if (value == '2x') {
        _dayTimes['morning'] = true;
        _dayTimes['noon'] = false;
        _dayTimes['evening'] = true;
        _customTimes.clear();
      }
    });
  }

  Future<void> _selectCustomTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _customTimes.add(time);
        _customTimes.sort((a, b) => a.hour.compareTo(b.hour) == 0 
            ? a.minute.compareTo(b.minute) 
            : a.hour.compareTo(b.hour));
      });
    }
  }

  Future<void> _selectDate(bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : (_endDate ?? DateTime.now().add(const Duration(days: 7))),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _isStartDateToday = _isToday(picked);
        } else {
          _endDate = picked;
          _isUnlimited = false;
        }
      });
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  List<TimeOfDay> _getEffectiveTimes() {
    final List<TimeOfDay> times = [];
    if (_frequency == 'individual') {
      if (_dayTimes['morning']!) times.add(const TimeOfDay(hour: 8, minute: 0));
      if (_dayTimes['noon']!) times.add(const TimeOfDay(hour: 12, minute: 0));
      if (_dayTimes['evening']!) times.add(const TimeOfDay(hour: 18, minute: 0));
      times.addAll(_customTimes);
    } else if (_frequency == '1x') {
      times.add(const TimeOfDay(hour: 8, minute: 0));
    } else if (_frequency == '2x') {
      times.add(const TimeOfDay(hour: 8, minute: 0));
      times.add(const TimeOfDay(hour: 20, minute: 0));
    }
    times.sort((a, b) => a.hour.compareTo(b.hour) == 0 
        ? a.minute.compareTo(b.minute) 
        : a.hour.compareTo(b.hour));
    return times;
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final effectiveTimes = _getEffectiveTimes();
    if (effectiveTimes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte mindestens eine Zeit auswählen')),
      );
      return;
    }

    final reminderTimeStrings = effectiveTimes.map((t) => 
        '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}'
    ).toList();

    final l10n = AppLocalizations.of(context)!;
    String freqText = _frequency == '1x' ? l10n.freqOnceDaily : (_frequency == '2x' ? l10n.freqTwiceDaily : l10n.freqIndividual);

    await ref.read(medicationControllerProvider.notifier).createSchedule(
      medicationName: _nameController.text,
      dosage: _dosageController.text,
      frequency: freqText,
      startDate: _startDate,
      endDate: _isUnlimited ? null : _endDate,
      reminderTimes: reminderTimeStrings,
    );

    if (mounted) {
      ToastUtils.showSuccessToast(context, l10n.planCreated);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final petName = ref.watch(petControllerProvider).maybeWhen(
      data: (state) => state.activePet?.name,
      orElse: () => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.medicationPlanTitle),
            if (petName != null)
              Text(
                petName,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInfoBanner(l10n, theme),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSectionHeader(l10n.stepWhat, theme),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: l10n.medicationNameLabel,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.medication_rounded),
                      ),
                      validator: (value) => (value == null || value.isEmpty) ? l10n.petNameError : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dosageController,
                      decoration: InputDecoration(
                        labelText: l10n.dosageLabel,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.straighten_rounded),
                      ),
                      validator: (value) => (value == null || value.isEmpty) ? l10n.petNameError : null,
                    ),
                    
                    const SizedBox(height: 32),
                    _buildSectionHeader(l10n.stepHowOften, theme),
                    const SizedBox(height: 8),
                    _buildFrequencyOptions(l10n, theme),
                    
                    const SizedBox(height: 32),
                    _buildSectionHeader(l10n.stepWhen, theme),
                    const SizedBox(height: 8),
                    _buildWhenOptions(l10n, theme),
                    
                    const SizedBox(height: 32),
                    _buildSectionHeader(l10n.stepStart, theme),
                    const SizedBox(height: 8),
                    _buildStartOptions(l10n, theme),
                    
                    const SizedBox(height: 32),
                    _buildSectionHeader(l10n.stepDuration, theme),
                    const SizedBox(height: 8),
                    _buildDurationOptions(l10n, theme),

                    const SizedBox(height: 40),
                    _buildPreview(l10n, theme),
                    
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(l10n.createPlan, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBanner(AppLocalizations l10n, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.primaryContainer.withAlpha(50),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.planEditHint,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
    );
  }

  Widget _buildFrequencyOptions(AppLocalizations l10n, ThemeData theme) {
    return Column(
      children: [
        RadioListTile<String>(
          title: Text(l10n.freqOnceDaily),
          value: '1x',
          groupValue: _frequency,
          onChanged: _updateFrequency,
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<String>(
          title: Text(l10n.freqTwiceDaily),
          value: '2x',
          groupValue: _frequency,
          onChanged: _updateFrequency,
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<String>(
          title: Text(l10n.freqIndividual),
          value: 'individual',
          groupValue: _frequency,
          onChanged: _updateFrequency,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildWhenOptions(AppLocalizations l10n, ThemeData theme) {
    if (_frequency != 'individual') {
      final times = _getEffectiveTimes();
      return Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Wrap(
          spacing: 8,
          children: times.map((t) => Chip(label: Text(t.format(context)))).toList(),
        ),
      );
    }

    return Column(
      children: [
        CheckboxListTile(
          title: Text(l10n.timeMorning),
          value: _dayTimes['morning'],
          onChanged: (v) => setState(() => _dayTimes['morning'] = v ?? false),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          title: Text(l10n.timeNoon),
          value: _dayTimes['noon'],
          onChanged: (v) => setState(() => _dayTimes['noon'] = v ?? false),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          title: Text(l10n.timeEvening),
          value: _dayTimes['evening'],
          onChanged: (v) => setState(() => _dayTimes['evening'] = v ?? false),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            ..._customTimes.map((time) => Chip(
                  label: Text(time.format(context)),
                  onDeleted: () => setState(() => _customTimes.remove(time)),
                )),
            ActionChip(
              avatar: const Icon(Icons.add, size: 18),
              label: Text(l10n.addTime),
              onPressed: _selectCustomTime,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStartOptions(AppLocalizations l10n, ThemeData theme) {
    return Column(
      children: [
        RadioListTile<bool>(
          title: Text(l10n.startToday),
          value: true,
          groupValue: _isStartDateToday,
          onChanged: (v) {
            if (v == true) {
              setState(() {
                _isStartDateToday = true;
                _startDate = DateTime.now();
              });
            }
          },
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<bool>(
          title: Row(
            children: [
              Text(l10n.startPickDate),
              if (!_isStartDateToday) ...[
                const SizedBox(width: 8),
                Text('(${DateFormat.yMd().format(_startDate)})', style: theme.textTheme.bodySmall),
              ],
            ],
          ),
          value: false,
          groupValue: _isStartDateToday,
          onChanged: (v) {
            if (v == false) {
              _selectDate(true);
            }
          },
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildDurationOptions(AppLocalizations l10n, ThemeData theme) {
    return Column(
      children: [
        RadioListTile<bool>(
          title: Text(l10n.durationUnlimited),
          value: true,
          groupValue: _isUnlimited,
          onChanged: (v) => setState(() => _isUnlimited = v ?? true),
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<bool>(
          title: Row(
            children: [
              Text(l10n.durationUntil),
              if (!_isUnlimited && _endDate != null) ...[
                const SizedBox(width: 8),
                Text('(${DateFormat.yMd().format(_endDate!)})', style: theme.textTheme.bodySmall),
              ],
            ],
          ),
          value: false,
          groupValue: _isUnlimited,
          onChanged: (v) {
            if (v == false) {
              _selectDate(false);
            }
          },
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildPreview(AppLocalizations l10n, ThemeData theme) {
    final times = _getEffectiveTimes();
    if (times.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(50),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.visibility_outlined, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(l10n.previewTitle, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          _buildPreviewRow(l10n.previewToday, times, theme),
          const SizedBox(height: 8),
          _buildPreviewRow(l10n.previewTomorrow, times, theme),
        ],
      ),
    );
  }

  Widget _buildPreviewRow(String label, List<TimeOfDay> times, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 70, child: Text(label, style: theme.textTheme.bodySmall)),
        Expanded(
          child: Text(
            times.map((t) => t.format(context)).join(', '),
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
