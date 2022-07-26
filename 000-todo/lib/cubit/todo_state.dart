part of 'todo_cubit.dart';

@immutable
abstract class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({required this.todos});

  int get doneCount => todos.where((t) => t.isDone).length;
}

class TodoInitial extends TodoState {
  const TodoInitial() : super(todos: const []);

  @override
  List<Object?> get props => [];
}

class TodoLoading extends TodoState {
  const TodoLoading() : super(todos: const []);

  @override
  List<Object> get props => [];
}

class TodoFetched extends TodoState {
  const TodoFetched({required super.todos});

  @override
  List<Object> get props => [todos];
}

class TodoAdded extends TodoState {
  const TodoAdded({
    required this.addedTodo,
    required super.todos,
  });

  final Todo addedTodo;

  @override
  List<Object> get props => [addedTodo, todos];
}

class TodoUpdated extends TodoState {
  const TodoUpdated({
    required this.updatedTodo,
    required super.todos,
  });

  final Todo updatedTodo;

  @override
  List<Object> get props => [updatedTodo, todos];
}

class TodoDeleted extends TodoState {
  const TodoDeleted({
    required this.deletedTodo,
    required super.todos,
  });

  final Todo deletedTodo;

  @override
  List<Object> get props => [deletedTodo, todos];
}

class TodoRestored extends TodoState {
  const TodoRestored({
    required this.restoredTodo,
    required super.todos,
  });

  final Todo restoredTodo;

  @override
  List<Object> get props => [restoredTodo, todos];
}
