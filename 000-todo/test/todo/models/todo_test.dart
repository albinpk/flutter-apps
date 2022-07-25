import 'package:flutter_test/flutter_test.dart';
import 'package:todo/todo/models/models.dart';

void main() {
  group('Todo model', () {
    test('should have given title', () {
      final todo = Todo(title: 'todo1');
      expect(todo.title, 'todo1');
    });

    test('default value of [isDone] in false', () {
      final todo = Todo(title: 'title');
      expect(todo.isDone, isFalse);
    });

    test('change [isDone] to given value', () {
      final todo1 = Todo(title: 'title', isDone: true);
      final todo2 = Todo(title: 'title', isDone: false);

      expect(todo1.isDone, isTrue);
      expect(todo2.isDone, isFalse);
    });
  });
}
