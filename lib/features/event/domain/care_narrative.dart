import 'event.dart';

class CarePhase {
  final DateTime startDate;
  final DateTime? endDate;
  final String dominantTopic;
  final List<Event> events;
  final List<int> planIdsStarted;
  final List<int> planIdsEnded;
  final bool isResolved;

  CarePhase({
    required this.startDate,
    this.endDate,
    required this.dominantTopic,
    required this.events,
    this.planIdsStarted = const [],
    this.planIdsEnded = const [],
    this.isResolved = false,
  });

  bool get isOngoing => endDate == null;

  CarePhase copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? dominantTopic,
    List<Event>? events,
    List<int>? planIdsStarted,
    List<int>? planIdsEnded,
    bool? isResolved,
  }) {
    return CarePhase(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dominantTopic: dominantTopic ?? this.dominantTopic,
      events: events ?? this.events,
      planIdsStarted: planIdsStarted ?? this.planIdsStarted,
      planIdsEnded: planIdsEnded ?? this.planIdsEnded,
      isResolved: isResolved ?? this.isResolved,
    );
  }
}
