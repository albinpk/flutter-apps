part of 'todo_cubit.dart';

@immutable
abstract class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({required this.todos});

  int get doneCount => todos.where((t) => t.isDone).length;

  @override
  List<Object?> get props => [todos];
}

class TodoInitial extends TodoState {
  const TodoInitial() : super(todos: const []);
}

class TodoChangeState extends TodoState {
  const TodoChangeState({required super.todos});
}
