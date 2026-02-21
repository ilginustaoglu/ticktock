import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/storage/task_storage.dart';
import '../core/widget/home_widget_helper.dart';
import '../models/todo_item.dart';
import '../models/todo_list.dart';

const _uuid = Uuid();

final todoListsProvider = StateNotifierProvider<TodoListsNotifier, List<TodoList>>((ref) {
  return TodoListsNotifier()..load();
});

final todoItemsProvider = StateNotifierProvider<TodoItemsNotifier, List<TodoItem>>((ref) {
  return TodoItemsNotifier()..load();
});

/// Tasks for a given list (incomplete first).
List<TodoItem> itemsForList(List<TodoItem> items, String listId) {
  final forList = items.where((e) => e.listId == listId).toList();
  forList.sort((a, b) {
    if (a.completed != b.completed) return a.completed ? 1 : -1;
    final aTime = a.createdAt ?? DateTime(0);
    final bTime = b.createdAt ?? DateTime(0);
    return bTime.compareTo(aTime);
  });
  return forList;
}

/// Tasks with a deadline on the given day (date only).
List<TodoItem> todosDueOn(List<TodoItem> items, DateTime day) {
  final start = DateTime(day.year, day.month, day.day);
  final end = start.add(const Duration(days: 1));
  return items.where((t) {
    final d = t.dueDate;
    if (d == null) return false;
    return !d.isBefore(start) && d.isBefore(end);
  }).toList();
}

class TodoListsNotifier extends StateNotifier<List<TodoList>> {
  TodoListsNotifier() : super([]);

  void load() {
    state = TaskStorage.getTodoLists();
    HomeWidgetHelper.updateWidgetData();
  }

  Future<void> add(String name) async {
    final list = TodoList(
      id: _uuid.v4(),
      name: name,
      createdAt: DateTime.now(),
    );
    state = [...state, list];
    await TaskStorage.saveTodoLists(state);
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> update(TodoList list) async {
    state = [
      for (final l in state) l.id == list.id ? list : l,
    ];
    await TaskStorage.saveTodoLists(state);
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> delete(String id) async {
    state = state.where((l) => l.id != id).toList();
    await TaskStorage.saveTodoLists(state);
    await HomeWidgetHelper.updateWidgetData();
  }
}

class TodoItemsNotifier extends StateNotifier<List<TodoItem>> {
  TodoItemsNotifier() : super([]);

  void load() {
    state = TaskStorage.getTodoItems();
    HomeWidgetHelper.updateWidgetData();
  }

  Future<void> add(String listId, String title, {DateTime? dueDate}) async {
    final item = TodoItem(
      id: _uuid.v4(),
      listId: listId,
      title: title,
      createdAt: DateTime.now(),
      dueDate: dueDate,
    );
    state = [...state, item];
    await TaskStorage.saveTodoItems(state);
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> toggleCompleted(TodoItem item) async {
    final updated = item.copyWith(
      completed: !item.completed,
      completedAt: item.completed ? null : DateTime.now(),
    );
    state = [
      for (final i in state) i.id == item.id ? updated : i,
    ];
    await TaskStorage.saveTodoItems(state);
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> update(TodoItem item) async {
    state = [
      for (final i in state) i.id == item.id ? item : i,
    ];
    await TaskStorage.saveTodoItems(state);
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> updateNote(TodoItem item, String? note) async {
    final updated = item.copyWith(note: note?.isEmpty == true ? null : note);
    state = [
      for (final i in state) i.id == item.id ? updated : i,
    ];
    await TaskStorage.saveTodoItems(state);
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> delete(TodoItem item) async {
    state = state.where((i) => i.id != item.id).toList();
    await TaskStorage.saveTodoItems(state);
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> deleteByListId(String listId) async {
    state = state.where((i) => i.listId != listId).toList();
    await TaskStorage.saveTodoItems(state);
    await HomeWidgetHelper.updateWidgetData();
  }
}
