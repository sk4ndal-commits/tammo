import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../features/pet/domain/pet.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../widgets/toast_utils.dart';

class PetEditScreen extends ConsumerStatefulWidget {
  const PetEditScreen({super.key});

  @override
  ConsumerState<PetEditScreen> createState() => _PetEditScreenState();
}

class _PetEditScreenState extends ConsumerState<PetEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  late TextEditingController _weightController;
  late TextEditingController _allergiesController;
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedSpecies;
  String? _photoPath;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _notesController = TextEditingController();
    _weightController = TextEditingController();
    _allergiesController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    _weightController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  void _initializeFields(Pet pet) {
    if (_initialized) return;
    _nameController.text = pet.name;
    _selectedSpecies = pet.species;
    _notesController.text = pet.notes ?? '';
    _weightController.text = pet.weight?.toString() ?? '';
    _allergiesController.text = pet.allergies ?? '';
    _selectedDate = pet.dateOfBirth;
    _selectedGender = pet.gender;
    _photoPath = pet.photoPath;
    _initialized = true;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      final fileName =
          'pet_profile_${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}';
      final savedFile =
          await File(image.path).copy(p.join(appDocDir.path, fileName));

      setState(() {
        _photoPath = savedFile.path;
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(petControllerProvider.notifier).updatePet(
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
        ToastUtils.showSuccessToast(context, AppLocalizations.of(context)!.petUpdated);
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final petState = ref.watch(petControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editPetTitle),
      ),
      body: petState.when(
        data: (controllerState) {
          final pet = controllerState.activePet;
          if (pet == null) {
            return Center(child: Text(l10n.noPetFound));
          }
          _initializeFields(pet);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        backgroundImage: _photoPath != null
                            ? FileImage(File(_photoPath!))
                            : null,
                        child: _photoPath == null
                            ? Icon(
                                Icons.add_a_photo_rounded,
                                size: 40,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
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
                      DropdownMenuItem(value: 'dog', child: Text(l10n.speciesDog)),
                      DropdownMenuItem(value: 'cat', child: Text(l10n.speciesCat)),
                      DropdownMenuItem(value: 'bird', child: Text(l10n.speciesBird)),
                      DropdownMenuItem(value: 'rabbit', child: Text(l10n.speciesRabbit)),
                      DropdownMenuItem(value: 'hamster', child: Text(l10n.speciesHamster)),
                      DropdownMenuItem(value: 'other', child: Text(l10n.speciesOther)),
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
                              initialDate: _selectedDate ?? DateTime.now(),
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
                        value: 'male',
                        child: Text(l10n.genderMale),
                      ),
                      DropdownMenuItem(
                        value: 'female',
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
                    child: Text(l10n.save),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
