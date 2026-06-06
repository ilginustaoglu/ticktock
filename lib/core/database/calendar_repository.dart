import '../../models/calendar_event.dart';
import '../database/supabase_service.dart';

class CalendarRepository {
  static Future<List<CalendarEvent>> fetchEvents(String userId) async {
    final rows = await SupabaseService.client
        .from('calendar_events')
        .select()
        .eq('user_id', userId)
        .order('start_at');
    return rows
        .map((r) => CalendarEvent.fromSupabase(Map<String, dynamic>.from(r)))
        .toList();
  }

  static Future<CalendarEvent> insertEvent({
    required String userId,
    required CalendarEvent event,
  }) async {
    final row = await SupabaseService.client
        .from('calendar_events')
        .insert(_toRow(event, userId))
        .select()
        .single();
    return CalendarEvent.fromSupabase(Map<String, dynamic>.from(row));
  }

  static Future<void> updateEvent(CalendarEvent event, String userId) async {
    await SupabaseService.client
        .from('calendar_events')
        .update(_toRow(event, userId))
        .eq('id', event.id)
        .eq('user_id', userId);
  }

  static Future<void> deleteEvent(String eventId, String userId) async {
    await SupabaseService.client
        .from('calendar_events')
        .delete()
        .eq('id', eventId)
        .eq('user_id', userId);
  }

  static Map<String, dynamic> _toRow(CalendarEvent event, String userId) => {
        'id': event.id,
        'user_id': userId,
        'title': event.title,
        'start_at': event.start.toUtc().toIso8601String(),
        'end_at': event.end.toUtc().toIso8601String(),
        'all_day': event.allDay,
        'note': event.note,
        'color_hex': event.colorHex,
        'todo_item_id': event.todoItemId,
      };
}
