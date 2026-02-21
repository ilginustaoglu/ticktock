/// Bir todo listesi (örn: "Alışveriş", "İş").
class TodoList {
  TodoList({
    required this.id,
    required this.name,
    this.colorHex,
    this.createdAt,
  });

  final String id;
  final String name;
  final int? colorHex;
  final DateTime? createdAt;

  TodoList copyWith({
    String? id,
    String? name,
    int? colorHex,
    DateTime? createdAt,
  }) {
    return TodoList(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'colorHex': colorHex,
        'createdAt': createdAt?.toIso8601String(),
      };

  factory TodoList.fromJson(Map<String, dynamic> json) => TodoList(
        id: json['id'] as String,
        name: json['name'] as String,
        colorHex: json['colorHex'] as int?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
      );
}
