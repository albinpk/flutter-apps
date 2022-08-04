import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoInitial());

  void addTodo(Todo todo) {
    emit(
      TodoChangeState(todos: [todo, ...state.todos]),
    );
  }

  void toggleIsDone(Todo todo) {
    final newTodo = todo.copyWith(isDone: !todo.isDone);
    final todos = [...state.todos];
    final index = todos.indexOf(todo);
    todos.replaceRange(index, index + 1, [newTodo]);
    emit(TodoChangeState(todos: todos));
  }
}
