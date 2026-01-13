import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/event/application/event_controller.dart';
import '../../features/event/domain/event.dart';
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
                      leading: Icon(
                        isActive ? Icons.pets : Icons.pets_outlined,
                        color: isActive ? Theme.of(context).colorScheme.primary : null,
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
          showModalBottomSheet<void>(
            context: context,
            builder: (context) => SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add_alert_rounded),
                      title: Text(l10n.captureSymptom),
                      onTap: () {
                        context.pop();
                        context.push('/symptom-log');
                      },
                    ),
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
                    ListTile(
                      leading: const Icon(Icons.bar_chart_rounded),
                      title: Text(l10n.statisticsTitle),
                      onTap: () {
                        context.pop();
                        context.push('/statistics');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.description_rounded),
                      title: Text(l10n.addDocument),
                      onTap: () {
                        context.pop();
                        context.push('/document-upload');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.folder_rounded),
                      title: Text(l10n.documentsTitle),
                      onTap: () {
                        context.pop();
                        context.push('/documents');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.picture_as_pdf_rounded),
                      title: Text(l10n.exportTitle),
                      onTap: () {
                        context.pop();
                        context.push('/export');
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.capture), // "Erfassen" in German, fits well as a general action label
      ),
      body: petState.when(
        data: (state) {
          final pet = state.activePet;
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
                const TodaySection(),
                const SizedBox(height: 24),
                const Divider(),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      l10n.timelinePlaceholder,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    initiallyExpanded: _showTimeline,
                    onExpansionChanged: (expanded) => setState(() => _showTimeline = expanded),
                    children: [
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
