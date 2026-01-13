import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../features/event/application/event_stats_provider.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsState = ref.watch(eventStatsProvider);
    final period = ref.watch(statsPeriodProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statisticsTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<StatsPeriod>(
              segments: [
                ButtonSegment(
                  value: StatsPeriod.last7Days,
                  label: Text(l10n.periodLast7Days),
                ),
                ButtonSegment(
                  value: StatsPeriod.last30Days,
                  label: Text(l10n.periodLast30Days),
                ),
              ],
              selected: {period},
              onSelectionChanged: (newSelection) {
                ref.read(statsPeriodProvider.notifier).state = newSelection.first;
              },
            ),
          ),
          Expanded(
            child: statsState.when(
              data: (stats) {
                if (stats.countsByType.isEmpty) {
                  return Center(child: Text(l10n.noEntriesYet));
                }
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      l10n.summary,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ...stats.countsByType.entries.map((entry) {
                      final isConspicuous = entry.value >= 3; // Einfacher Schwellenwert
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            _getIconForType(entry.key),
                            color: isConspicuous 
                                ? Theme.of(context).colorScheme.error 
                                : Theme.of(context).colorScheme.primary,
                          ),
                          title: Text(_getTranslatedType(context, entry.key)),
                          subtitle: isConspicuous 
                              ? Text(
                                  l10n.conspicuousFrequency,
                                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
                                )
                              : null,
                          trailing: Text(
                            l10n.frequencyCount(entry.value),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
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
