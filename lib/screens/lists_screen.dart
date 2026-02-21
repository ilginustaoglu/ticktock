import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo_list.dart';
import '../providers/todo_provider.dart';
import '../widgets/theme_mode_button.dart';
import 'list_detail_screen.dart';

class ListsScreen extends ConsumerWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(todoListsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: const [
          ThemeModeButton(),
        ],
      ),
      body: lists.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.list_alt_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No lists yet',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create a new list',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: lists.length,
              itemBuilder: (context, i) {
                final list = lists[i];
                return _ListTile(
                  list: list,
                  onTap: () => _openListDetail(context, list),
                  onDelete: () => _confirmDelete(context, ref, list),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddListDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openListDetail(BuildContext context, TodoList list) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ListDetailScreen(list: list),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, TodoList list) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete list'),
        content: Text('Delete "${list.name}"? All tasks in it will be removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      ref.read(todoItemsProvider.notifier).deleteByListId(list.id);
      ref.read(todoListsProvider.notifier).delete(list.id);
    }
  }

  Future<void> _showAddListDialog(BuildContext context, WidgetRef ref) async {
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) {
        String value = '';
        return AlertDialog(
          title: const Text('New list'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'List name',
              hintText: 'e.g. Shopping, Work',
            ),
            onChanged: (v) => value = v,
            onSubmitted: (v) {
              value = v;
              Navigator.pop(ctx, value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, value),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
    if (name != null && name.trim().isNotEmpty && context.mounted) {
      await ref.read(todoListsProvider.notifier).add(name.trim());
    }
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.list,
    required this.onTap,
    required this.onDelete,
  });

  final TodoList list;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          Icons.list_alt,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(list.name),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () => _showMenu(context),
      ),
      onTap: onTap,
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Delete list'),
              onTap: () {
                Navigator.pop(ctx);
                onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
