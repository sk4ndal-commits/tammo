import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
  int _currentStep = 0;
  
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _frequencyController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  final List<TimeOfDay> _reminderTimes = [const TimeOfDay(hour: 8, minute: 0)];

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _addTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && !_reminderTimes.contains(picked)) {
      setState(() {
        _reminderTimes.add(picked);
        _reminderTimes.sort((a, b) => a.hour.compareTo(b.hour) == 0 
            ? a.minute.compareTo(b.minute) 
            : a.hour.compareTo(b.hour));
      });
    }
  }

  void _submit() async {
    final reminderTimeStrings = _reminderTimes.map((t) => 
        '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}'
    ).toList();

    await ref.read(medicationControllerProvider.notifier).createSchedule(
      medicationName: _nameController.text,
      dosage: _dosageController.text,
      frequency: _frequencyController.text,
      startDate: _startDate,
      endDate: _endDate,
      reminderTimes: reminderTimeStrings,
    );

    if (mounted) {
      ToastUtils.showSuccessToast(context, AppLocalizations.of(context)!.planCreated);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.medicationPlanTitle),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.planEditHint,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Stepper(
                type: StepperType.vertical,
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < 2) {
                    final isValid = _formKey.currentState?.validate() ?? false;
                    if (isValid) {
                      setState(() => _currentStep++);
                    }
                  } else {
                    _submit();
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                  } else {
                    context.pop();
                  }
                },
                controlsBuilder: (context, controls) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: controls.onStepContinue,
                          child: Text(_currentStep == 2 ? l10n.createPlan : l10n.next),
                        ),
                        const SizedBox(width: 12),
                        if (_currentStep > 0)
                          TextButton(
                            onPressed: controls.onStepCancel,
                            child: Text(l10n.back),
                          )
                        else
                          TextButton(
                            onPressed: () => context.pop(),
                            child: Text(l10n.delete), // "Löschen" or "Abbrechen"
                          ),
                      ],
                    ),
                  );
                },
                steps: [
                  Step(
                    title: Text(l10n.stepWhat),
                    isActive: _currentStep >= 0,
                    state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.requiredLabel, style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: l10n.medicationNameLabel,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) => (_currentStep == 0 && (value == null || value.isEmpty)) ? l10n.petNameError : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _dosageController,
                          decoration: InputDecoration(
                            labelText: l10n.dosageLabel,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) => (_currentStep == 0 && (value == null || value.isEmpty)) ? l10n.petNameError : null,
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: Text(l10n.stepHowOften),
                    isActive: _currentStep >= 1,
                    state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.requiredLabel, style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _frequencyController,
                          decoration: InputDecoration(
                            labelText: l10n.frequencyLabelMedication,
                            border: const OutlineInputBorder(),
                            hintText: 'z.B. 1x täglich',
                          ),
                          validator: (value) => (_currentStep == 1 && (value == null || value.isEmpty)) ? l10n.petNameError : null,
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 8),
                        Text(l10n.optionalLabel, style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(height: 8),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.startDateLabel),
                          subtitle: Text(DateFormat.yMd().format(_startDate)),
                          trailing: const Icon(Icons.calendar_today),
                          onTap: () => _selectDate(context, true),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.endDateLabel),
                          subtitle: Text(_endDate == null ? l10n.later : DateFormat.yMd().format(_endDate!)),
                          trailing: const Icon(Icons.event_available),
                          onTap: () => _selectDate(context, false),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: Text(l10n.stepWhen),
                    isActive: _currentStep >= 2,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.optionalLabel, style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(height: 8),
                        Text(
                          l10n.reminderTimesLabel,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            ..._reminderTimes.map((time) => Chip(
                                  label: Text(time.format(context)),
                                  onDeleted: _reminderTimes.length > 1
                                      ? () {
                                          setState(() {
                                            _reminderTimes.remove(time);
                                          });
                                        }
                                      : null,
                                )),
                            ActionChip(
                              avatar: const Icon(Icons.add, size: 18),
                              label: Text(l10n.addReminderTime),
                              onPressed: () => _addTime(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
