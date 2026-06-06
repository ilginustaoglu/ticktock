import '../../models/todo_list.dart';
import '../database/supabase_service.dart';

class TodoRepository {
  static Future<List<TodoList>> fetchLists(String userId) async {
    final rows = await SupabaseService.client
        .from('todo_lists')
        .select()
        .eq('user_id', userId)
        .order('created_at');
    return rows.map((r) => TodoList.fromSupabase(Map<String, dynamic>.from(r))).toList();
  }

  static Future<TodoList> insertList({
    required String userId,
    required String id,
    required String name,
  }) async {
    final row = await SupabaseService.client
        .from('todo_lists')
        .insert({
          'id': id,
          'user_id': userId,
          'name': name,
        })
        .select()
        .single();
    return TodoList.fromSupabase(Map<String, dynamic>.from(row));
  }

  static Future<void> updateList(TodoList list, String userId) async {
    await SupabaseService.client.from('todo_lists').update({
      'name': list.name,
      'color_hex': list.colorHex,
    }).eq('id', list.id).eq('user_id', userId);
  }

  static Future<void> deleteList(String listId, String userId) async {
    await SupabaseService.client
        .from('todo_lists')
        .delete()
        .eq('id', listId)
        .eq('user_id', userId);
  }
}
