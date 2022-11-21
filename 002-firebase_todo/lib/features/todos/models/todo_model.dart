import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

/// The todo model.
class Todo {
  Todo({
    required this.title,
    required this.createdAt,
    this.isCompleted = false,
  });

  /// Todo title.
  final String title;

  /// Todo created time.
  final DateTime createdAt;

  /// Whether the todo is completed or not.
  final bool isCompleted;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'createdAt': Timestamp.fromDate(createdAt),
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
