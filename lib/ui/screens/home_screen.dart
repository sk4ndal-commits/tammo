import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/event/application/event_controller.dart';
import '../../features/event/domain/event.dart';
import '../../features/medication/application/medication_controller.dart';
import '../../features/medication/domain/medication.dart';
import '../../features/feeding/application/feeding_controller.dart';
import '../../features/feeding/domain/feeding.dart';
import '../widgets/pet_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petState = ref.watch(petControllerProvider);
    final eventState = ref.watch(eventControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/edit-pet'),
          ),
        ],
      ),
      body: petState.when(
        data: (pet) {
          if (pet == null) {
            return Center(child: Text(l10n.noPetFound));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PetHeader(pet: pet),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  l10n.quickActions,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ActionChip(
                      label: Text(l10n.captureSymptom),
                      onPressed: () => context.push('/symptom-log'),
                    ),
                    ActionChip(
                      label: Text(l10n.statisticsTitle),
                      onPressed: () => context.push('/statistics'),
                    ),
                    ActionChip(
                      label: Text(l10n.createPlans),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.medication),
                                title: Text(l10n.medicationPlanTitle),
                                onTap: () {
                                  context.pop();
                                  context.push('/medication-plan');
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.restaurant),
                                title: Text(l10n.feedingPlanTitle),
                                onTap: () {
                                  context.pop();
                                  context.pop();
                                  context.push('/feeding-plan');
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    ActionChip(
                      label: Text(l10n.addDocument),
                      onPressed: null,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _TodayMedicationList(),
                const SizedBox(height: 16),
                const _TodayFeedingList(),
                const SizedBox(height: 24),
                Text(
                  l10n.timelinePlaceholder,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                eventState.when(
                  data: (events) {
                    if (events.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(child: Text(l10n.noEntriesYet)),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return _EventTile(event: event);
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Fehler: $err')),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final Event event;

  const _EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Icon(_getIconForType(event.type), color: Theme.of(context).colorScheme.secondary),
        ),
        title: Text(_getTranslatedType(context, event.type)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat.yMd().add_Hm().format(event.timestamp)),
            if (event.notes != null && event.notes!.isNotEmpty)
              Text(
                event.notes!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        trailing: event.frequency > 1 
          ? Badge(label: Text(event.frequency.toString())) 
          : null,
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Vomiting': return Icons.warning_amber_rounded;
      case 'Diarrhea': return Icons.water_drop;
      case 'Appetite': return Icons.restaurant;
      case 'Behavior': return Icons.psychology;
      default: return Icons.event;
    }
  }

  String _getTranslatedType(BuildContext context, String type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case 'Vomiting': return l10n.eventTypeVomiting;
      case 'Diarrhea': return l10n.eventTypeDiarrhea;
      case 'Appetite': return l10n.eventTypeAppetite;
      case 'Behavior': return l10n.eventTypeBehavior;
      default: return l10n.eventTypeOther;
    }
  }
}

class _TodayMedicationList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final medicationState = ref.watch(medicationControllerProvider);

    return medicationState.when(
      data: (schedules) {
        final activeSchedules = schedules.where((s) => s.isActive).toList();
        if (activeSchedules.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.medicationToday,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...activeSchedules.map((schedule) => _MedicationCheckInTile(schedule: schedule)),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _TodayFeedingList extends ConsumerWidget {
  const _TodayFeedingList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedingState = ref.watch(feedingControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return feedingState.when(
      data: (schedules) {
        final activeSchedules = schedules.where((s) => s.isActive).toList();
        if (activeSchedules.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.feedingToday,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...activeSchedules.map((schedule) => _FeedingCheckInTile(schedule: schedule)),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _FeedingCheckInTile extends ConsumerWidget {
  final FeedingSchedule schedule;

  const _FeedingCheckInTile({required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIns = ref.watch(feedingCheckInsProvider(schedule.id!));
    final l10n = AppLocalizations.of(context)!;

    return checkIns.when(
      data: (items) {
        final today = DateTime.now();
        final alreadyFed = items.any((ci) =>
            ci.timestamp.year == today.year &&
            ci.timestamp.month == today.month &&
            ci.timestamp.day == today.day);

        return Card(
          child: ListTile(
            leading: Icon(
              Icons.restaurant,
              color: alreadyFed ? Theme.of(context).colorScheme.primary : null,
            ),
            title: Text(schedule.foodType),
            subtitle: Text(schedule.amount),
            trailing: alreadyFed
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l10n.feedingDone, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                      const SizedBox(width: 4),
                      Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
                    ],
                  )
                : IconButton(
                    icon: const Icon(Icons.radio_button_unchecked),
                    onPressed: () => ref.read(feedingControllerProvider.notifier).checkIn(
                          scheduleId: schedule.id!,
                          plannedTimestamp: DateTime.now(),
                        ).then((_) => ref.refresh(feedingCheckInsProvider(schedule.id!))),
                  ),
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Icon(Icons.error),
    );
  }
}

class _MedicationCheckInTile extends ConsumerWidget {
  final MedicationSchedule schedule;

  const _MedicationCheckInTile({required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIns = ref.watch(medicationCheckInsProvider(schedule.id!));

    return checkIns.when(
      data: (items) {
        // Prüfen, ob für heute bereits ein Check-In existiert
        final today = DateTime.now();
        final alreadyTaken = items.any((ci) =>
            ci.timestamp.year == today.year &&
            ci.timestamp.month == today.month &&
            ci.timestamp.day == today.day);

        return Card(
          child: ListTile(
            leading: Icon(
              Icons.medication,
              color: alreadyTaken ? Theme.of(context).colorScheme.primary : null,
            ),
            title: Text(schedule.medicationName),
            subtitle: Text('${schedule.dosage} - ${schedule.frequency}'),
            trailing: alreadyTaken
                ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                : IconButton(
                    icon: const Icon(Icons.radio_button_unchecked),
                    onPressed: () => ref.read(medicationControllerProvider.notifier).checkIn(
                          scheduleId: schedule.id!,
                          plannedTimestamp: DateTime.now(), // Vereinfacht für MVP
                        ).then((_) => ref.refresh(medicationCheckInsProvider(schedule.id!))),
                  ),
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Icon(Icons.error),
    );
  }
}
