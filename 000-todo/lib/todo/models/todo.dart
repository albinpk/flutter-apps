import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final bool isDone;

  Todo({
    String? id,
    required this.title,
    this.isDone = false,
  }) : id = id ?? const Uuid().v4();
}
