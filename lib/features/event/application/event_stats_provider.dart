import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'event_controller.dart';
import '../domain/event.dart';

enum StatsPeriod {
  last7Days,
  last30Days,
}

class EventStats {
  final Map<String, int> countsByType;
  final List<Event> recentEvents;

  EventStats({
    required this.countsByType,
    required this.recentEvents,
  });

  bool isConspicuous(String type, int threshold) {
    return (countsByType[type] ?? 0) >= threshold;
  }
}

final statsPeriodProvider = StateProvider<StatsPeriod>((ref) => StatsPeriod.last7Days);

final eventStatsProvider = Provider<AsyncValue<EventStats>>((ref) {
  final eventState = ref.watch(eventControllerProvider);
  final period = ref.watch(statsPeriodProvider);

  return eventState.whenData((events) {
    final now = DateTime.now();
    final days = period == StatsPeriod.last7Days ? 7 : 30;
    final thresholdDate = now.subtract(Duration(days: days));

    final filteredEvents = events.where((e) => e.timestamp.isAfter(thresholdDate)).toList();

    final counts = <String, int>{};
    for (final event in filteredEvents) {
      counts[event.type] = (counts[event.type] ?? 0) + event.frequency;
    }

    return EventStats(
      countsByType: counts,
      recentEvents: filteredEvents,
    );
  });
});
