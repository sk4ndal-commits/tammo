import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/medication/application/medication_controller.dart';

class MedicationPlanScreen extends ConsumerStatefulWidget {
  const MedicationPlanScreen({super.key});

  @override
  ConsumerState<MedicationPlanScreen> createState() => _MedicationPlanScreenState();
}

class _MedicationPlanScreenState extends ConsumerState<MedicationPlanScreen> {
  final _formKey = GlobalKey<FormState>();
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
    if (_formKey.currentState?.validate() ?? false) {
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
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.medicationPlanTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.medicationNameLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty) ? l10n.petNameError : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dosageController,
                decoration: InputDecoration(
                  labelText: l10n.dosageLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty) ? l10n.petNameError : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _frequencyController,
                decoration: InputDecoration(
                  labelText: l10n.frequencyLabelMedication,
                  border: const OutlineInputBorder(),
                  hintText: 'z.B. 1x täglich',
                ),
                validator: (value) => (value == null || value.isEmpty) ? l10n.petNameError : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _selectDate(context, true),
                      icon: const Icon(Icons.calendar_today),
                      label: Text('${l10n.startDateLabel}: ${DateFormat.yMd().format(_startDate)}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _selectDate(context, false),
                      icon: const Icon(Icons.event_available),
                      label: Text(_endDate == null 
                          ? l10n.endDateLabel 
                          : '${l10n.endDateLabel}: ${DateFormat.yMd().format(_endDate!)}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
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
                    onDeleted: _reminderTimes.length > 1 ? () {
                      setState(() {
                        _reminderTimes.remove(time);
                      });
                    } : null,
                  )),
                  ActionChip(
                    avatar: const Icon(Icons.add, size: 18),
                    label: Text(l10n.addReminderTime),
                    onPressed: () => _addTime(context),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: Text(l10n.createPlan),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
