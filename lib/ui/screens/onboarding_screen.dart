import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  final _weightController = TextEditingController();
  final _allergiesController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedSpecies;
  String? _photoPath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      final fileName = 'pet_profile_${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}';
      final savedFile = await File(image.path).copy(p.join(appDocDir.path, fileName));
      
      setState(() {
        _photoPath = savedFile.path;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    _weightController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(petControllerProvider.notifier).createPet(
            name: _nameController.text,
            species: _selectedSpecies ?? '',
            dateOfBirth: _selectedDate,
            gender: _selectedGender,
            weight: double.tryParse(_weightController.text),
            photoPath: _photoPath,
            allergies: _allergiesController.text,
            notes: _notesController.text,
          );
      if (mounted) {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.onboardingTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.onboardingSubtitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(l10n.onboardingHint),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    backgroundImage: _photoPath != null ? FileImage(File(_photoPath!)) : null,
                    child: _photoPath == null
                        ? Icon(
                            Icons.add_a_photo_rounded,
                            size: 40,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.petNameLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? l10n.petNameError : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedSpecies,
                decoration: InputDecoration(
                  labelText: l10n.speciesLabel,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'Dog', child: Text(l10n.speciesDog)),
                  DropdownMenuItem(value: 'Cat', child: Text(l10n.speciesCat)),
                  DropdownMenuItem(value: 'Bird', child: Text(l10n.speciesBird)),
                  DropdownMenuItem(value: 'Rabbit', child: Text(l10n.speciesRabbit)),
                  DropdownMenuItem(value: 'Hamster', child: Text(l10n.speciesHamster)),
                  DropdownMenuItem(value: 'Other', child: Text(l10n.speciesOther)),
                ],
                onChanged: (value) => setState(() => _selectedSpecies = value),
                validator: (value) => value == null ? l10n.speciesError : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() => _selectedDate = date);
                        }
                      },
                      icon: const Icon(Icons.cake),
                      label: Text(_selectedDate == null
                          ? l10n.birthDate
                          : DateFormat.yMd().format(_selectedDate!)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedGender,
                decoration: InputDecoration(
                  labelText: l10n.genderLabel,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Männlich',
                    child: Text(l10n.genderMale),
                  ),
                  DropdownMenuItem(
                    value: 'Weiblich',
                    child: Text(l10n.genderFemale),
                  ),
                ],
                onChanged: (value) => setState(() => _selectedGender = value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: l10n.weightLabel,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _allergiesController,
                decoration: InputDecoration(
                  labelText: l10n.allergiesLabel,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text(l10n.finish),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
