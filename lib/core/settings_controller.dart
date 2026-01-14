import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends StateNotifier<bool> {
  static const _onboardingCompletedKey = 'onboarding_completed';

  SettingsController() : super(true) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);
    state = true;
  }
}

final settingsControllerProvider = StateNotifierProvider<SettingsController, bool>((ref) {
  return SettingsController();
});
