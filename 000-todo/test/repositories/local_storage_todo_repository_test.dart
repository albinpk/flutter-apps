import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/repositories/repositories.dart';

class _MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  group('LocalStorageTodoRepository', () {
    late LocalStorage localStorage;
    late LocalStorageTodoRepository localStorageTodoRepository;
    late Todo todo;

    setUp(() {
      localStorage = _MockLocalStorage();
      localStorageTodoRepository = LocalStorageTodoRepository(localStorage);
      todo = Todo(title: 'title', description: 'description');
    });

    test(
      'should call localStorage.getItem() when getTodos() called '
      'and return list of todos',
      () async {
        when(() => localStorage.getItem(any())).thenReturn([todo.toJson()]);
        final todos = await localStorageTodoRepository.getTodos();

        // 'todos' is the _itemKey in LocalStorageTodoRepository
        verify(() => localStorage.getItem('todos')).called(1);
        expect(todos, [todo]);

        // Should return [] if localStorage return null
        when(() => localStorage.getItem(any())).thenReturn(null);
        final todos2 = await localStorageTodoRepository.getTodos();

        verify(() => localStorage.getItem(any())).called(1);
        expect(todos2, []);
      },
    );

    test(
      'should call localStorage.setItem() when setTodos() called',
      () async {
        when(() => localStorage.setItem(any(), any())).thenAnswer((_) async {});

        await localStorageTodoRepository.setTodos([todo]);

        verify(() => localStorage.setItem(any(), [todo.toJson()])).called(1);
      },
    );
  });
}
