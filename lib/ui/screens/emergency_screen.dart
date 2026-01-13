import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/event/application/event_controller.dart';
import '../../features/medication/application/medication_controller.dart';
import '../widgets/pet_header.dart';

class EmergencyScreen extends ConsumerWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petState = ref.watch(petControllerProvider);
    final eventState = ref.watch(eventControllerProvider);
    final medState = ref.watch(medicationControllerProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.emergencyTitle),
        backgroundColor: theme.colorScheme.errorContainer,
        foregroundColor: theme.colorScheme.onErrorContainer,
      ),
      body: petState.when(
        data: (state) {
          final pet = state.activePet;
          if (pet == null) return Center(child: Text(l10n.noPetFound));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PetHeader(pet: pet),
                const SizedBox(height: 24),
                
                // Allergies Section
                _EmergencyCard(
                  title: l10n.allergiesLabel,
                  icon: Icons.warning_rounded,
                  color: theme.colorScheme.error,
                  content: Text(
                    pet.allergies?.isNotEmpty == true
                        ? pet.allergies!
                        : '---',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Medications Section
                medState.when(
                  data: (schedules) {
                    final activeMeds = schedules.where((s) => s.isActive).toList();
                    return _EmergencyCard(
                      title: l10n.medicationToday,
                      icon: Icons.medication_rounded,
                      color: theme.colorScheme.primary,
                      content: activeMeds.isEmpty
                      ? const Text('---')
                      : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: activeMeds
                                  .map((s) => Padding(
                                        padding: const EdgeInsets.only(bottom: 4.0),
                                        child: Text('• ${s.medicationName} (${s.dosage})'),
                                      ))
                                  .toList(),
                            ),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, _) => Text('Error: $err'),
                ),
                const SizedBox(height: 16),

                // Last Events Section
                eventState.when(
                  data: (events) {
                    final recentEvents = events.take(5).toList();
                    return _EmergencyCard(
                      title: l10n.lastEvents,
                      icon: Icons.history_rounded,
                      color: theme.colorScheme.secondary,
                      content: recentEvents.isEmpty
                          ? const Text('---')
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: recentEvents.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${DateFormat.Hm().format(e.timestamp)}: ',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${_getTranslatedType(context, e.type)}${e.notes != null ? " (${e.notes})" : ""}',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, _) => Text('Error: $err'),
                ),
                
                const SizedBox(height: 24),
                // Emergency instructions or contact info could go here
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  String _getTranslatedType(BuildContext context, String type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type.toLowerCase()) {
      case 'vomiting':
        return l10n.eventTypeVomiting;
      case 'diarrhea':
        return l10n.eventTypeDiarrhea;
      case 'appetite':
        return l10n.eventTypeAppetite;
      case 'behavior':
        return l10n.eventTypeBehavior;
      default:
        return l10n.eventTypeOther;
    }
  }
}

class _EmergencyCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget content;

  const _EmergencyCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color.withAlpha(50)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }
}
