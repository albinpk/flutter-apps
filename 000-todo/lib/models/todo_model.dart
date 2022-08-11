import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  Todo({
    String? id,
    required this.title,
    this.description = '',
    this.isDone = false,
  })  : assert(title.trim().isNotEmpty, 'Todo [title] must not be empty'),
        id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id, title, description, isDone];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) {
    return Todo.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  Todo copyWith({
    String? title,
    String? description,
    bool? isDone,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'Todo('
        '${id.substring(0, 8)}, '
        '$title, '
        '$isDone'
        '${description.isNotEmpty ? ', $description' : ""}'
        ')';
  }
}
