import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/document/application/document_controller.dart';
import '../../features/document/domain/document.dart';

class DocumentListScreen extends ConsumerStatefulWidget {
  const DocumentListScreen({super.key});

  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documentState = ref.watch(documentControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.documentsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => context.push('/document-upload'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchDocuments,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
              onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            ),
          ),
          Expanded(
            child: documentState.when(
              data: (documents) {
                final filtered = documents.where((doc) {
                  final nameMatch = doc.name.toLowerCase().contains(_searchQuery);
                  final tagMatch = doc.tags.any((tag) => tag.toLowerCase().contains(_searchQuery));
                  final typeMatch = doc.type.toLowerCase().contains(_searchQuery);
                  return nameMatch || tagMatch || typeMatch;
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(_searchQuery.isEmpty 
                        ? l10n.noEntriesYet 
                        : l10n.noDocumentsFound),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final doc = filtered[index];
                    return _DocumentCard(document: doc);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentCard extends ConsumerWidget {
  final Document document;
  const _DocumentCard({required this.document});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(_getIconForType(document.type), size: 32),
        title: Text(document.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_getTranslatedType(context, document.type)} • ${DateFormat.yMd().format(document.date)}'),
            if (document.tags.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Wrap(
                  spacing: 4,
                  children: document.tags.map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  )).toList(),
                ),
              ),
          ],
        ),
        onTap: () {
          // In a real app, we would open the file using a plugin like open_file_plus
          // For now, we show a info snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Datei: ${document.filePath}')),
          );
        },
        onLongPress: () {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(l10n.delete),
              content: Text(document.name),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.back),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(documentControllerProvider.notifier).deleteDocument(document);
                    Navigator.pop(context);
                  },
                  child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Finding': return Icons.analytics_outlined;
      case 'Invoice': return Icons.receipt_long_outlined;
      case 'Vaccination': return Icons.medical_services_outlined;
      default: return Icons.description_outlined;
    }
  }

  String _getTranslatedType(BuildContext context, String type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case 'Finding': return l10n.documentTypeFinding;
      case 'Invoice': return l10n.documentTypeInvoice;
      case 'Vaccination': return l10n.documentTypeVaccination;
      default: return l10n.documentTypeOther;
    }
  }
}
