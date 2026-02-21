import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/storage/task_storage.dart';
import '../models/calendar_event.dart';

const _uuid = Uuid();

final calendarEventsProvider =
    StateNotifierProvider<CalendarEventsNotifier, List<CalendarEvent>>((ref) {
  return CalendarEventsNotifier()..load();
});

class CalendarEventsNotifier extends StateNotifier<List<CalendarEvent>> {
  CalendarEventsNotifier() : super([]);

  void load() {
    state = TaskStorage.getCalendarEvents();
  }

  Future<void> add(CalendarEvent event) async {
    final e = event.id.isEmpty
        ? event.copyWith(id: _uuid.v4())
        : event;
    state = [...state, e];
    await TaskStorage.saveCalendarEvents(state);
  }

  Future<void> update(CalendarEvent event) async {
    state = [
      for (final e in state) e.id == event.id ? event : e,
    ];
    await TaskStorage.saveCalendarEvents(state);
  }

  Future<void> delete(String id) async {
    state = state.where((e) => e.id != id).toList();
    await TaskStorage.saveCalendarEvents(state);
  }

  List<CalendarEvent> eventsOn(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return state.where((e) {
      final s = e.start;
      return (s.isAfter(start) || s.isAtSameMomentAs(start)) && s.isBefore(end);
    }).toList();
  }
}
