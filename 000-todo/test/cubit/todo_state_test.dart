import 'package:flutter_test/flutter_test.dart';
import 'package:todo/cubit/todo_cubit.dart';

void main() {
  group('TodoState', () {
    test('TodoInitial should have an empty list', () {
      const todoInitial = TodoInitial();
      expect(todoInitial.todos, isEmpty);
    });

    });
  });
}
