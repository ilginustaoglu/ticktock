import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/database/todo_item_repository.dart';
import '../core/database/todo_list_repository.dart';
import '../core/storage/task_storage.dart';
import '../core/widget/home_widget_helper.dart';
import '../models/todo_item.dart';
import '../models/todo_list.dart';
import 'auth_provider.dart';

const _uuid = Uuid();

final todoListsProvider = StateNotifierProvider<TodoListsNotifier, List<TodoList>>((ref) {
  return TodoListsNotifier(ref)..load();
});

final todoItemsProvider = StateNotifierProvider<TodoItemsNotifier, List<TodoItem>>((ref) {
  return TodoItemsNotifier(ref)..load();
});

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
  TodoListsNotifier(this._ref) : super([]);

  final Ref _ref;

  String? get _userId => _ref.read(authProvider).user?.id;

  bool get _remote => AuthNotifier.usesRemoteDb && _userId != null;

  Future<void> load() async {
    if (_remote) {
      state = await TodoRepository.fetchLists(_userId!);
    } else {
      state = TaskStorage.getTodoLists();
    }
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> add(String name) async {
    if (_remote) {
      final list = await TodoRepository.insertList(
        userId: _userId!,
        id: _uuid.v4(),
        name: name,
      );
      state = [...state, list];
    } else {
      final list = TodoList(id: _uuid.v4(), name: name, createdAt: DateTime.now());
      state = [...state, list];
      await TaskStorage.saveTodoLists(state);
    }
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> update(TodoList list) async {
    state = [for (final l in state) l.id == list.id ? list : l];
    if (_remote) {
      await TodoRepository.updateList(list, _userId!);
    } else {
      await TaskStorage.saveTodoLists(state);
    }
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> delete(String id) async {
    state = state.where((l) => l.id != id).toList();
    if (_remote) {
      await TodoRepository.deleteList(id, _userId!);
    } else {
      await TaskStorage.saveTodoLists(state);
    }
    await HomeWidgetHelper.updateWidgetData();
  }
}

class TodoItemsNotifier extends StateNotifier<List<TodoItem>> {
  TodoItemsNotifier(this._ref) : super([]);

  final Ref _ref;

  String? get _userId => _ref.read(authProvider).user?.id;

  bool get _remote => AuthNotifier.usesRemoteDb && _userId != null;

  Future<void> load() async {
    if (_remote) {
      state = await TodoItemRepository.fetchItems(_userId!);
    } else {
      state = TaskStorage.getTodoItems();
    }
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> add(String listId, String title, {DateTime? dueDate}) async {
    final item = TodoItem(
      id: _uuid.v4(),
      listId: listId,
      title: title,
      createdAt: DateTime.now(),
      dueDate: dueDate,
    );
    if (_remote) {
      final saved = await TodoItemRepository.insertItem(userId: _userId!, item: item);
      state = [...state, saved];
    } else {
      state = [...state, item];
      await TaskStorage.saveTodoItems(state);
    }
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> toggleCompleted(TodoItem item) async {
    final updated = item.copyWith(
      completed: !item.completed,
      completedAt: item.completed ? null : DateTime.now(),
    );
    state = [for (final i in state) i.id == item.id ? updated : i];
    if (_remote) {
      await TodoItemRepository.updateItem(updated, _userId!);
    } else {
      await TaskStorage.saveTodoItems(state);
    }
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> update(TodoItem item) async {
    state = [for (final i in state) i.id == item.id ? item : i];
    if (_remote) {
      await TodoItemRepository.updateItem(item, _userId!);
    } else {
      await TaskStorage.saveTodoItems(state);
    }
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> updateNote(TodoItem item, String? note) async {
    final updated = item.copyWith(note: note?.isEmpty == true ? null : note);
    state = [for (final i in state) i.id == item.id ? updated : i];
    if (_remote) {
      await TodoItemRepository.updateItem(updated, _userId!);
    } else {
      await TaskStorage.saveTodoItems(state);
    }
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> delete(TodoItem item) async {
    state = state.where((i) => i.id != item.id).toList();
    if (_remote) {
      await TodoItemRepository.deleteItem(item.id, _userId!);
    } else {
      await TaskStorage.saveTodoItems(state);
    }
    await HomeWidgetHelper.updateWidgetData();
  }

  Future<void> deleteByListId(String listId) async {
    state = state.where((i) => i.listId != listId).toList();
    if (_remote) {
      await TodoItemRepository.deleteByListId(listId, _userId!);
    } else {
      await TaskStorage.saveTodoItems(state);
    }
    await HomeWidgetHelper.updateWidgetData();
  }
}
