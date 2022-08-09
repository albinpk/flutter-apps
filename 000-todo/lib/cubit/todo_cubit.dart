import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoInitial());

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
