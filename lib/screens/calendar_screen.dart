import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../core/theme/calendar_colors.dart';
import '../models/calendar_event.dart';
import '../models/todo_item.dart';
import '../providers/calendar_provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/theme_mode_button.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(calendarEventsProvider);
    final todoItems = ref.watch(todoItemsProvider);
    final eventsOnSelected = _selectedDay != null
        ? ref.read(calendarEventsProvider.notifier).eventsOn(_selectedDay!)
        : <CalendarEvent>[];
    final todosDueSelected = _selectedDay != null
        ? todosDueOn(todoItems, _selectedDay!)
        : <TodoItem>[];
    final hasAny = eventsOnSelected.isNotEmpty || todosDueSelected.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          const ThemeModeButton(),
          IconButton(
            icon: Icon(
              _format == CalendarFormat.month ? Icons.view_week : Icons.calendar_view_month,
            ),
            onPressed: () {
              setState(() {
                _format = _format == CalendarFormat.month
                    ? CalendarFormat.twoWeeks
                    : CalendarFormat.month;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: TableCalendar<CalendarEvent>(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _format,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                eventLoader: (day) =>
                    events.where((e) => isSameDay(e.start, day)).toList(),
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                  });
                },
                onFormatChanged: (format) => setState(() => _format = format),
                onPageChanged: (focused) => setState(() => _focusedDay = focused),
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  outsideDaysVisible: false,
                  markersMaxCount: 0,
                  defaultTextStyle: Theme.of(context).textTheme.bodyMedium!,
                  weekendTextStyle: Theme.of(context).textTheme.bodyMedium!,
                  cellMargin: const EdgeInsets.all(2),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  outsideDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  markerDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders<CalendarEvent>(
                  defaultBuilder: (context, day, focusedDay) =>
                      _buildDayCell(context, day, events, todoItems),
                  selectedBuilder: (context, day, focusedDay) =>
                      _buildDayCell(context, day, events, todoItems),
                  markerBuilder: (context, day, dayEvents) => null,
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: const Icon(Icons.chevron_left),
                  rightChevronIcon: const Icon(Icons.chevron_right),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _selectedDay != null
                    ? _formatDayTitle(_selectedDay!)
                    : 'Events & tasks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            if (!hasAny)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'No events or tasks due on this day',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              )
            else
              ...[
                if (eventsOnSelected.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      'Events',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                  ...eventsOnSelected.map(
                    (e) {
                      final color = e.colorHex != null
                          ? CalendarColors.colorFromHex(e.colorHex!)
                          : Theme.of(context).colorScheme.primary;
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color.withValues(alpha: 0.2),
                            child: Icon(Icons.event, color: color, size: 20),
                          ),
                          title: Text(e.title),
                          subtitle: e.note != null && e.note!.isNotEmpty
                              ? Text(e.note!, maxLines: 1, overflow: TextOverflow.ellipsis)
                              : Text(
                                  _formatTimeRange(e.start, e.end),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                          trailing: const Icon(Icons.edit_outlined, size: 20),
                          onTap: () => _showEditEventSheet(context, ref, e),
                        ),
                      );
                    },
                  ),
                ],
                if (todosDueSelected.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      'Tasks due',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                  ...todosDueSelected.map(
                    (t) => Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(
                            Icons.check_circle_outline,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            size: 20,
                          ),
                        ),
                        title: Text(t.title),
                        subtitle: t.completed
                            ? Text(
                                'Completed',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.tertiary,
                                    ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDayCell(BuildContext context, DateTime day, List<CalendarEvent> events, List<TodoItem> todoItems) {
    final dayEvents = events.where((e) => isSameDay(e.start, day)).toList();
    final dayTodos = todosDueOn(todoItems, day);
    final dotColors = <Color>[
      ...dayEvents.map((e) => e.colorHex != null
          ? CalendarColors.colorFromHex(e.colorHex!)
          : Theme.of(context).colorScheme.primary),
      ...dayTodos.map((_) => Theme.of(context).colorScheme.tertiary),
    ];
    final isSelected = isSameDay(day, _selectedDay);
    final isToday = isSameDay(day, DateTime.now());
    final textStyle = isSelected
        ? Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
              decoration: isToday ? TextDecoration.underline : null,
              decorationColor: Theme.of(context).colorScheme.onPrimary,
            )
        : Theme.of(context).textTheme.bodyMedium!.copyWith(
              decoration: isToday ? TextDecoration.underline : null,
              decorationColor: Theme.of(context).colorScheme.primary,
            );
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (isSelected)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        Center(child: Text('${day.day}', style: textStyle)),
        if (dotColors.isNotEmpty)
          _DayFrameDots(colors: dotColors, dotSize: 4, inset: 3),
      ],
    );
  }

  String _formatDayTitle(DateTime day) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[day.month - 1]} ${day.day}, ${day.year}';
  }

  String _formatTimeRange(DateTime start, DateTime end) {
    return '${_formatTime(start)} – ${_formatTime(end)}';
  }

  String _formatTime(DateTime d) {
    return '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _showAddEventDialog(BuildContext context, WidgetRef ref) async {
    DateTime start = _selectedDay ?? DateTime.now();
    start = DateTime(start.year, start.month, start.day, start.hour, start.minute);
    DateTime end = start.add(const Duration(hours: 1));

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => _AddEventDialogContent(
        start: start,
        end: end,
      ),
    );
    if (result != null &&
        result['title'] != null &&
        (result['title'] as String).trim().isNotEmpty &&
        context.mounted) {
      await ref.read(calendarEventsProvider.notifier).add(
            CalendarEvent(
              id: '',
              title: (result['title'] as String).trim(),
              start: result['start'] as DateTime,
              end: result['end'] as DateTime,
              note: result['note'] as String?,
              colorHex: result['colorHex'] as int?,
            ),
          );
    }
  }

  void _showEditEventSheet(BuildContext context, WidgetRef ref, CalendarEvent event) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: _EditEventSheetContent(
          event: event,
          onSave: (updated) async {
            await ref.read(calendarEventsProvider.notifier).update(updated);
            if (ctx.mounted) Navigator.of(ctx).pop();
          },
          onDelete: () async {
            await ref.read(calendarEventsProvider.notifier).delete(event.id);
            if (ctx.mounted) Navigator.of(ctx).pop();
          },
        ),
      ),
    );
  }
}

