import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../features/medication/application/medication_controller.dart';
import '../../features/medication/domain/medication.dart';
import '../../features/feeding/application/feeding_controller.dart';
import '../../features/feeding/domain/feeding.dart';

class TodaySection extends ConsumerWidget {
  const TodaySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final medicationState = ref.watch(medicationControllerProvider);
    final feedingState = ref.watch(feedingControllerProvider);

    return medicationState.when(
      data: (medSchedules) {
        return feedingState.when(
          data: (feedSchedules) {
            final activeMedSchedules = medSchedules.where((s) => s.isActive).toList();
            final activeFeedSchedules = feedSchedules.where((s) => s.isActive).toList();

            if (activeMedSchedules.isEmpty && activeFeedSchedules.isEmpty) {
              return _EmptyTodayState();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.todayFocus,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 12),
                if (activeMedSchedules.isNotEmpty) ...[
                  Text(
                    l10n.medicationToday,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ...activeMedSchedules.map((s) => _TodayMedicationTile(schedule: s)),
                  const SizedBox(height: 16),
                ],
                if (activeFeedSchedules.isNotEmpty) ...[
                  Text(
                    l10n.feedingToday,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ...activeFeedSchedules.map((s) => _TodayFeedingTile(schedule: s)),
                ],
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Text('Error: $err'),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Text('Error: $err'),
    );
  }
}

class _EmptyTodayState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.celebration_rounded,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.allDone,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}

class _TodayMedicationTile extends ConsumerWidget {
  final MedicationSchedule schedule;
  const _TodayMedicationTile({required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIns = ref.watch(medicationCheckInsProvider(schedule.id!));
    final l10n = AppLocalizations.of(context)!;

    return checkIns.when(
      data: (items) {
        final today = DateTime.now();
        final todayCheckIn = items.where((ci) =>
            ci.timestamp.year == today.year &&
            ci.timestamp.month == today.month &&
            ci.timestamp.day == today.day).firstOrNull;
        
        final alreadyTaken = todayCheckIn != null;

        return Card(
          elevation: alreadyTaken ? 0 : 2,
          color: alreadyTaken ? Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(100) : null,
          child: ListTile(
            leading: Icon(
              Icons.medication,
              color: alreadyTaken ? Theme.of(context).colorScheme.primary.withAlpha(150) : Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              schedule.medicationName,
              style: TextStyle(
                decoration: alreadyTaken ? TextDecoration.lineThrough : null,
                color: alreadyTaken ? Theme.of(context).colorScheme.onSurfaceVariant : null,
              ),
            ),
            subtitle: Text('${schedule.dosage} - ${schedule.frequency}'),
            trailing: alreadyTaken
                ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                : IconButton(
                    icon: const Icon(Icons.radio_button_unchecked),
                    onPressed: () async {
                      await ref.read(medicationControllerProvider.notifier).checkIn(
                            scheduleId: schedule.id!,
                            plannedTimestamp: DateTime.now(),
                          );
                      ref.invalidate(medicationCheckInsProvider(schedule.id!));
                      
                      if (context.mounted) {
                        final messenger = ScaffoldMessenger.of(context);
                        messenger.clearSnackBars();
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text(l10n.medicationConfirmed),
                            behavior: SnackBarBehavior.floating,
                            width: 200,
                            duration: const Duration(seconds: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                        );
                      }
                    },
                  ),
          ),
        );
      },
      loading: () => const SizedBox(height: 72, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const Icon(Icons.error),
    );
  }
}

class _TodayFeedingTile extends ConsumerWidget {
  final FeedingSchedule schedule;
  const _TodayFeedingTile({required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIns = ref.watch(feedingCheckInsProvider(schedule.id!));
    final l10n = AppLocalizations.of(context)!;

    return checkIns.when(
      data: (items) {
        final today = DateTime.now();
        final todayCheckIn = items.where((ci) =>
            ci.timestamp.year == today.year &&
            ci.timestamp.month == today.month &&
            ci.timestamp.day == today.day).firstOrNull;
            
        final alreadyFed = todayCheckIn != null;

        return Card(
          elevation: alreadyFed ? 0 : 2,
          color: alreadyFed ? Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(100) : null,
          child: ListTile(
            leading: Icon(
              Icons.restaurant,
              color: alreadyFed ? Theme.of(context).colorScheme.primary.withAlpha(150) : Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              schedule.foodType,
              style: TextStyle(
                decoration: alreadyFed ? TextDecoration.lineThrough : null,
                color: alreadyFed ? Theme.of(context).colorScheme.onSurfaceVariant : null,
              ),
            ),
            subtitle: Text(schedule.amount),
            trailing: alreadyFed
                ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                : IconButton(
                    icon: const Icon(Icons.radio_button_unchecked),
                    onPressed: () async {
                      await ref.read(feedingControllerProvider.notifier).checkIn(
                            scheduleId: schedule.id!,
                            plannedTimestamp: DateTime.now(),
                          );
                      ref.invalidate(feedingCheckInsProvider(schedule.id!));
                      
                      if (context.mounted) {
                        final messenger = ScaffoldMessenger.of(context);
                        messenger.clearSnackBars();
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text(l10n.feedingConfirmed),
                            behavior: SnackBarBehavior.floating,
                            width: 200,
                            duration: const Duration(seconds: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                        );
                      }
                    },
                  ),
          ),
        );
      },
      loading: () => const SizedBox(height: 72, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const Icon(Icons.error),
    );
  }
}
