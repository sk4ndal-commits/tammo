// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tammo';

  @override
  String get noPetFound => 'No pet found.';

  @override
  String helloPet(String name) {
    return 'Hello, $name!';
  }

  @override
  String species(String species) {
    return 'Species: $species';
  }

  @override
  String gender(String gender) {
    return 'Gender: $gender';
  }

  @override
  String weight(double weight) {
    final intl.NumberFormat weightNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String weightString = weightNumberFormat.format(weight);

    return 'Weight: $weightString kg';
  }

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get captureSymptom => 'Capture symptom';

  @override
  String get createPlans => 'Create plans';

  @override
  String get addDocument => 'Add document';

  @override
  String get onboardingTitle => 'Your Pet';

  @override
  String get onboardingSubtitle => 'Tell us about your companion.';

  @override
  String get onboardingHint => 'You can add details later.';

  @override
  String get petNameLabel => 'Pet\'s name *';

  @override
  String get petNameError => 'Please provide a name';

  @override
  String get speciesLabel => 'Species (e.g. Dog, Cat) *';

  @override
  String get speciesError => 'Please provide a species';

  @override
  String get birthDate => 'Date of birth';

  @override
  String get genderLabel => 'Gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get weightLabel => 'Weight (kg)';

  @override
  String get notesLabel => 'Notes';

  @override
  String get finish => 'Finish';

  @override
  String get editPetTitle => 'Edit Profile';

  @override
  String get save => 'Save';

  @override
  String get timelinePlaceholder => 'Timeline';

  @override
  String get noEntriesYet => 'No entries yet.';
}