/// Arranges colored dots along the inner edge of the day cell (top, right, bottom, left).
class _DayFrameDots extends StatelessWidget {
  const _DayFrameDots({
    required this.colors,
    this.dotSize = 4,
    this.inset = 3,
  });

  final List<Color> colors;
  final double dotSize;
  final double inset;

  @override
  Widget build(BuildContext context) {
    final n = colors.length;
    if (n == 0) return const SizedBox.shrink();
    final perSide = (n + 3) ~/ 4;
    final topColors = colors.sublist(0, n < perSide ? n : perSide);
    final rightColors = n > perSide ? colors.sublist(perSide, n < 2 * perSide ? n : 2 * perSide) : <Color>[];
    final bottomColors = n > 2 * perSide ? colors.sublist(2 * perSide, n < 3 * perSide ? n : 3 * perSide) : <Color>[];
    final leftColors = n > 3 * perSide ? colors.sublist(3 * perSide) : <Color>[];

    return Positioned.fill(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (topColors.isNotEmpty)
            Positioned(
              left: inset,
              right: inset,
              top: inset,
              height: dotSize + 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _dotWidgets(topColors),
              ),
            ),
          if (rightColors.isNotEmpty)
            Positioned(
              right: inset,
              top: inset,
              bottom: inset,
              width: dotSize + 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _dotWidgets(rightColors),
              ),
            ),
          if (bottomColors.isNotEmpty)
            Positioned(
              left: inset,
              right: inset,
              bottom: inset,
              height: dotSize + 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _dotWidgets(bottomColors),
              ),
            ),
          if (leftColors.isNotEmpty)
            Positioned(
              left: inset,
              top: inset,
              bottom: inset,
              width: dotSize + 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _dotWidgets(leftColors),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _dotWidgets(List<Color> list) {
    return list.map((color) => Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    )).toList();
  }
}

/// Edit calendar event: title, note, color, start/end, delete.
class _EditEventSheetContent extends StatefulWidget {
  const _EditEventSheetContent({
    required this.event,
    required this.onSave,
    required this.onDelete,
  });

  final CalendarEvent event;
  final void Function(CalendarEvent updated) onSave;
  final VoidCallback onDelete;

  @override
  State<_EditEventSheetContent> createState() => _EditEventSheetContentState();
}

