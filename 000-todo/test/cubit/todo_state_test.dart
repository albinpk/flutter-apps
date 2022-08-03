import 'package:flutter_test/flutter_test.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/todo_model.dart';

void main() {
  group('TodoState', () {
    test('TodoInitial should have an empty list', () {
      const todoInitial = TodoInitial();
      expect(todoInitial.todos, isEmpty);
    });

    test('TodoChangeState should have given items', () {
      final todoChangeState = TodoChangeState(todos: [Todo(title: 'title')]);
      expect(todoChangeState.todos.length, 1);
    });
  });
}
