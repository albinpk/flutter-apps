import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/models/models.dart';
import 'package:todo/repositories/repositories.dart';

import '../mocks/mocks.dart';

void main() {
  group('LocalStorageTodoRepository', () {
    late LocalStorage localStorage;
    late LocalStorageTodoRepository repository;
    final todo = Todo(title: 'T', description: 'D');

    setUp(() {
      localStorage = MockLocalStorage();
      repository = LocalStorageTodoRepository(localStorage);
      when(() => localStorage.setItem(any(), any())).thenAnswer((_) async {});
    });

    group('getTodos()', () {
      test('should calls localstorage.getItem', () async {
        await repository.getTodos();
        verify(() => localStorage.getItem(any())).called(1);
      });

      test('should return empty list if no data in localstorage', () async {
        when(() => localStorage.getItem(any())).thenReturn(null);
        final todos = await repository.getTodos();
        expect(todos, []);
      });

      test('should return list of Todo models', () async {
        when(() => localStorage.getItem(any())).thenReturn([todo.toJson()]);
        final todos = await repository.getTodos();
        expect(todos, [todo]);
      });
    });

    group('setTodos()', () {
      test('should calls localstorage.setItem', () async {
        await repository.setTodos([]);
        verify(() => localStorage.setItem(any(), any())).called(1);
      });

      test('should call localstorage.setItem with todo json', () async {
        await repository.setTodos([todo]);
        verify(() => localStorage.setItem(any(), [todo.toJson()])).called(1);
      });
    });
  });
}
