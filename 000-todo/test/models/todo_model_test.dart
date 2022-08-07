import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/models/models.dart';

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

    test('default value of [isDone] is false', () {
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

    group('copyWith', () {
      test('should not replace [id]', () {
        final todo = Todo(title: 'title');
        final newTodo = todo.copyWith(
          title: 'new title',
          isDone: true,
        );
        expect(newTodo.id, todo.id);
      });

      test('should replace [title] and [idDone]', () {
        final todo = Todo(title: 'title 1');
        final todo2 = todo.copyWith(title: 'title 2');
        expect(todo2.title, 'title 2');
        expect(todo2.isDone, isFalse);

        final todo3 = todo2.copyWith(
          title: 'title 3',
          isDone: true,
        );
        expect(todo3.title, 'title 3');
        expect(todo3.isDone, isTrue);

        final todo4 = todo3.copyWith(isDone: false);
        expect(todo4.title, 'title 3');
        expect(todo4.isDone, isFalse);
      });
    });
  });
}
