import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/document/application/document_controller.dart';

class DocumentUploadScreen extends ConsumerStatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  ConsumerState<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends ConsumerState<DocumentUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _tagsController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedType;
  DateTime _selectedDate = DateTime.now();
  File? _selectedFile;

  @override
  void dispose() {
    _nameController.dispose();
    _tagsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        if (_nameController.text.isEmpty) {
          _nameController.text = result.files.single.name;
        }
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.noFileSelected)),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      final tags = _tagsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      await ref.read(documentControllerProvider.notifier).uploadDocument(
            name: _nameController.text,
            type: _selectedType ?? 'Other',
            date: _selectedDate,
            file: _selectedFile!,
            tags: tags,
            notes: _notesController.text,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.documentUploadSuccess),
            behavior: SnackBarBehavior.floating,
            width: 200,
            duration: const Duration(seconds: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addDocument),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file),
                label: Text(_selectedFile == null 
                    ? l10n.selectFile 
                    : '${l10n.selectFile}: ${_selectedFile!.path.split('/').last}'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.documentNameLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? l10n.petNameError : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedType,
                decoration: InputDecoration(
                  labelText: l10n.documentTypeLabel,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'Finding', child: Text(l10n.documentTypeFinding)),
                  DropdownMenuItem(value: 'Invoice', child: Text(l10n.documentTypeInvoice)),
                  DropdownMenuItem(value: 'Vaccination', child: Text(l10n.documentTypeVaccination)),
                  DropdownMenuItem(value: 'Other', child: Text(l10n.documentTypeOther)),
                ],
                onChanged: (value) => setState(() => _selectedType = value),
                validator: (value) => value == null ? l10n.speciesError : null,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _selectDate,
                icon: const Icon(Icons.calendar_today),
                label: Text('${l10n.documentDateLabel}: ${DateFormat.yMd().format(_selectedDate)}'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: InputDecoration(
                  labelText: l10n.tagsLabel,
                  border: const OutlineInputBorder(),
                  hintText: 'OP, Herz, 2024',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: l10n.notesLabel,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
