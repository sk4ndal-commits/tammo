import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../features/medication/application/medication_controller.dart';
import '../../features/medication/domain/medication.dart';
import '../../features/feeding/application/feeding_controller.dart';
import '../../features/feeding/domain/feeding.dart';
import '../widgets/toast_utils.dart';

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
              return _EmptyTodayState(allDone: false);
            }

            return _TodayContent(
              medSchedules: activeMedSchedules,
              feedSchedules: activeFeedSchedules,
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

class _TodayContent extends ConsumerWidget {
  final List<MedicationSchedule> medSchedules;
  final List<FeedingSchedule> feedSchedules;

  const _TodayContent({
    required this.medSchedules,
    required this.feedSchedules,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final today = DateTime.now();

    final List<Widget> openTasks = [];
    final List<Widget> completedTasks = [];

    for (final schedule in medSchedules) {
      // Check if rule is valid today
      final isStarted = schedule.startDate.isBefore(today) || 
          (schedule.startDate.year == today.year && schedule.startDate.month == today.month && schedule.startDate.day == today.day);
      final isNotEnded = schedule.endDate == null || schedule.endDate!.isAfter(today) ||
          (schedule.endDate!.year == today.year && schedule.endDate!.month == today.month && schedule.endDate!.day == today.day);

      if (!isStarted || !isNotEnded) continue;

      final checkIns = ref.watch(medicationCheckInsProvider(schedule.id!)).valueOrNull ?? [];
      final alreadyTaken = checkIns.any((ci) =>
          ci.timestamp.year == today.year &&
          ci.timestamp.month == today.month &&
          ci.timestamp.day == today.day);

            if (alreadyTaken) {
        completedTasks.add(_TodayMedicationTile(
          schedule: schedule, 
          isCompleted: true,
          plannedTime: _getPlannedTimeForSchedule(schedule, today, checkIns),
        ));
      } else {
        openTasks.add(_TodayMedicationTile(
          schedule: schedule, 
          isCompleted: false,
          plannedTime: _getPlannedTimeForSchedule(schedule, today, checkIns),
        ));
      }
    }

    for (final schedule in feedSchedules) {
      // Feeding schedules currently don't have start/end dates in the model, 
      // but they are rules that are always active if isActive is true.
      
      final checkIns = ref.watch(feedingCheckInsProvider(schedule.id!)).valueOrNull ?? [];
      final alreadyFed = checkIns.any((ci) =>
          ci.timestamp.year == today.year &&
          ci.timestamp.month == today.month &&
          ci.timestamp.day == today.day);

      if (alreadyFed) {
        completedTasks.add(_TodayFeedingTile(
          schedule: schedule, 
          isCompleted: true,
          plannedTime: _getPlannedTimeForFeeding(schedule, today, checkIns),
        ));
      } else {
        openTasks.add(_TodayFeedingTile(
          schedule: schedule, 
          isCompleted: false,
          plannedTime: _getPlannedTimeForFeeding(schedule, today, checkIns),
        ));
      }
    }

    if (openTasks.isEmpty && completedTasks.isEmpty) {
      return _EmptyTodayState(allDone: false);
    }

    if (openTasks.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _EmptyTodayState(allDone: true),
          if (completedTasks.isNotEmpty) ...[
            const SizedBox(height: 24),
            _SectionHeader(title: l10n.todayFocus), // Or something like "Today's history"
            ...completedTasks,
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SectionHeader(title: l10n.todayFocus, isUrgent: true),
            TextButton.icon(
              onPressed: () => context.push('/plans'),
              icon: const Icon(Icons.settings_outlined, size: 18),
              label: Text(l10n.managePets, style: const TextStyle(fontSize: 12)), // "Verwalten" would be better, but l10n.managePets is "Tiere verwalten"
            ),
          ],
        ),
        ...openTasks,
        if (completedTasks.isNotEmpty) ...[
          const SizedBox(height: 24),
          _SectionHeader(title: l10n.allDone), 
          ...completedTasks,
        ],
      ],
    );
  }

  String _getPlannedTimeForSchedule(MedicationSchedule schedule, DateTime today, List<MedicationCheckIn> checkIns) {
    if (schedule.reminderTimes.isEmpty) return '';
    // If it's 1x or 2x, they have standard times.
    // If it's multiple, we might want to show the NEXT one, but for now let's just show the first/main one or "Multiple"
    if (schedule.reminderTimes.length == 1) return schedule.reminderTimes.first;
    
    // Find first one not yet checked in today?
    // Actually, US just says "see the due time". If there are multiple due times, which one?
    // For now, let's just list them or show the next one.
    return schedule.reminderTimes.join(', ');
  }

  String _getPlannedTimeForFeeding(FeedingSchedule schedule, DateTime today, List<FeedingCheckIn> checkIns) {
    if (schedule.reminderTimes.isEmpty) return '';
    if (schedule.reminderTimes.length == 1) return schedule.reminderTimes.first;
    return schedule.reminderTimes.join(', ');
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool isUrgent;

  const _SectionHeader({required this.title, this.isUrgent = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isUrgent ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
            ),
      ),
    );
  }
}

