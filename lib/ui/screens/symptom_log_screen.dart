import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/event/application/event_controller.dart';
import '../../features/event/application/event_preferences_controller.dart';

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

  void _onTypeSelected(String type) {
    setState(() {
      _selectedType = type;
      
      // Load preferences for this type
      final prefs = ref.read(eventPreferencesProvider);
      final lastFreq = prefs.lastFrequencies[type] ?? 1;
      final lastNote = prefs.lastNotes[type] ?? '';
      
      _frequencyController.text = lastFreq.toString();
      _notesController.text = lastNote;
    });
  }

  Future<void> _submit() async {
    if (_selectedType == null) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.eventTypeError)),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      final frequency = int.tryParse(_frequencyController.text) ?? 1;
      final notes = _notesController.text;

      await ref.read(eventControllerProvider.notifier).addEvent(
            type: _selectedType!,
            timestamp: _selectedDateTime,
            frequency: frequency,
            notes: notes,
          );

      // Save preferences
      await ref.read(eventPreferencesProvider.notifier).saveLastValues(
            type: _selectedType!,
            frequency: frequency,
            notes: notes,
          );

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        final messenger = ScaffoldMessenger.of(context);

        Navigator.of(context).pop();

        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.eventLogged),
            behavior: SnackBarBehavior.floating,
            width: 200,
            duration: const Duration(seconds: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.symptomLogTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.eventTypeLabel,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _SymptomTypeCard(
                          type: 'Vomiting',
                          label: l10n.eventTypeVomiting,
                          icon: Icons.warning_amber_rounded,
                          isSelected: _selectedType == 'Vomiting',
                          onTap: () => _onTypeSelected('Vomiting'),
                        ),
                        _SymptomTypeCard(
                          type: 'Diarrhea',
                          label: l10n.eventTypeDiarrhea,
                          icon: Icons.water_drop,
                          isSelected: _selectedType == 'Diarrhea',
                          onTap: () => _onTypeSelected('Diarrhea'),
                        ),
                        _SymptomTypeCard(
                          type: 'Appetite',
                          label: l10n.eventTypeAppetite,
                          icon: Icons.restaurant,
                          isSelected: _selectedType == 'Appetite',
                          onTap: () => _onTypeSelected('Appetite'),
                        ),
                        _SymptomTypeCard(
                          type: 'Behavior',
                          label: l10n.eventTypeBehavior,
                          icon: Icons.psychology,
                          isSelected: _selectedType == 'Behavior',
                          onTap: () => _onTypeSelected('Behavior'),
                        ),
                        _SymptomTypeCard(
                          type: 'Other',
                          label: l10n.eventTypeOther,
                          icon: Icons.event,
                          isSelected: _selectedType == 'Other',
                          onTap: () => _onTypeSelected('Other'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
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
                        prefixIcon: const Icon(Icons.repeat),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: l10n.notesLabel,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.note_alt_rounded),
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
              ),
              child: Text(l10n.capture),
            ),
          ),
        ],
      ),
    );
  }
}

class _SymptomTypeCard extends StatelessWidget {
  final String type;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SymptomTypeCard({
    required this.type,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: isSelected ? 4 : 0,
      color: isSelected 
          ? colorScheme.primaryContainer 
          : colorScheme.surfaceContainerHighest.withAlpha(128),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSelected 
            ? BorderSide(color: colorScheme.primary, width: 2) 
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
