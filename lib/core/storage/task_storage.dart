import 'package:hive_flutter/hive_flutter.dart';

import '../../models/calendar_event.dart';
import '../../models/todo_item.dart';
import '../../models/todo_list.dart';

const String _boxName = 'ticktock_task_data';
const String _keyLists = 'todo_lists';
const String _keyItems = 'todo_items';
const String _keyEvents = 'calendar_events';
const String _keyThemeMode = 'theme_mode';

/// Hive ile todo listeleri, görevler ve takvim etkinliklerini saklar.
class TaskStorage {
  static late Box<dynamic> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<dynamic>(_boxName);
  }

  // ——— Todo lists ———
  static List<TodoList> getTodoLists() {
    final raw = _box.get(_keyLists);
    if (raw == null || raw is! List) return [];
    return (raw as List)
        .map((e) => TodoList.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  static Future<void> saveTodoLists(List<TodoList> lists) async {
    await _box.put(
      _keyLists,
      lists.map((e) => e.toJson()).toList(),
    );
  }

  // ——— Todo items ———
  static List<TodoItem> getTodoItems() {
    final raw = _box.get(_keyItems);
    if (raw == null || raw is! List) return [];
    return (raw as List)
        .map((e) => TodoItem.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  static Future<void> saveTodoItems(List<TodoItem> items) async {
    await _box.put(
      _keyItems,
      items.map((e) => e.toJson()).toList(),
    );
  }

  // ——— Calendar events ———
  static List<CalendarEvent> getCalendarEvents() {
    final raw = _box.get(_keyEvents);
    if (raw == null || raw is! List) return [];
    return (raw as List)
        .map((e) => CalendarEvent.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  static Future<void> saveCalendarEvents(List<CalendarEvent> events) async {
    await _box.put(
      _keyEvents,
      events.map((e) => e.toJson()).toList(),
    );
  }

  // ——— Theme mode ('light' | 'dark' | 'system') ———
  static String getThemeMode() {
    final v = _box.get(_keyThemeMode);
    if (v is String && ['light', 'dark', 'system'].contains(v)) return v;
    return 'system';
  }

  static Future<void> saveThemeMode(String value) async {
    await _box.put(_keyThemeMode, value);
  }
}