class _EmptyTodayState extends StatelessWidget {
  final bool allDone;
  const _EmptyTodayState({required this.allDone});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          decoration: BoxDecoration(
            color: allDone 
                ? Theme.of(context).colorScheme.primaryContainer.withAlpha(40)
                : Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(40),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: allDone 
                  ? Theme.of(context).colorScheme.primary.withAlpha(40)
                  : Theme.of(context).colorScheme.outlineVariant.withAlpha(40),
            ),
          ),
          child: Column(
            children: [
              Icon(
                allDone ? Icons.check_circle_rounded : Icons.calendar_today_rounded,
                size: 48,
                color: allDone ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                allDone ? l10n.allDone : l10n.noEntriesYet,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: allDone ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          ),
        ),
        if (!allDone) ...[
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => GoRouter.of(context).push('/plans'),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.createPlans),
          ),
        ],
      ],
    );
  }
}

class _TodayMedicationTile extends ConsumerWidget {
  final MedicationSchedule schedule;
  final bool isCompleted;
  final String plannedTime;
  const _TodayMedicationTile({
    required this.schedule, 
    required this.isCompleted,
    required this.plannedTime,
  });

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
          elevation: alreadyTaken ? 0 : 1,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: alreadyTaken ? BorderSide.none : BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 0.5),
          ),
          color: alreadyTaken ? Theme.of(context).colorScheme.surfaceContainerLowest : null,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: CircleAvatar(
              backgroundColor: alreadyTaken 
                  ? Theme.of(context).colorScheme.primary.withAlpha(30)
                  : Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.medication_rounded,
                color: alreadyTaken ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            title: Text(
              schedule.medicationName,
              style: TextStyle(
                fontWeight: alreadyTaken ? FontWeight.normal : FontWeight.bold,
                decoration: alreadyTaken ? TextDecoration.lineThrough : null,
                color: alreadyTaken ? Theme.of(context).colorScheme.outline : null,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${schedule.dosage} • ${schedule.frequency}'),
                if (plannedTime.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 14, color: alreadyTaken ? Theme.of(context).colorScheme.outline : Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          plannedTime,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: alreadyTaken ? Theme.of(context).colorScheme.outline : Theme.of(context).colorScheme.primary,
                            fontWeight: alreadyTaken ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                alreadyTaken ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                color: alreadyTaken ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              onPressed: () async {
                final controller = ref.read(medicationControllerProvider.notifier);
                if (alreadyTaken) {
                  await controller.undoCheckIn(todayCheckIn.id!, schedule.id!);
                } else {
                  await controller.checkIn(
                    scheduleId: schedule.id!,
                    plannedTimestamp: DateTime.now(),
                  );

                  if (context.mounted) {
                    ToastUtils.showSuccessToast(context, l10n.medicationConfirmed);
                  }
                }
              },
            ),
          ),
        );
      },
      loading: () => const SizedBox(height: 72),
      error: (_, __) => const Icon(Icons.error),
    );
  }
}

class _TodayFeedingTile extends ConsumerWidget {
  final FeedingSchedule schedule;
  final bool isCompleted;
  final String plannedTime;
  const _TodayFeedingTile({
    required this.schedule, 
    required this.isCompleted,
    required this.plannedTime,
  });

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
          elevation: alreadyFed ? 0 : 1,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: alreadyFed ? BorderSide.none : BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 0.5),
          ),
          color: alreadyFed ? Theme.of(context).colorScheme.surfaceContainerLowest : null,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: CircleAvatar(
              backgroundColor: alreadyFed 
                  ? Theme.of(context).colorScheme.primary.withAlpha(30)
                  : Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.restaurant_rounded,
                color: alreadyFed ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            title: Text(
              schedule.foodType,
              style: TextStyle(
                fontWeight: alreadyFed ? FontWeight.normal : FontWeight.bold,
                decoration: alreadyFed ? TextDecoration.lineThrough : null,
                color: alreadyFed ? Theme.of(context).colorScheme.outline : null,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(schedule.amount),
                if (plannedTime.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 14, color: alreadyFed ? Theme.of(context).colorScheme.outline : Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          plannedTime,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: alreadyFed ? Theme.of(context).colorScheme.outline : Theme.of(context).colorScheme.primary,
                            fontWeight: alreadyFed ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                alreadyFed ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                color: alreadyFed ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              onPressed: () async {
                final controller = ref.read(feedingControllerProvider.notifier);
                if (alreadyFed) {
                  await controller.undoCheckIn(todayCheckIn.id!, schedule.id!);
                } else {
                  await controller.checkIn(
                    scheduleId: schedule.id!,
                    plannedTimestamp: DateTime.now(),
                  );

                  if (context.mounted) {
                    ToastUtils.showSuccessToast(context, l10n.feedingConfirmed);
                  }
                }
              },
            ),
          ),
        );
      },
      loading: () => const SizedBox(height: 72),
      error: (_, __) => const Icon(Icons.error),
    );
  }
}
