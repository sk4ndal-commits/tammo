import 'package:flutter/material.dart';
import '../../features/pet/domain/pet.dart';
import '../../l10n/app_localizations.dart';
import 'dart:io';

class PetHeader extends StatelessWidget {
  final Pet pet;

  const PetHeader({
    super.key,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(40),
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.surface,
              backgroundImage: pet.photoPath != null 
                  ? FileImage(File(pet.photoPath!)) 
                  : null,
              child: pet.photoPath == null 
                  ? Icon(Icons.pets, size: 40, color: Theme.of(context).colorScheme.primary) 
                  : null,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getSpeciesTranslation(context, pet.species),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
}
