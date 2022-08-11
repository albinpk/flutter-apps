import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _repository;

  TodoCubit({
    required TodoRepository repository,
  })  : _repository = repository,
        super(const TodoInitial());

  Future<void> getTodos() async {
    emit(const TodoLoading());
    final todos = await _repository.getTodos();
    emit(TodoFetched(todos: todos));
  }

  void addTodo(Todo todo) {
    emit(
      TodoAdded(
        addedTodo: todo,
        todos: [todo, ...state.todos],
      ),
    );
  }

  late Todo _lastDeletedTodo;
  late int _lastDeletedTodoIndex;

  void deleteTodo(Todo todo) {
    final todos = [...state.todos];
    _lastDeletedTodoIndex = todos.indexOf(todo);
    assert(_lastDeletedTodoIndex != -1);
    _lastDeletedTodo = todos.removeAt(_lastDeletedTodoIndex);
    emit(
      TodoDeleted(
        deletedTodo: _lastDeletedTodo,
        todos: todos,
      ),
    );
  }

  void undoDelete() {
    final todos = [...state.todos];
    assert(_lastDeletedTodoIndex <= todos.length);
    todos.insert(_lastDeletedTodoIndex, _lastDeletedTodo);
    emit(
      TodoRestored(
        restoredTodo: _lastDeletedTodo,
        todos: todos,
      ),
    );
  }

  void updateTodo(Todo updatedTodo) {
    final todos = [...state.todos];
    final index = todos.indexWhere((t) => t.id == updatedTodo.id);
    assert(index != -1);
    todos[index] = updatedTodo;
    emit(
      TodoUpdated(
        updatedTodo: updatedTodo,
        todos: todos,
      ),
    );
  }

  void toggleIsDone(Todo todo) {
    updateTodo(todo.copyWith(isDone: !todo.isDone));
  }
}
