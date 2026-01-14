import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/event/application/event_controller.dart';
import '../../features/event/application/narrative_engine.dart';
import '../../features/event/domain/care_narrative.dart';
import '../../features/medication/application/medication_controller.dart';
import '../widgets/localization_helpers.dart';

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
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: petState.when(
        data: (state) {
          final pet = state.activePet;
          if (pet == null) return Center(child: Text(l10n.noPetFound));

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Compact high-contrast Header
                Center(
                  child: Column(
                    children: [
                      Text(
                        pet.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: -1,
                        ),
                      ),
                      Text(
                        _getSpeciesTranslation(context, pet.species),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Allergies Section (Priority 1)
                _EmergencyCard(
                  title: l10n.allergiesLabel.toUpperCase(),
                  icon: Icons.warning_rounded,
                  color: Colors.red.shade900,
                  content: Text(
                    pet.allergies?.isNotEmpty == true
                        ? pet.allergies!
                        : 'KEINE ALLERGIEN BEKANNT',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: pet.allergies?.isNotEmpty == true ? Colors.red.shade900 : Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Care Narratives Section (New Priority)
                eventState.when(
                  data: (events) {
                    final medSchedules = medState.valueOrNull ?? [];
                    final phases = NarrativeEngine.detectPhases(
                      events: events,
                      medicationSchedules: medSchedules,
                    );
                    
                    final ongoingPhase = phases.where((p) => p.endDate == null).firstOrNull;
                    final lastResolvedPhase = phases.where((p) => p.endDate != null).firstOrNull;

                    if (ongoingPhase == null && lastResolvedPhase == null) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      children: [
                        if (ongoingPhase != null) ...[
                          _EmergencyCard(
                            title: l10n.ongoingPhase.toUpperCase(),
                            icon: Icons.running_with_errors_rounded,
                            color: Colors.orange.shade900,
                            content: _buildPhaseContent(context, ongoingPhase, theme, l10n),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (lastResolvedPhase != null) ...[
                          _EmergencyCard(
                            title: l10n.lastResolvedPhase.toUpperCase(),
                            icon: Icons.check_circle_outline_rounded,
                            color: Colors.green.shade900,
                            content: _buildPhaseContent(context, lastResolvedPhase, theme, l10n),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ],
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

                // Medications Section (Priority 2)
                medState.when(
                  data: (schedules) {
                    final activeMeds = schedules.where((s) => s.isActive).toList();
                    return _EmergencyCard(
                      title: l10n.medications.toUpperCase(),
                      icon: Icons.medication_rounded,
                      color: Colors.blue.shade900,
                      content: activeMeds.isEmpty
                      ? Text(
                          'KEINE AKTIVEN MEDIKAMENTE',
                          style: theme.textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
                        )
                      : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: activeMeds
                                  .map((s) => Padding(
                                        padding: const EdgeInsets.only(bottom: 12.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '• ',
                                              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${s.medicationName} (${s.dosage})',
                                                style: theme.textTheme.headlineSmall?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Text('Error: $err'),
                ),
                const SizedBox(height: 16),

                // Last Events Section (Priority 3)
                eventState.when(
                  data: (events) {
                    final recentEvents = events.take(3).toList();
                    return _EmergencyCard(
                      title: l10n.lastEvents.toUpperCase(),
                      icon: Icons.history_rounded,
                      color: Colors.black,
                      content: recentEvents.isEmpty
                          ? Text(
                              'KEINE EINTRÄGE',
                              style: theme.textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: recentEvents.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${DateFormat.Hm().format(e.timestamp)} - ${_getTranslatedType(context, e.type)}',
                                        style: theme.textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                      ),
                                      if (e.notes != null && e.notes!.isNotEmpty)
                                        Text(
                                          e.notes!,
                                          style: theme.textTheme.bodyLarge?.copyWith(
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Text('Error: $err'),
                ),
                
                const SizedBox(height: 48),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  String _getSpeciesTranslation(BuildContext context, String species) {
    final l10n = AppLocalizations.of(context)!;
    switch (species) {
      case 'Dog':
        return l10n.speciesDog;
      case 'Cat':
        return l10n.speciesCat;
      case 'Bird':
        return l10n.speciesBird;
      case 'Rabbit':
        return l10n.speciesRabbit;
      case 'Hamster':
        return l10n.speciesHamster;
      case 'Other':
        return l10n.speciesOther;
      default:
        return species;
    }
  }

  String _getTranslatedType(BuildContext context, String type) {
    return LocalizationHelpers.translateEventType(context, type);
  }

  Widget _buildPhaseContent(BuildContext context, CarePhase phase, ThemeData theme, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.phaseTitle(LocalizationHelpers.translateEventType(context, phase.dominantTopic)),
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          '${DateFormat.yMd().format(phase.startDate)} - ${phase.endDate != null ? DateFormat.yMd().format(phase.endDate!) : l10n.phaseOngoing}',
          style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade800),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.phaseSummary(phase.events.length, phase.planIdsStarted.length + phase.planIdsEnded.length),
          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
        ),
      ],
    );
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
      elevation: 4,
      shadowColor: color.withAlpha(40),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: color,
                          letterSpacing: 1.2,
                        ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(thickness: 2),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
