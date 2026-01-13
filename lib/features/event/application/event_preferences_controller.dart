import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EventPreferences {
  final Map<String, int> lastFrequencies;
  final Map<String, String> lastNotes;

  EventPreferences({
    required this.lastFrequencies,
    required this.lastNotes,
  });

  factory EventPreferences.empty() => EventPreferences(
        lastFrequencies: {},
        lastNotes: {},
      );

  factory EventPreferences.fromJson(Map<String, dynamic> json) {
    return EventPreferences(
      lastFrequencies: Map<String, int>.from(json['lastFrequencies'] as Map? ?? {}),
      lastNotes: Map<String, String>.from(json['lastNotes'] as Map? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'lastFrequencies': lastFrequencies,
        'lastNotes': lastNotes,
      };

  EventPreferences copyWith({
    Map<String, int>? lastFrequencies,
    Map<String, String>? lastNotes,
  }) {
    return EventPreferences(
      lastFrequencies: lastFrequencies ?? this.lastFrequencies,
      lastNotes: lastNotes ?? this.lastNotes,
    );
  }
}

class EventPreferencesController extends StateNotifier<EventPreferences> {
  static const _key = 'event_preferences';
  
  EventPreferencesController() : super(EventPreferences.empty()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      try {
        state = EventPreferences.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
      } catch (_) {
        state = EventPreferences.empty();
      }
    }
  }

  Future<void> saveLastValues({
    required String type,
    required int frequency,
    String? notes,
  }) async {
    final newFrequencies = Map<String, int>.from(state.lastFrequencies);
    final newNotes = Map<String, String>.from(state.lastNotes);
    
    newFrequencies[type] = frequency;
    if (notes != null && notes.isNotEmpty) {
      newNotes[type] = notes;
    } else {
      newNotes.remove(type);
    }

    state = state.copyWith(
      lastFrequencies: newFrequencies,
      lastNotes: newNotes,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(state.toJson()));
  }
}

final eventPreferencesProvider = StateNotifierProvider<EventPreferencesController, EventPreferences>((ref) {
  return EventPreferencesController();
});
