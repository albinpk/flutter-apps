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

    test('[doneCount] should return length of completed todos', () {
      const todoInitial = TodoInitial();
      final todoChangeState = TodoChangeState(
        todos: [Todo(title: 'title')],
      );
      final todoChangeState2 = TodoChangeState(
        todos: [Todo(title: 'title', isDone: true)],
      );
      final todoChangeState3 = TodoChangeState(
        todos: [
          Todo(title: 'title', isDone: true),
          Todo(title: 'title'),
        ],
      );
      final todoChangeState4 = TodoChangeState(
        todos: [
          Todo(title: 'title', isDone: true),
          Todo(title: 'title', isDone: true),
        ],
      );

      expect(todoInitial.doneCount, 0);
      expect(todoChangeState.doneCount, 0);
      expect(todoChangeState2.doneCount, 1);
      expect(todoChangeState3.doneCount, 1);
      expect(todoChangeState4.doneCount, 2);
    });
  });
}
