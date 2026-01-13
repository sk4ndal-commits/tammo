import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/onboarding_screen.dart';
import '../ui/screens/pet_edit_screen.dart';
import '../features/pet/application/pet_controller.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final petState = ref.watch(petControllerProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/edit-pet',
        builder: (context, state) => const PetEditScreen(),
      ),
    ],
    redirect: (context, state) {
      if (petState.isLoading) return null;

      final hasPet = petState.value != null;
      final isGoingToOnboarding = state.matchedLocation == '/onboarding';

      if (!hasPet && !isGoingToOnboarding) {
        return '/onboarding';
      }

      if (hasPet && isGoingToOnboarding) {
        return '/';
      }

      return null;
    },
  );
});
