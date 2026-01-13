import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/event/application/event_controller.dart';
import '../../features/event/domain/event.dart';
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        // Später implementieren
                      },
                    ),
                    ActionChip(
                      label: Text(l10n.addDocument),
                      onPressed: () {
                        // Später implementieren
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.timelinePlaceholder,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: eventState.when(
                    data: (events) {
                      if (events.isEmpty) {
                        return Center(child: Text(l10n.noEntriesYet));
                      }
                      return ListView.builder(
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
