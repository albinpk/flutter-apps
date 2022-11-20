import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

/// The todo model.
class Todo {
  Todo({
    required this.title,
    required this.createdAt,
  });

  /// Todo title.
  final String title;

  /// Todo created time.
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      // 'createdAt': createdAt.millisecondsSinceEpoch,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
