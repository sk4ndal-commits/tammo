// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Tammo';

  @override
  String get noPetFound => 'Kein Tier gefunden.';

  @override
  String helloPet(String name) {
    return 'Hallo, $name!';
  }

  @override
  String species(String species) {
    return 'Tierart: $species';
  }

  @override
  String gender(String gender) {
    return 'Geschlecht: $gender';
  }

  @override
  String weight(double weight) {
    final intl.NumberFormat weightNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String weightString = weightNumberFormat.format(weight);

    return 'Gewicht: $weightString kg';
  }

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get captureSymptom => 'Symptom erfassen';

  @override
  String get createPlans => 'Pläne anlegen';

  @override
  String get addDocument => 'Dokument hinzufügen';

  @override
  String get onboardingTitle => 'Dein Tier';

  @override
  String get onboardingSubtitle => 'Erzähl uns von deinem Begleiter.';

  @override
  String get onboardingHint => 'Du kannst Details später ergänzen.';

  @override
  String get petNameLabel => 'Name des Tieres *';

  @override
  String get petNameError => 'Bitte Namen angeben';

  @override
  String get speciesLabel => 'Tierart *';

  @override
  String get speciesError => 'Bitte Tierart auswählen';

  @override
  String get speciesDog => 'Hund';

  @override
  String get speciesCat => 'Katze';

  @override
  String get speciesBird => 'Vogel';

  @override
  String get speciesRabbit => 'Kaninchen';

  @override
  String get speciesHamster => 'Hamster';

  @override
  String get speciesOther => 'Andere';

  @override
  String get birthDate => 'Geburtsdatum';

  @override
  String get genderLabel => 'Geschlecht';

  @override
  String get genderMale => 'Männlich';

  @override
  String get genderFemale => 'Weiblich';

  @override
  String get weightLabel => 'Gewicht (kg)';

  @override
  String get notesLabel => 'Notizen';

  @override
  String get finish => 'Fertigstellen';

  @override
  String get editPetTitle => 'Profil bearbeiten';

  @override
  String get save => 'Speichern';

  @override
  String get timelinePlaceholder => 'Verlauf';

  @override
  String get noEntriesYet => 'Noch keine Einträge vorhanden.';
}
