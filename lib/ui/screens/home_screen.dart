import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/event/application/event_controller.dart';
import '../../features/event/application/narrative_engine.dart';
import '../../features/event/domain/event.dart';
import '../../features/medication/application/medication_controller.dart';
import '../../features/feeding/application/feeding_controller.dart';
import '../../features/backup/application/backup_service.dart';
import '../../features/backup/data/supabase_provider.dart';
import '../widgets/localization_helpers.dart';
import '../widgets/toast_utils.dart';
import '../widgets/today_section.dart';
import '../widgets/care_phase_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final bool expandTimeline;
  const HomeScreen({super.key, this.expandTimeline = false});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late bool _showTimeline;

  @override
  void initState() {
    super.initState();
    _showTimeline = widget.expandTimeline;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runBackgroundBackup();
    });
  }

  Future<void> _runBackgroundBackup() async {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      try {
        await ref.read(backupServiceProvider).uploadBackup();
      } catch (e) {
        // Silent error for background backup, but could log it
        debugPrint('Background backup failed: $e');
      }
    }
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expandTimeline != oldWidget.expandTimeline) {
      _showTimeline = widget.expandTimeline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final petState = ref.watch(petControllerProvider);
    final eventState = ref.watch(eventControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            petState.maybeWhen(
              data: (state) => state.activePet?.photoPath != null
                  ? CircleAvatar(
                      radius: 16,
                      backgroundImage: FileImage(File(state.activePet!.photoPath!)),
                    )
                  : const Icon(Icons.pets, size: 20),
              orElse: () => const Icon(Icons.pets, size: 20),
            ),
            const SizedBox(width: 12),
            Text(petState.maybeWhen(
              data: (state) => state.activePet?.name ?? l10n.appTitle,
              orElse: () => l10n.appTitle,
            )),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
            onPressed: () => context.push('/emergency'),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/edit-pet'),
          ),
        ],
      ),
      drawer: petState.when(
        data: (state) => Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Center(
                  child: Text(
                    l10n.managePets,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.allPets.length,
                  itemBuilder: (context, index) {
                    final pet = state.allPets[index];
                    final isActive = pet.petId == state.activePet?.petId;
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: pet.photoPath != null
                            ? FileImage(File(pet.photoPath!))
                            : null,
                        child: pet.photoPath == null
                            ? Icon(
                                isActive ? Icons.pets : Icons.pets_outlined,
                                color: isActive
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                              )
                            : null,
                      ),
                      title: Text(
                        pet.name,
                        style: TextStyle(
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(LocalizationHelpers.translateSpecies(context, pet.species)),
                      onTap: () {
                        ref.read(petControllerProvider.notifier).setActivePet(pet);
                        Navigator.pop(context);
                        ToastUtils.showSuccessToast(
                          context, 
                          l10n.activePetNow(pet.name),
                        );
                      },
                      trailing: isActive ? const Icon(Icons.check) : null,
                    );
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.cloud_sync),
                title: Text(l10n.backupTitle),
                subtitle: Consumer(
                  builder: (context, ref, _) {
                    final lastBackup = ref.watch(lastBackupTimeProvider);
                    return lastBackup.when(
                      data: (time) {
                        if (time == null) {
                          return Text(
                            l10n.backupNever,
                            style: const TextStyle(fontSize: 12),
                          );
                        }
                        final diff = DateTime.now().difference(time);
                        String timeAgo;
                        if (diff.inDays > 0) {
                          timeAgo = "${diff.inDays}d";
                        } else if (diff.inHours > 0) {
                          timeAgo = "${diff.inHours}h";
                        } else if (diff.inMinutes > 0) {
                          timeAgo = "${diff.inMinutes}m";
                        } else {
                          timeAgo = "< 1m";
                        }
                        return Text(
                          l10n.lastBackupAt(timeAgo),
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                      loading: () => const Text("...", style: TextStyle(fontSize: 12)),
                      error: (_, __) => Text(
                        l10n.backupNever,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  },
                ),
                onTap: () {
                  context.pop();
                  context.push('/backup');
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: Text(l10n.householdTitle),
                subtitle: Text(
                  l10n.householdSubtitle,
                  style: const TextStyle(fontSize: 12),
                ),
                onTap: () {
                  context.pop();
                  context.push('/household');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.add_rounded),
                title: Text(l10n.addAnotherPet),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/onboarding');
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        loading: () => const Drawer(child: Center(child: CircularProgressIndicator())),
        error: (err, _) => Drawer(child: Center(child: Text('Error: $err'))),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) => SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                        child: Icon(Icons.add_alert_rounded, color: Theme.of(context).colorScheme.onErrorContainer),
                      ),
                      title: Text(l10n.captureSymptom, style: const TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {
                        context.pop();
                        context.push('/symptom-log');
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        child: Icon(Icons.description_rounded, color: Theme.of(context).colorScheme.onSecondaryContainer),
                      ),
                      title: Text(l10n.addDocument, style: const TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {
                        context.pop();
                        context.push('/document-upload');
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                        child: Icon(Icons.ios_share_rounded, color: Theme.of(context).colorScheme.onTertiaryContainer),
                      ),
                      title: Text(l10n.exportTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {
                        context.pop();
                        context.push('/export');
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: Icon(
                          Icons.calendar_month_rounded, 
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      title: Text(
                        l10n.createPlans, 
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        context.pop();
                        final medState = ref.read(medicationControllerProvider).valueOrNull ?? [];
                        final feedState = ref.read(feedingControllerProvider).valueOrNull ?? [];
                        final hasAnyPlans = medState.isNotEmpty || feedState.isNotEmpty;

                        if (hasAnyPlans) {
                          context.push('/plans');
                        } else {
                          // Show selection dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(l10n.createPlans),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.medication_rounded),
                                      title: Text(l10n.medicationPlanTitle),
                                      onTap: () {
                                        context.pop();
                                        context.push('/medication-plan');
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.restaurant_rounded),
                                      title: Text(l10n.feedingPlanTitle),
                                      onTap: () {
                                        context.pop();
                                        context.push('/feeding-plan');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.capture),
      ),
      body: petState.when(
        data: (state) {
          final pet = state.activePet;
          if (pet == null) {
            return Center(child: Text(l10n.noPetFound));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TodaySection(),
                ),
                const SizedBox(height: 16),
                const Divider(),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      l10n.timelinePlaceholder,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    initiallyExpanded: false,
                    onExpansionChanged: (expanded) => setState(() => _showTimeline = expanded),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: eventState.when(
                          data: (events) {
                            if (events.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32.0),
                                child: Center(child: Text(l10n.noEntriesYet)),
                              );
                            }

                            final medicationSchedules = ref.watch(medicationControllerProvider).valueOrNull ?? [];
                            final phases = NarrativeEngine.detectPhases(
                              events: events,
                              medicationSchedules: medicationSchedules,
                            );

                            final phaseEventIds = phases.expand((p) => p.events.map((e) => e.id)).toSet();
                            final individualEvents = events.where((e) => !phaseEventIds.contains(e.id)).toList();

                            return Column(
                              children: [
                                if (phases.isNotEmpty) ...[
                                  ...phases.map((phase) => CarePhaseTile(
                                        phase: phase,
                                        eventTileBuilder: (event) => _EventTile(event: event),
                                      )),
                                  if (individualEvents.isNotEmpty) const Divider(height: 32),
                                ],
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: individualEvents.length,
                                  itemBuilder: (context, index) {
                                    final event = individualEvents[index];
                                    return _EventTile(event: event);
                                  },
                                ),
                              ],
                            );
                          },
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (err, stack) => Center(child: Text('Error: $err')),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // Space for FAB
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
    return LocalizationHelpers.translateEventType(context, type);
  }
}
