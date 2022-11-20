import 'dart:convert';

/// The todo model.
class Todo {
  Todo({
    required this.title,
  });

  final String title;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
