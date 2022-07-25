import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final bool isDone;

  Todo({
    String? id,
    required this.title,
    this.isDone = false,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object> get props => [id, title, isDone];
}