class _EditEventSheetContentState extends State<_EditEventSheetContent> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  late DateTime _start;
  late DateTime _end;
  late int? _colorHex;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _noteController = TextEditingController(text: widget.event.note ?? '');
    _start = widget.event.start;
    _end = widget.event.end;
    _colorHex = widget.event.colorHex;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isStart ? _start : _end,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isStart ? _start : _end),
    );
    if (time == null || !mounted) return;
    setState(() {
      final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      if (isStart) {
        _start = dt;
        if (_end.isBefore(_start) || _end.isAtSameMomentAs(_start)) {
          _end = _start.add(const Duration(hours: 1));
        }
      } else {
        _end = dt;
        if (_end.isBefore(_start)) _start = _end.subtract(const Duration(hours: 1));
      }
    });
  }

  String _formatDateTime(DateTime d) {
    return '${d.day}.${d.month}.${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Edit event',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            Text(
              'Color',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: CalendarColors.eventColorHexes.map((hex) {
                final isSelected = _colorHex == hex;
                return GestureDetector(
                  onTap: () => setState(() => _colorHex = hex),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: CalendarColors.colorFromHex(hex),
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 2,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Start'),
              subtitle: Text(_formatDateTime(_start)),
              trailing: const Icon(Icons.edit_calendar),
              onTap: () => _pickDateTime(true),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('End'),
              subtitle: Text(_formatDateTime(_end)),
              trailing: const Icon(Icons.edit_calendar),
              onTap: () => _pickDateTime(false),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                alignLabelWithHint: true,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Delete event'),
                        content: const Text('Permanently delete this event?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.error,
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    if (ok == true) widget.onDelete();
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Delete'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    final title = _titleController.text.trim();
                    if (title.isEmpty) return;
                    widget.onSave(
                      widget.event.copyWith(
                        title: title,
                        note: _noteController.text.trim().isEmpty
                            ? null
                            : _noteController.text.trim(),
                        start: _start,
                        end: _end,
                        colorHex: _colorHex,
                      ),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddEventDialogContent extends StatefulWidget {
  const _AddEventDialogContent({required this.start, required this.end});

  final DateTime start;
  final DateTime end;

  @override
  State<_AddEventDialogContent> createState() => _AddEventDialogContentState();
}

class _AddEventDialogContentState extends State<_AddEventDialogContent> {
  late String title;
  late String? note;
  late int? selectedColorHex;
  late DateTime _start;
  late DateTime _end;

  @override
  void initState() {
    super.initState();
    title = '';
    note = null;
    selectedColorHex = CalendarColors.defaultEventColorHex;
    _start = widget.start;
    _end = widget.end;
  }

  Future<void> _pickStartDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _start,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_start),
    );
    if (time == null || !mounted) return;
    setState(() {
      _start = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      if (_end.isBefore(_start) || _end.isAtSameMomentAs(_start)) {
        _end = _start.add(const Duration(hours: 1));
      }
    });
  }

  Future<void> _pickEndDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _end,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_end),
    );
    if (time == null || !mounted) return;
    setState(() {
      _end = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      if (_end.isBefore(_start)) _start = _end.subtract(const Duration(hours: 1));
    });
  }

  String _formatDateTime(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[d.month - 1]} ${d.day}, ${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New event'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (v) => title = v,
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Start'),
              subtitle: Text(_formatDateTime(_start)),
              trailing: const Icon(Icons.edit_calendar),
              onTap: _pickStartDateTime,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('End'),
              subtitle: Text(_formatDateTime(_end)),
              trailing: const Icon(Icons.edit_calendar),
              onTap: _pickEndDateTime,
            ),
            const SizedBox(height: 12),
            Text(
              'Color',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                ...CalendarColors.eventColorHexes.map((hex) {
                  final isSelected = selectedColorHex == hex;
                  return GestureDetector(
                    onTap: () => setState(() => selectedColorHex = hex),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: CalendarColors.colorFromHex(hex),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 2,
                              )
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: CalendarColors.colorFromHex(hex).withValues(alpha: 0.5),
                            blurRadius: isSelected ? 6 : 0,
                            spreadRadius: isSelected ? 1 : 0,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(labelText: 'Note (optional)'),
              maxLines: 2,
              onChanged: (v) => note = v.isEmpty ? null : v,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, {
            'title': title,
            'note': note,
            'start': _start,
            'end': _end,
            'colorHex': selectedColorHex,
          }),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
