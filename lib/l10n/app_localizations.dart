import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Tammo'**
  String get appTitle;

  /// No description provided for @noPetFound.
  ///
  /// In en, this message translates to:
  /// **'No pet found.'**
  String get noPetFound;

  /// No description provided for @helloPet.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String helloPet(String name);

  /// No description provided for @species.
  ///
  /// In en, this message translates to:
  /// **'Species: {species}'**
  String species(String species);

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender: {gender}'**
  String gender(String gender);

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight: {weight} kg'**
  String weight(double weight);

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @captureSymptom.
  ///
  /// In en, this message translates to:
  /// **'Capture symptom'**
  String get captureSymptom;

  /// No description provided for @createPlans.
  ///
  /// In en, this message translates to:
  /// **'Create plans'**
  String get createPlans;

  /// No description provided for @addDocument.
  ///
  /// In en, this message translates to:
  /// **'Add document'**
  String get addDocument;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Pet'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your companion.'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingHint.
  ///
  /// In en, this message translates to:
  /// **'You can add details later.'**
  String get onboardingHint;

  /// No description provided for @petNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Pet\'s name *'**
  String get petNameLabel;

  /// No description provided for @petNameError.
  ///
  /// In en, this message translates to:
  /// **'Please provide a name'**
  String get petNameError;

  /// No description provided for @speciesLabel.
  ///
  /// In en, this message translates to:
  /// **'Species *'**
  String get speciesLabel;

  /// No description provided for @speciesError.
  ///
  /// In en, this message translates to:
  /// **'Please select a species'**
  String get speciesError;

  /// No description provided for @speciesDog.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get speciesDog;

  /// No description provided for @speciesCat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get speciesCat;

  /// No description provided for @speciesBird.
  ///
  /// In en, this message translates to:
  /// **'Bird'**
  String get speciesBird;

  /// No description provided for @speciesRabbit.
  ///
  /// In en, this message translates to:
  /// **'Rabbit'**
  String get speciesRabbit;

  /// No description provided for @speciesHamster.
  ///
  /// In en, this message translates to:
  /// **'Hamster'**
  String get speciesHamster;

  /// No description provided for @speciesOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get speciesOther;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get birthDate;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightLabel;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @editPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editPetTitle;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @timelinePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timelinePlaceholder;

  /// No description provided for @noEntriesYet.
  ///
  /// In en, this message translates to:
  /// **'No entries yet.'**
  String get noEntriesYet;

  /// No description provided for @symptomLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture Symptom'**
  String get symptomLogTitle;

  /// No description provided for @eventTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Symptom / Event *'**
  String get eventTypeLabel;

  /// No description provided for @eventTypeError.
  ///
  /// In en, this message translates to:
  /// **'Please select a type'**
  String get eventTypeError;

  /// No description provided for @eventTypeVomiting.
  ///
  /// In en, this message translates to:
  /// **'Vomiting'**
  String get eventTypeVomiting;

  /// No description provided for @eventTypeDiarrhea.
  ///
  /// In en, this message translates to:
  /// **'Diarrhea'**
  String get eventTypeDiarrhea;

  /// No description provided for @eventTypeAppetite.
  ///
  /// In en, this message translates to:
  /// **'Appetite'**
  String get eventTypeAppetite;

  /// No description provided for @eventTypeBehavior.
  ///
  /// In en, this message translates to:
  /// **'Behavior'**
  String get eventTypeBehavior;

  /// No description provided for @eventTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get eventTypeOther;

  /// No description provided for @eventDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get eventDateLabel;

  /// No description provided for @frequencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Frequency (per day)'**
  String get frequencyLabel;

  /// No description provided for @capture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get capture;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @statisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptom Overview'**
  String get statisticsTitle;

  /// No description provided for @periodLast7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days'**
  String get periodLast7Days;

  /// No description provided for @periodLast30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get periodLast30Days;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @conspicuousFrequency.
  ///
  /// In en, this message translates to:
  /// **'Conspicuously frequent!'**
  String get conspicuousFrequency;

  /// No description provided for @frequencyCount.
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String frequencyCount(int count);

  /// No description provided for @medicationPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Medication Plan'**
  String get medicationPlanTitle;

  /// No description provided for @medicationNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Medication name *'**
  String get medicationNameLabel;

  /// No description provided for @dosageLabel.
  ///
  /// In en, this message translates to:
  /// **'Dosage *'**
  String get dosageLabel;

  /// No description provided for @frequencyLabelMedication.
  ///
  /// In en, this message translates to:
  /// **'Frequency *'**
  String get frequencyLabelMedication;

  /// No description provided for @startDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDateLabel;

  /// No description provided for @endDateLabel.
  ///
  /// In en, this message translates to:
  /// **'End date (optional)'**
  String get endDateLabel;

  /// No description provided for @reminderTimesLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder times'**
  String get reminderTimesLabel;

  /// No description provided for @addReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Add time'**
  String get addReminderTime;

  /// No description provided for @createPlan.
  ///
  /// In en, this message translates to:
  /// **'Create plan'**
  String get createPlan;

  /// No description provided for @medicationToday.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get medicationToday;

  /// No description provided for @markAsTaken.
  ///
  /// In en, this message translates to:
  /// **'Marked as taken'**
  String get markAsTaken;

  /// No description provided for @medicationTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get medicationTaken;

  /// No description provided for @medicationMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get medicationMissed;

  /// No description provided for @noMedicationToday.
  ///
  /// In en, this message translates to:
  /// **'No medications scheduled for today.'**
  String get noMedicationToday;

  /// No description provided for @feedingPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Feeding Plan'**
  String get feedingPlanTitle;

  /// No description provided for @foodTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Food Type *'**
  String get foodTypeLabel;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount *'**
  String get amountLabel;

  /// No description provided for @feedingToday.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get feedingToday;

  /// No description provided for @feedingDone.
  ///
  /// In en, this message translates to:
  /// **'Fed'**
  String get feedingDone;

  /// No description provided for @noFeedingToday.
  ///
  /// In en, this message translates to:
  /// **'No feedings scheduled for today.'**
  String get noFeedingToday;

  /// No description provided for @todayFocus.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayFocus;

  /// No description provided for @allDone.
  ///
  /// In en, this message translates to:
  /// **'All done for today! 🎉'**
  String get allDone;

  /// No description provided for @showTimeline.
  ///
  /// In en, this message translates to:
  /// **'Show Timeline'**
  String get showTimeline;

  /// No description provided for @hideTimeline.
  ///
  /// In en, this message translates to:
  /// **'Hide Timeline'**
  String get hideTimeline;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @medicationConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Medication given'**
  String get medicationConfirmed;

  /// No description provided for @feedingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Feeding done'**
  String get feedingConfirmed;

  /// No description provided for @eventLogged.
  ///
  /// In en, this message translates to:
  /// **'Symptom logged'**
  String get eventLogged;

  /// No description provided for @stepWhat.
  ///
  /// In en, this message translates to:
  /// **'What?'**
  String get stepWhat;

  /// No description provided for @stepHowOften.
  ///
  /// In en, this message translates to:
  /// **'How often?'**
  String get stepHowOften;

  /// No description provided for @stepWhen.
  ///
  /// In en, this message translates to:
  /// **'When?'**
  String get stepWhen;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Adjust later'**
  String get later;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsTitle;

  /// No description provided for @documentNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Document name *'**
  String get documentNameLabel;

  /// No description provided for @documentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Document type *'**
  String get documentTypeLabel;

  /// No description provided for @documentTypeFinding.
  ///
  /// In en, this message translates to:
  /// **'Finding'**
  String get documentTypeFinding;

  /// No description provided for @documentTypeInvoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get documentTypeInvoice;

  /// No description provided for @documentTypeVaccination.
  ///
  /// In en, this message translates to:
  /// **'Vaccination'**
  String get documentTypeVaccination;

  /// No description provided for @documentTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get documentTypeOther;

  /// No description provided for @documentDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Document date'**
  String get documentDateLabel;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectFile;

  /// No description provided for @noFileSelected.
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get noFileSelected;

  /// No description provided for @tagsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tags (comma separated)'**
  String get tagsLabel;

  /// No description provided for @documentUploadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Document uploaded'**
  String get documentUploadSuccess;

  /// No description provided for @searchDocuments.
  ///
  /// In en, this message translates to:
  /// **'Search documents...'**
  String get searchDocuments;

  /// No description provided for @noDocumentsFound.
  ///
  /// In en, this message translates to:
  /// **'No documents found.'**
  String get noDocumentsFound;

  /// No description provided for @exportTitle.
  ///
  /// In en, this message translates to:
  /// **'Vet Export'**
  String get exportTitle;

  /// No description provided for @exportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select the period for the report.'**
  String get exportSubtitle;

  /// No description provided for @includeSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Include symptoms'**
  String get includeSymptoms;

  /// No description provided for @includeMedications.
  ///
  /// In en, this message translates to:
  /// **'Include medications'**
  String get includeMedications;

  /// No description provided for @includeDocuments.
  ///
  /// In en, this message translates to:
  /// **'List documents'**
  String get includeDocuments;

  /// No description provided for @generatePdf.
  ///
  /// In en, this message translates to:
  /// **'Create PDF Report'**
  String get generatePdf;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Report created'**
  String get exportSuccess;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Report for {name}'**
  String reportTitle(String name);

  /// No description provided for @reportPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period: {start} to {end}'**
  String reportPeriod(String start, String end);

  /// No description provided for @switchPet.
  ///
  /// In en, this message translates to:
  /// **'Switch pet'**
  String get switchPet;

  /// No description provided for @addAnotherPet.
  ///
  /// In en, this message translates to:
  /// **'Add another pet'**
  String get addAnotherPet;

  /// No description provided for @managePets.
  ///
  /// In en, this message translates to:
  /// **'Manage pets'**
  String get managePets;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
