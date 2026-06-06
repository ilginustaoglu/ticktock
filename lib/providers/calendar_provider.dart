import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/database/calendar_repository.dart';
import '../core/storage/task_storage.dart';
import '../models/calendar_event.dart';
import 'auth_provider.dart';

const _uuid = Uuid();

final calendarEventsProvider =
    StateNotifierProvider<CalendarEventsNotifier, List<CalendarEvent>>((ref) {
  return CalendarEventsNotifier(ref)..load();
});

class CalendarEventsNotifier extends StateNotifier<List<CalendarEvent>> {
  CalendarEventsNotifier(this._ref) : super([]);

  final Ref _ref;

  String? get _userId => _ref.read(authProvider).user?.id;

  bool get _remote => AuthNotifier.usesRemoteDb && _userId != null;

  Future<void> load() async {
    if (_remote) {
      state = await CalendarRepository.fetchEvents(_userId!);
    } else {
      state = TaskStorage.getCalendarEvents();
    }
  }

  Future<void> add(CalendarEvent event) async {
    final e = event.id.isEmpty ? event.copyWith(id: _uuid.v4()) : event;
    if (_remote) {
      final saved = await CalendarRepository.insertEvent(userId: _userId!, event: e);
      state = [...state, saved];
    } else {
      state = [...state, e];
      await TaskStorage.saveCalendarEvents(state);
    }
  }

  Future<void> update(CalendarEvent event) async {
    state = [for (final e in state) e.id == event.id ? event : e];
    if (_remote) {
      await CalendarRepository.updateEvent(event, _userId!);
    } else {
      await TaskStorage.saveCalendarEvents(state);
    }
  }

  Future<void> delete(String id) async {
    state = state.where((e) => e.id != id).toList();
    if (_remote) {
      await CalendarRepository.deleteEvent(id, _userId!);
    } else {
      await TaskStorage.saveCalendarEvents(state);
    }
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
