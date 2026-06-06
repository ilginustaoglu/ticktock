import '../../models/todo_item.dart';
import '../database/supabase_service.dart';

class TodoItemRepository {
  static Future<List<TodoItem>> fetchItems(String userId) async {
    final rows = await SupabaseService.client
        .from('todo_items')
        .select()
        .eq('user_id', userId)
        .order('created_at');
    return rows.map((r) => TodoItem.fromSupabase(Map<String, dynamic>.from(r))).toList();
  }

  static Future<TodoItem> insertItem({
    required String userId,
    required TodoItem item,
  }) async {
    final row = await SupabaseService.client
        .from('todo_items')
        .insert(_toRow(item, userId))
        .select()
        .single();
    return TodoItem.fromSupabase(Map<String, dynamic>.from(row));
  }

  static Future<void> updateItem(TodoItem item, String userId) async {
    await SupabaseService.client
        .from('todo_items')
        .update(_toRow(item, userId))
        .eq('id', item.id)
        .eq('user_id', userId);
  }

  static Future<void> deleteItem(String itemId, String userId) async {
    await SupabaseService.client
        .from('todo_items')
        .delete()
        .eq('id', itemId)
        .eq('user_id', userId);
  }

  static Future<void> deleteByListId(String listId, String userId) async {
    await SupabaseService.client
        .from('todo_items')
        .delete()
        .eq('list_id', listId)
        .eq('user_id', userId);
  }

  static Map<String, dynamic> _toRow(TodoItem item, String userId) => {
        'id': item.id,
        'list_id': item.listId,
        'user_id': userId,
        'title': item.title,
        'note': item.note,
        'completed': item.completed,
        'due_date': item.dueDate?.toUtc().toIso8601String(),
        'created_at': item.createdAt?.toUtc().toIso8601String(),
        'completed_at': item.completedAt?.toUtc().toIso8601String(),
      };
}
