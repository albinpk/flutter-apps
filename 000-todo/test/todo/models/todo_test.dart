import 'package:flutter_test/flutter_test.dart';
import 'package:todo/todo/models/models.dart';

void main() {
  group('Todo model', () {
    test('should have given title', () {
      const todo = Todo('todo1');
      expect(todo.title, 'todo1');
    });

    test('default value of [isDone] in false', () {
      const todo = Todo('title');
      expect(todo.isDone, isFalse);
    });

    test('change [isDone] to given value', () {
      const todo1 = Todo('title', isDone: true);
      const todo2 = Todo('title', isDone: false);

      expect(todo1.isDone, isTrue);
      expect(todo2.isDone, isFalse);
    });
  });
}
