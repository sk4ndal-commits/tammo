import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../features/medication/application/medication_controller.dart';
import '../../features/medication/domain/medication.dart';
import '../../features/feeding/application/feeding_controller.dart';
import '../../features/feeding/domain/feeding.dart';
import '../../features/pet/application/pet_controller.dart';
import 'medication_plan_screen.dart';
import 'feeding_plan_screen.dart';

class PlanListScreen extends ConsumerWidget {
  const PlanListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final medState = ref.watch(medicationControllerProvider);
    final feedState = ref.watch(feedingControllerProvider);
    final petName = ref.watch(petControllerProvider).maybeWhen(
      data: (state) => state.activePet?.name,
      orElse: () => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.createPlans),
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
      body: medState.when(
        data: (meds) => feedState.when(
          data: (feeds) {
            if (meds.isEmpty && feeds.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 64, color: theme.colorScheme.outline.withAlpha(100)),
                    const SizedBox(height: 16),
                    Text(l10n.noEntriesYet, style: theme.textTheme.titleMedium),
                  ],
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (meds.isNotEmpty) ...[
                  Text(l10n.medicationPlanTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...meds.map((m) => _MedicationPlanTile(schedule: m)),
                  const SizedBox(height: 24),
                ],
                if (feeds.isNotEmpty) ...[
                  Text(l10n.feedingPlanTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...feeds.map((f) => _FeedingPlanTile(schedule: f)),
                ],
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _MedicationPlanTile extends ConsumerWidget {
  final MedicationSchedule schedule;
  const _MedicationPlanTile({required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: schedule.isActive ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
          child: Icon(Icons.medication_rounded, color: schedule.isActive ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant),
        ),
        title: Text(schedule.medicationName, style: TextStyle(fontWeight: schedule.isActive ? FontWeight.bold : FontWeight.normal)),
        subtitle: Text('${schedule.dosage} • ${schedule.frequency}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedicationPlanScreen(schedule: schedule),
            ),
          );
        },
      ),
    );
  }
}

class _FeedingPlanTile extends ConsumerWidget {
  final FeedingSchedule schedule;
  const _FeedingPlanTile({required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: schedule.isActive ? theme.colorScheme.secondaryContainer : theme.colorScheme.surfaceContainerHighest,
          child: Icon(Icons.restaurant_rounded, color: schedule.isActive ? theme.colorScheme.secondary : theme.colorScheme.onSurfaceVariant),
        ),
        title: Text(schedule.foodType, style: TextStyle(fontWeight: schedule.isActive ? FontWeight.bold : FontWeight.normal)),
        subtitle: Text(schedule.amount),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeedingPlanScreen(schedule: schedule),
            ),
          );
        },
      ),
    );
  }
}
