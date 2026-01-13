import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/onboarding_screen.dart';
import '../ui/screens/pet_edit_screen.dart';
import '../ui/screens/symptom_log_screen.dart';
import '../ui/screens/statistics_screen.dart';
import '../ui/screens/medication_plan_screen.dart';
import '../ui/screens/feeding_plan_screen.dart';
import '../ui/screens/document_list_screen.dart';
import '../ui/screens/document_upload_screen.dart';
import '../ui/screens/export_screen.dart';
import '../features/pet/application/pet_controller.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final petState = ref.watch(petControllerProvider);

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
    ],
    redirect: (context, state) {
      if (petState.isLoading) return null;

      final hasPet = petState.value?.activePet != null;
      final isGoingToOnboarding = state.matchedLocation == '/onboarding';

      if (!hasPet && !isGoingToOnboarding) {
        return '/onboarding';
      }

      return null;
    },
  );
});
