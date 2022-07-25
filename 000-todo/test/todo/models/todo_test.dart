import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/todo/models/models.dart';

void main() {
  group('Todo model', () {
    test('should generate id if no id given', () {
      final todo = Todo(title: 'title');
      expect(todo.id, isNotEmpty);
    });

    test('should have given id', () {
      final todo = Todo(id: '123', title: 'title');
      expect(todo.id, equals('123'));
    });

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

    group('json', () {
      test('toJson', () {
        final todo = Todo(id: '123', title: 'todo1', isDone: true);
        final todoJson = jsonEncode({
          'id': '123',
          'title': 'todo1',
          'isDone': true,
        });
        expect(todo.toJson(), equals(todoJson));
      });

      test('fromJson', () {
        final todoJson = jsonEncode({
          'id': '123',
          'title': 'todo1',
          'isDone': true,
        });
        final todo = Todo(id: '123', title: 'todo1', isDone: true);
        expect(Todo.fromJson(todoJson), equals(todo));
      });
    });
  });
}
