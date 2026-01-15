import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/app_onboarding_screen.dart';
import '../ui/screens/onboarding_screen.dart';
import '../ui/screens/pet_edit_screen.dart';
import '../ui/screens/symptom_log_screen.dart';
import '../ui/screens/statistics_screen.dart';
import '../ui/screens/medication_plan_screen.dart';
import '../ui/screens/feeding_plan_screen.dart';
import '../ui/screens/plan_list_screen.dart';
import '../ui/screens/document_list_screen.dart';
import '../ui/screens/document_upload_screen.dart';
import '../ui/screens/export_screen.dart';
import '../ui/screens/emergency_screen.dart';
import '../ui/screens/backup_screen.dart';
import '../ui/screens/household_screen.dart';
import '../features/pet/application/pet_controller.dart';
import 'settings_controller.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final petState = ref.watch(petControllerProvider);
  final onboardingCompleted = ref.watch(settingsControllerProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final expandTimeline = state.uri.queryParameters['expandTimeline'] == 'true';
          return HomeScreen(expandTimeline: expandTimeline);
        },
      ),
      GoRoute(
        path: '/app-onboarding',
        builder: (context, state) => const AppOnboardingScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/edit-pet',
        builder: (context, state) => const PetEditScreen(),
      ),
      GoRoute(
        path: '/symptom-log',
        builder: (context, state) => const SymptomLogScreen(),
      ),
      GoRoute(
        path: '/statistics',
        builder: (context, state) => const StatisticsScreen(),
      ),
      GoRoute(
        path: '/medication-plan',
        builder: (context, state) => const MedicationPlanScreen(),
      ),
      GoRoute(
        path: '/feeding-plan',
        builder: (context, state) => const FeedingPlanScreen(),
      ),
      GoRoute(
        path: '/plans',
        builder: (context, state) => const PlanListScreen(),
      ),
      GoRoute(
        path: '/documents',
        builder: (context, state) => const DocumentListScreen(),
      ),
      GoRoute(
        path: '/document-upload',
        builder: (context, state) => const DocumentUploadScreen(),
      ),
      GoRoute(
        path: '/export',
        builder: (context, state) => const ExportScreen(),
      ),
      GoRoute(
        path: '/emergency',
        builder: (context, state) => const EmergencyScreen(),
      ),
      GoRoute(
        path: '/backup',
        builder: (context, state) => const BackupScreen(),
      ),
      GoRoute(
        path: '/household',
        builder: (context, state) => const HouseholdScreen(),
      ),
    ],
    redirect: (context, state) {
      if (petState.isLoading) return null;

      if (!onboardingCompleted) {
        if (state.matchedLocation != '/app-onboarding') {
          return '/app-onboarding';
        }
        return null;
      }

      final hasPet = petState.value?.activePet != null;
      final isOnboardingFlow = state.matchedLocation == '/onboarding' || state.matchedLocation == '/app-onboarding';

      if (!hasPet && !isOnboardingFlow) {
        return '/onboarding';
      }

      return null;
    },
  );
});
