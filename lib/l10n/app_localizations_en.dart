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
  String get speciesLabel => 'Species *';

  @override
  String get speciesError => 'Please select a species';

  @override
  String get speciesDog => 'Dog';

  @override
  String get speciesCat => 'Cat';

  @override
  String get speciesBird => 'Bird';

  @override
  String get speciesRabbit => 'Rabbit';

  @override
  String get speciesHamster => 'Hamster';

  @override
  String get speciesOther => 'Other';

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

  @override
  String get symptomLogTitle => 'Capture Symptom';

  @override
  String get eventTypeLabel => 'Symptom / Event *';

  @override
  String get eventTypeError => 'Please select a type';

  @override
  String get eventTypeVomiting => 'Vomiting';

  @override
  String get eventTypeDiarrhea => 'Diarrhea';

  @override
  String get eventTypeAppetite => 'Appetite';

  @override
  String get eventTypeBehavior => 'Behavior';

  @override
  String get eventTypeOther => 'Other';

  @override
  String get eventDateLabel => 'Date & Time';

  @override
  String get frequencyLabel => 'Frequency (per day)';

  @override
  String get capture => 'Capture';

  @override
  String get addEntry => 'Add entry';

  @override
  String get delete => 'Delete';

  @override
  String get statisticsTitle => 'Symptom Overview';

  @override
  String get periodLast7Days => 'Last 7 Days';

  @override
  String get periodLast30Days => 'Last 30 Days';

  @override
  String get summary => 'Summary';

  @override
  String get conspicuousFrequency => 'Conspicuously frequent!';

  @override
  String frequencyCount(int count) {
    return '$count times';
  }

  @override
  String get medicationPlanTitle => 'Medication Plan';

  @override
  String get medicationNameLabel => 'Medication name *';

  @override
  String get dosageLabel => 'Dosage *';

  @override
  String get frequencyLabelMedication => 'Frequency *';

  @override
  String get startDateLabel => 'Valid from';

  @override
  String get endDateLabel => 'Valid until (optional)';

  @override
  String get ruleDescription =>
      'This plan automatically creates daily tasks for today.';

  @override
  String get planIsRuleHint => 'A plan is a set rule for your daily routine.';

  @override
  String get reminderTimesLabel => 'Reminder times';

  @override
  String get addReminderTime => 'Add time';

  @override
  String get createPlan => 'Create plan';

  @override
  String get medicationToday => 'Medication';

  @override
  String get markAsTaken => 'Marked as taken';

  @override
  String get medicationTaken => 'Taken';

  @override
  String get medicationMissed => 'Missed';

  @override
  String get noMedicationToday => 'No medications scheduled for today.';

  @override
  String get feedingPlanTitle => 'Feeding Plan';

  @override
  String get foodTypeLabel => 'Food Type *';

  @override
  String get amountLabel => 'Amount *';

  @override
  String get feedingToday => 'Food';

  @override
  String get feedingDone => 'Fed';

  @override
  String get noFeedingToday => 'No feedings scheduled for today.';

  @override
  String get todayFocus => 'Today';

  @override
  String get allDone => 'All done for today! 🎉';

  @override
  String get showTimeline => 'Show Timeline';

  @override
  String get hideTimeline => 'Hide Timeline';

  @override
  String get undo => 'Undo';

  @override
  String get medicationConfirmed => 'Medication given';

  @override
  String get feedingConfirmed => 'Feeding done';

  @override
  String get eventLogged => 'Symptom logged';

  @override
  String get petCreated => 'Profile created';

  @override
  String get petUpdated => 'Profile updated';

  @override
  String get planCreated => 'Plan created';

  @override
  String get planEditHint => 'All details can be adjusted at any time.';

  @override
  String get optionalLabel => '(optional)';

  @override
  String get requiredLabel => '* required';

  @override
  String get stepWhat => 'What happens?';

  @override
  String get stepHowOften => 'How often?';

  @override
  String get stepWhen => 'When in the day?';

  @override
  String get stepStart => 'Starting when?';

  @override
  String get stepDuration => 'How long?';

  @override
  String get freqOnceDaily => '1× daily';

  @override
  String get freqTwiceDaily => '2× daily';

  @override
  String get freqIndividual => 'individual';

  @override
  String get timeMorning => 'morning';

  @override
  String get timeNoon => 'noon';

  @override
  String get timeEvening => 'evening';

  @override
  String get addTime => 'Add time';

  @override
  String get startToday => 'Today';

  @override
  String get startPickDate => 'Pick date';

  @override
  String get durationUnlimited => 'unlimited';

  @override
  String get durationUntil => 'until date';

  @override
  String get previewTitle => 'Your daily routine';

  @override
  String get previewToday => 'Today:';

  @override
  String get previewTomorrow => 'Tomorrow:';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get later => 'Adjust later';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get documentNameLabel => 'Document name *';

  @override
  String get documentTypeLabel => 'Document type *';

  @override
  String get documentTypeFinding => 'Finding';

  @override
  String get documentTypeInvoice => 'Invoice';

  @override
  String get documentTypeVaccination => 'Vaccination';

  @override
  String get documentTypeOther => 'Other';

  @override
  String get documentDateLabel => 'Document date';

  @override
  String get selectFile => 'Select file';

  @override
  String get noFileSelected => 'No file selected';

  @override
  String get tagsLabel => 'Tags (comma separated)';

  @override
  String get documentUploadSuccess => 'Document uploaded';

  @override
  String get searchDocuments => 'Search documents...';

  @override
  String get noDocumentsFound => 'No documents found.';

  @override
  String get exportTitle => 'Vet Export';

  @override
  String get exportSubtitle => 'Select the period for the report.';

  @override
  String get includeSymptoms => 'Include symptoms';

  @override
  String get includeMedications => 'Include medications';

  @override
  String get includeAllergies => 'Include allergies';

  @override
  String get includeDocuments => 'List documents';

  @override
  String get generatePdf => 'Create PDF Report';

  @override
  String get exportSuccess => 'Report created';

  @override
  String get period => 'Period';

  @override
  String reportTitle(String name) {
    return 'Health Report for $name';
  }

  @override
  String reportPeriod(String start, String end) {
    return 'Period: $start to $end';
  }

  @override
  String get selectAll => 'Select all';

  @override
  String get deselectAll => 'Deselect all';

  @override
  String get switchPet => 'Switch pet';

  @override
  String get addAnotherPet => 'Add another pet';

  @override
  String get managePets => 'Manage pets';

  @override
  String activePetNow(String name) {
    return 'Now active: $name';
  }

  @override
  String get allergiesLabel => 'Allergies';

  @override
  String get emergencyTitle => 'Emergency Mode';

  @override
  String get emergencySubtitle => 'Critical health information';

  @override
  String get lastEvents => 'Last 5 Events';

  @override
  String get medications => 'Medications';

  @override
  String get appOnboardingWelcomeTitle =>
      'Everything about your pet – in one place.';

  @override
  String get appOnboardingWelcomeSubtitle =>
      'Health, routines, and important info collected clearly.';

  @override
  String get appOnboardingReminderTitle => 'Tammo reminds you reliably.';

  @override
  String get appOnboardingReminderSubtitle =>
      'Medication, feeding, and important appointments.';

  @override
  String get appOnboardingOverviewTitle => 'You stay in control at all times.';

  @override
  String get appOnboardingOverviewSubtitle =>
      'Even when things get stressful – nothing gets lost.';

  @override
  String get getStarted => 'Get Started';
}
