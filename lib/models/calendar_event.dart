/// Calendar event; shown in weekly/monthly views.
class CalendarEvent {
  CalendarEvent({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    this.allDay = false,
    this.note,
    this.colorHex,
    this.todoItemId,
  });

  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final bool allDay;
  final String? note;
  final int? colorHex;
  /// Optional: link to a task.
  final String? todoItemId;

  CalendarEvent copyWith({
    String? id,
    String? title,
    DateTime? start,
    DateTime? end,
    bool? allDay,
    String? note,
    int? colorHex,
    String? todoItemId,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      start: start ?? this.start,
      end: end ?? this.end,
      allDay: allDay ?? this.allDay,
      note: note ?? this.note,
      colorHex: colorHex ?? this.colorHex,
      todoItemId: todoItemId ?? this.todoItemId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        'allDay': allDay,
        'note': note,
        'colorHex': colorHex,
        'todoItemId': todoItemId,
      };

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => CalendarEvent(
        id: json['id'] as String,
        title: json['title'] as String,
        start: DateTime.parse(json['start'] as String),
        end: DateTime.parse(json['end'] as String),
        allDay: json['allDay'] as bool? ?? false,
        note: json['note'] as String?,
        colorHex: json['colorHex'] as int?,
        todoItemId: json['todoItemId'] as String?,
      );
}
