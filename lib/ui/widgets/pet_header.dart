import 'package:flutter/material.dart';
import '../../features/pet/domain/pet.dart';
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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: pet.photoPath != null 
                ? FileImage(File(pet.photoPath!)) 
                : null,
            child: pet.photoPath == null 
                ? const Icon(Icons.pets, size: 30) 
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  pet.species,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(204), // 80% Deckkraft
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
