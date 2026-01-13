import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/event/application/event_controller.dart';

class SymptomLogScreen extends ConsumerStatefulWidget {
  const SymptomLogScreen({super.key});

  @override
  ConsumerState<SymptomLogScreen> createState() => _SymptomLogScreenState();
}

class _SymptomLogScreenState extends ConsumerState<SymptomLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  final _frequencyController = TextEditingController(text: '1');
  DateTime _selectedDateTime = DateTime.now();
  String? _selectedType;

  @override
  void dispose() {
    _notesController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(eventControllerProvider.notifier).addEvent(
            type: _selectedType!,
            timestamp: _selectedDateTime,
            frequency: int.tryParse(_frequencyController.text) ?? 1,
            notes: _notesController.text,
          );
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.symptomLogTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: l10n.eventTypeLabel,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'Vomiting', child: Text(l10n.eventTypeVomiting)),
                  DropdownMenuItem(value: 'Diarrhea', child: Text(l10n.eventTypeDiarrhea)),
                  DropdownMenuItem(value: 'Appetite', child: Text(l10n.eventTypeAppetite)),
                  DropdownMenuItem(value: 'Behavior', child: Text(l10n.eventTypeBehavior)),
                  DropdownMenuItem(value: 'Other', child: Text(l10n.eventTypeOther)),
                ],
                onChanged: (value) => setState(() => _selectedType = value),
                validator: (value) => value == null ? l10n.eventTypeError : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(l10n.eventDateLabel),
                subtitle: Text(DateFormat.yMd().add_Hm().format(_selectedDateTime)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDateTime,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null && context.mounted) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
                    );
                    if (time != null) {
                      setState(() {
                        _selectedDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _frequencyController,
                decoration: InputDecoration(
                  labelText: l10n.frequencyLabel,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: l10n.notesLabel,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text(l10n.capture),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
