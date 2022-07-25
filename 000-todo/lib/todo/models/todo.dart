import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  }) : id = const Uuid().v4();
}
