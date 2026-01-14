import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/event/application/event_controller.dart';
import '../../features/event/domain/event.dart';
import '../../features/medication/application/medication_controller.dart';
import '../../features/feeding/application/feeding_controller.dart';
import '../widgets/pet_header.dart';
import '../widgets/today_section.dart';

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
        title: Text(l10n.appTitle),
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
                      subtitle: Text(pet.species),
                      onTap: () {
                        ref.read(petControllerProvider.notifier).setActivePet(pet);
                        Navigator.pop(context);
                      },
                      trailing: isActive ? const Icon(Icons.check) : null,
                    );
                  },
                ),
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
          final medicationState = ref.read(medicationControllerProvider);
          final feedingState = ref.read(feedingControllerProvider);
          
          final hasActivePlans = medicationState.maybeWhen(
            data: (plans) => plans.any((p) => p.isActive),
            orElse: () => true,
          ) || feedingState.maybeWhen(
            data: (plans) => plans.any((p) => p.isActive),
            orElse: () => true,
          );

          showModalBottomSheet<void>(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: Icon(Icons.add_alert_rounded, color: Theme.of(context).colorScheme.onPrimaryContainer),
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
                        backgroundColor: hasActivePlans 
                            ? Theme.of(context).colorScheme.surfaceContainerHighest
                            : Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.calendar_month_rounded, 
                          color: hasActivePlans 
                              ? Theme.of(context).colorScheme.onSurfaceVariant
                              : Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      title: Text(
                        l10n.createPlans, 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: hasActivePlans ? null : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      subtitle: hasActivePlans ? null : Text(l10n.onboardingHint), // "Du kannst Details später ergänzen" works as a hint here
                      onTap: () {
                        context.pop();
                        // Zeige Dialog zur Auswahl des Plantyps
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(l10n.createPlans),
                            content: Column(
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
                        );
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PetHeader(pet: pet),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
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
