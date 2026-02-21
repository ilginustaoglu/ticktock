import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo_item.dart';
import '../models/todo_list.dart';
import '../providers/todo_provider.dart';

class ListDetailScreen extends ConsumerStatefulWidget {
  const ListDetailScreen({super.key, required this.list});

  final TodoList list;

  @override
  ConsumerState<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends ConsumerState<ListDetailScreen> {
  final _controller = TextEditingController();
  DateTime? _pendingDueDate;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lists = ref.watch(todoListsProvider);
    final items = ref.watch(todoItemsProvider);
    final list = lists.cast<TodoList?>().firstWhere(
          (l) => l?.id == widget.list.id,
          orElse: () => null,
        ) ??
        widget.list;
    final listItems = itemsForList(items, list.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(list.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a task',
                    prefixIcon: const Icon(Icons.add),
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: _addItem,
                          )
                        : null,
                  ),
                  onSubmitted: (_) => _addItem(),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.event_outlined, size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    const SizedBox(width: 6),
                    Text(
                      _pendingDueDate != null
                          ? _formatDueDate(_pendingDueDate!)
                          : 'No deadline',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _pendingDueDate ?? DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                        );
                        if (date != null && mounted) setState(() => _pendingDueDate = date);
                      },
                      child: Text(_pendingDueDate == null ? 'Set deadline' : 'Change'),
                    ),
                    if (_pendingDueDate != null)
                      TextButton(
                        onPressed: () => setState(() => _pendingDueDate = null),
                        child: const Text('Clear'),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: listItems.isEmpty
                ? Center(
                    child: Text(
                      'No tasks in this list yet',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: listItems.length,
                    itemBuilder: (context, i) {
                      final item = listItems[i];
                      return _TodoItemTile(
                        key: ValueKey(item.id),
                        item: item,
                        onToggle: () => ref
                            .read(todoItemsProvider.notifier)
                            .toggleCompleted(item),
                        onTap: () => _openItemDetail(context, ref, item),
                        onDelete: () => ref
                            .read(todoItemsProvider.notifier)
                            .delete(item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _formatDueDate(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  void _addItem() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    ref.read(todoItemsProvider.notifier).add(widget.list.id, title, dueDate: _pendingDueDate);
    _controller.clear();
    setState(() => _pendingDueDate = null);
  }

  void _openItemDetail(BuildContext context, WidgetRef ref, TodoItem item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _ItemDetailSheet(
        item: item,
        onSaveNote: (note) {
          ref.read(todoItemsProvider.notifier).updateNote(item, note);
        },
        onUpdate: (updated) {
          ref.read(todoItemsProvider.notifier).update(updated);
        },
      ),
    );
  }
}

class _TodoItemTile extends StatelessWidget {
  const _TodoItemTile({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onTap,
    required this.onDelete,
  });

  final TodoItem item;
  final VoidCallback onToggle;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final hasNote = item.note != null && item.note!.isNotEmpty;
    final hasDue = item.dueDate != null;
    String? subtitle;
    if (hasNote && hasDue) {
      subtitle = '${item.note}\nDue: ${_formatDue(item.dueDate!)}';
    } else if (hasNote) {
      subtitle = item.note;
    } else if (hasDue) {
      subtitle = 'Due: ${_formatDue(item.dueDate!)}';
    }

    return Card(
      key: key,
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            item.completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: item.completed
                ? Theme.of(context).colorScheme.tertiary
                : Theme.of(context).colorScheme.outline,
          ),
          onPressed: onToggle,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            decoration: item.completed ? TextDecoration.lineThrough : null,
            color: item.completed
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : null,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              )
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showMenu(context),
        ),
        onTap: onTap,
      ),
    );
  }

  String _formatDue(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${d.day} ${months[d.month - 1]}';
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: ListTile(
          leading: const Icon(Icons.delete_outline),
          title: const Text('Delete task'),
          onTap: () {
            Navigator.pop(ctx);
            onDelete();
          },
        ),
      ),
    );
  }
}

class _ItemDetailSheet extends StatefulWidget {
  const _ItemDetailSheet({
    required this.item,
    required this.onSaveNote,
    required this.onUpdate,
  });

  final TodoItem item;
  final void Function(String? note) onSaveNote;
  final void Function(TodoItem updated) onUpdate;

  @override
  State<_ItemDetailSheet> createState() => _ItemDetailSheetState();
}

class _ItemDetailSheetState extends State<_ItemDetailSheet> {
  late TextEditingController _noteController;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.item.note ?? '');
    _dueDate = widget.item.dueDate;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.item.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.event_outlined, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  title: Text(_dueDate != null ? _formatDue(_dueDate!) : 'No deadline'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _dueDate ?? DateTime.now(),
                            firstDate: DateTime.now().subtract(const Duration(days: 365)),
                            lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                          );
                          if (date != null && mounted) {
                            setState(() => _dueDate = date);
                            widget.onUpdate(widget.item.copyWith(dueDate: date));
                          }
                        },
                        child: Text(_dueDate == null ? 'Set deadline' : 'Change'),
                      ),
                      if (_dueDate != null)
                        TextButton(
                          onPressed: () {
                            setState(() => _dueDate = null);
                            widget.onUpdate(widget.item.copyWith(clearDueDate: true));
                          },
                          child: const Text('Clear'),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _noteController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    hintText: 'Add a note...',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (_) => widget.onSaveNote(_noteController.text),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    widget.onSaveNote(_noteController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDue(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}
