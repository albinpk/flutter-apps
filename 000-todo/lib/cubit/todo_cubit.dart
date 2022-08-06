import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoInitial());

  void addTodo(Todo todo) {
    emit(TodoChangeState(todos: [todo, ...state.todos]));
  }

  void deleteTodo(Todo todo) {
    final newTodos = [...state.todos]..remove(todo);
    emit(TodoChangeState(todos: newTodos));
  }

  void updateTodo(Todo updatedTodo) {
    final todos = [...state.todos];
    final index = todos.indexWhere((t) => t.id == updatedTodo.id);
    todos[index] = updatedTodo;
    emit(TodoChangeState(todos: todos));
  }

  void toggleIsDone(Todo todo) {
    updateTodo(todo.copyWith(isDone: !todo.isDone));
  }
}
