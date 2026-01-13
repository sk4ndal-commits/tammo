import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../widgets/pet_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petState = ref.watch(petControllerProvider);
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
                      onPressed: () {
                        // Später implementieren
                      },
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
                  child: Center(
                    child: Text(l10n.noEntriesYet),
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
