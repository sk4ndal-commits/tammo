import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../features/pet/application/pet_controller.dart';
import '../../features/pet/domain/pet.dart';

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
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedSpecies;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _notesController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _initializeFields(Pet pet) {
    if (_initialized) return;
    _nameController.text = pet.name;
    _selectedSpecies = pet.species;
    _notesController.text = pet.notes ?? '';
    _weightController.text = pet.weight?.toString() ?? '';
    _selectedDate = pet.dateOfBirth;
    _selectedGender = pet.gender;
    _initialized = true;
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(petControllerProvider.notifier).updatePet(
            name: _nameController.text,
            species: _selectedSpecies ?? '',
            dateOfBirth: _selectedDate,
            gender: _selectedGender,
            weight: double.tryParse(_weightController.text),
            notes: _notesController.text,
          );
      if (mounted) {
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
        data: (pet) {
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
