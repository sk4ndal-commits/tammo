import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class LocalizationHelpers {
  static String translateSpecies(BuildContext context, String species) {
    return translateSpeciesWithL10n(AppLocalizations.of(context)!, species);
  }

  static String translateSpeciesWithL10n(AppLocalizations l10n, String species) {
    switch (species.toLowerCase()) {
      case 'dog':
        return l10n.speciesDog;
      case 'cat':
        return l10n.speciesCat;
      case 'bird':
        return l10n.speciesBird;
      case 'rabbit':
        return l10n.speciesRabbit;
      case 'hamster':
        return l10n.speciesHamster;
      default:
        return l10n.speciesOther;
    }
  }

  static String translateGender(BuildContext context, String? gender) {
    return translateGenderWithL10n(AppLocalizations.of(context)!, gender);
  }

  static String translateGenderWithL10n(AppLocalizations l10n, String? gender) {
    if (gender == null) return '';
    switch (gender.toLowerCase()) {
      case 'male':
      case 'männlich':
        return l10n.genderMale;
      case 'female':
      case 'weiblich':
        return l10n.genderFemale;
      default:
        return '';
    }
  }

  static String translateEventType(BuildContext context, String type) {
    return translateEventTypeWithL10n(AppLocalizations.of(context)!, type);
  }

  static String translateEventTypeWithL10n(AppLocalizations l10n, String type) {
    switch (type) {
      case 'Vomiting':
      case 'Erbrechen':
        return l10n.eventTypeVomiting;
      case 'Diarrhea':
      case 'Durchfall':
        return l10n.eventTypeDiarrhea;
      case 'Appetite':
      case 'Appetit':
        return l10n.eventTypeAppetite;
      case 'Behavior':
      case 'Verhalten':
        return l10n.eventTypeBehavior;
      default:
        return l10n.eventTypeOther;
    }
  }

  static String translateDocumentType(BuildContext context, String type) {
    return translateDocumentTypeWithL10n(AppLocalizations.of(context)!, type);
  }

  static String translateDocumentTypeWithL10n(AppLocalizations l10n, String type) {
    switch (type) {
      case 'Finding':
      case 'Befund':
        return l10n.documentTypeFinding;
      case 'Invoice':
      case 'Rechnung':
        return l10n.documentTypeInvoice;
      case 'Vaccination':
      case 'Impfung':
        return l10n.documentTypeVaccination;
      default:
        return l10n.documentTypeOther;
    }
  }
}
