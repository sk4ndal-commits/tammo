import '../domain/event.dart';
import '../domain/care_narrative.dart';
import '../../medication/domain/medication.dart';

class NarrativeEngine {
  /// Gruppiert Events und Pläne in Care-Phasen basierend auf Regeln.
  /// 
  /// Regeln:
  /// 1. ≥2 Symptome desselben Typs innerhalb von 3 Tagen starten eine Phase.
  /// 2. Ein Symptom korreliert mit dem Start/Ende eines Plans (±2 Tage).
  static List<CarePhase> detectPhases({
    required List<Event> events,
    required List<MedicationSchedule> medicationSchedules,
  }) {
    if (events.isEmpty) return [];

    // Events chronologisch sortieren (älteste zuerst für die Erkennung)
    final sortedEvents = List<Event>.from(events)..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    final List<CarePhase> phases = [];
    final Set<int> assignedEventIds = {};

    for (int i = 0; i < sortedEvents.length; i++) {
      final event = sortedEvents[i];
      if (assignedEventIds.contains(event.id)) continue;

      // Versuche eine neue Phase zu starten
      // Regel 1: Suche nach weiteren Events desselben Typs innerhalb von 3 Tagen
      final relatedEvents = sortedEvents.where((e) {
        if (assignedEventIds.contains(e.id)) return false;
        if (e.type != event.type) return false;
        final diff = e.timestamp.difference(event.timestamp).abs().inDays;
        return diff <= 3;
      }).toList();

      // Regel 2: Korrelation mit Plänen
      final relatedPlansStarted = medicationSchedules.where((s) {
        final diff = s.startDate.difference(event.timestamp).abs().inDays;
        return diff <= 2;
      }).toList();

      final relatedPlansEnded = medicationSchedules.where((s) {
        if (s.endDate == null) return false;
        final diff = s.endDate!.difference(event.timestamp).abs().inDays;
        return diff <= 2;
      }).toList();

      if (relatedEvents.length >= 2 || relatedPlansStarted.isNotEmpty || relatedPlansEnded.isNotEmpty) {
        // Phase erstellen
        final phaseEvents = relatedEvents;
        for (var e in phaseEvents) {
          assignedEventIds.add(e.id!);
        }

        final startDate = phaseEvents.map((e) => e.timestamp).reduce((a, b) => a.isBefore(b) ? a : b);
        DateTime? endDate;
        
        // Wenn das letzte Event mehr als 4 Tage her ist, betrachten wir die Phase als beendet (einfache Heuristik)
        final lastEventDate = phaseEvents.map((e) => e.timestamp).reduce((a, b) => a.isAfter(b) ? a : b);
        if (DateTime.now().difference(lastEventDate).inDays > 4) {
          endDate = lastEventDate;
        }

        phases.add(CarePhase(
          startDate: startDate,
          endDate: endDate,
          dominantTopic: event.type,
          events: phaseEvents,
          planIdsStarted: relatedPlansStarted.map((s) => s.id!).toList(),
          planIdsEnded: relatedPlansEnded.map((s) => s.id!).toList(),
          isResolved: endDate != null,
        ));
      }
    }

    // Sortiere Phasen (neueste zuerst für die UI)
    return phases..sort((a, b) => b.startDate.compareTo(a.startDate));
  }
}
