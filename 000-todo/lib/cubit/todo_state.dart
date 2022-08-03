part of 'todo_cubit.dart';

@immutable
abstract class TodoState {
  final List<Todo> todos;
  const TodoState({required this.todos});
}

class TodoInitial extends TodoState {
  const TodoInitial() : super(todos: const []);
}
