import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../features/feeding/application/feeding_controller.dart';

class FeedingPlanScreen extends ConsumerStatefulWidget {
  const FeedingPlanScreen({super.key});

  @override
  ConsumerState<FeedingPlanScreen> createState() => _FeedingPlanScreenState();
}

class _FeedingPlanScreenState extends ConsumerState<FeedingPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _foodTypeController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final List<TimeOfDay> _reminderTimes = [];

  @override
  void dispose() {
    _foodTypeController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _addTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _reminderTimes.add(time);
        _reminderTimes.sort((a, b) {
          if (a.hour != b.hour) return a.hour.compareTo(b.hour);
          return a.minute.compareTo(b.minute);
        });
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_reminderTimes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bitte mindestens eine Zeit hinzufügen')),
        );
        return;
      }

      await ref.read(feedingControllerProvider.notifier).createFeedingSchedule(
            foodType: _foodTypeController.text,
            amount: _amountController.text,
            reminderTimes: _reminderTimes
                .map((t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}')
                .toList(),
            notes: _notesController.text,
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
        title: Text(l10n.feedingPlanTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _foodTypeController,
                decoration: InputDecoration(
                  labelText: l10n.foodTypeLabel,
                  border: const OutlineInputBorder(),
                  hintText: 'z.B. Nassfutter',
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? l10n.foodTypeLabel : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: l10n.amountLabel,
                  border: const OutlineInputBorder(),
                  hintText: 'z.B. 100g',
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? l10n.amountLabel : null,
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
                        onDeleted: () => setState(() => _reminderTimes.remove(time)),
                      )),
                  ActionChip(
                    avatar: const Icon(Icons.add),
                    label: Text(l10n.addReminderTime),
                    onPressed: _addTime,
                  ),
                ],
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
                child: Text(l10n.createPlan),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
