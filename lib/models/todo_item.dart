/// A single task in a list; can have note, deadline, completed state.
class TodoItem {
  TodoItem({
    required this.id,
    required this.listId,
    required this.title,
    this.note,
    this.completed = false,
    this.createdAt,
    this.completedAt,
    this.dueDate,
  });

  final String id;
  final String listId;
  final String title;
  final String? note;
  final bool completed;
  final DateTime? createdAt;
  final DateTime? completedAt;
  /// Optional deadline; shown on calendar when set.
  final DateTime? dueDate;

  TodoItem copyWith({
    String? id,
    String? listId,
    String? title,
    String? note,
    bool? completed,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? dueDate,
    bool clearDueDate = false,
  }) {
    return TodoItem(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      title: title ?? this.title,
      note: note ?? this.note,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      dueDate: clearDueDate ? null : (dueDate ?? this.dueDate),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'listId': listId,
        'title': title,
        'note': note,
        'completed': completed,
        'createdAt': createdAt?.toIso8601String(),
        'completedAt': completedAt?.toIso8601String(),
        'dueDate': dueDate?.toIso8601String(),
      };

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
        id: json['id'] as String,
        listId: json['listId'] as String,
        title: json['title'] as String,
        note: json['note'] as String?,
        completed: json['completed'] as bool? ?? false,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
        completedAt: json['completedAt'] != null
            ? DateTime.parse(json['completedAt'] as String)
            : null,
        dueDate: json['dueDate'] != null
            ? DateTime.parse(json['dueDate'] as String)
            : null,
      );

  factory TodoItem.fromSupabase(Map<String, dynamic> row) => TodoItem(
        id: row['id'] as String,
        listId: row['list_id'] as String,
        title: row['title'] as String,
        note: row['note'] as String?,
        completed: row['completed'] as bool? ?? false,
        createdAt: row['created_at'] != null
            ? DateTime.parse(row['created_at'] as String).toLocal()
            : null,
        completedAt: row['completed_at'] != null
            ? DateTime.parse(row['completed_at'] as String).toLocal()
            : null,
        dueDate: row['due_date'] != null
            ? DateTime.parse(row['due_date'] as String).toLocal()
            : null,
      );
}
