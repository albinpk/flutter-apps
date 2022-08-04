import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/todo_model.dart';

void main() {
  group('TodoCubit', () {
    late TodoCubit todoCubit;
    final todo1 = Todo(title: 'title1', isDone: false);
    final todo1Toggled = todo1.copyWith(isDone: true);
    final todo2 = Todo(title: 'title2', isDone: true);
    final todo2Toggled = todo2.copyWith(isDone: false);

    setUp(() {
      todoCubit = TodoCubit();
    });

    test('TodoCubit should have an initial state of [TodoInitial]', () {
      expect(todoCubit.state, isA<TodoInitial>());
    });

    blocTest<TodoCubit, TodoState>(
      'emits [TodoChangeState] with given todo when addTodo is called.',
      build: () => todoCubit,
      act: (bloc) => bloc.addTodo(todo1),
      expect: () => <TodoState>[
        TodoChangeState(todos: [todo1]),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'New todo should add to top of list',
      build: () => todoCubit,
      act: (bloc) => bloc
        ..addTodo(todo1)
        ..addTodo(todo2)
        ..addTodo(Todo(id: '1', title: 'title')),
      expect: () => <TodoState>[
        TodoChangeState(todos: [todo1]),
        TodoChangeState(todos: [todo2, todo1]),
        TodoChangeState(todos: [Todo(id: '1', title: 'title'), todo2, todo1]),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'emits [TodoChangeState] with updated todos when toggleIsDone is called.'
      'it should maintain order',
      build: () => todoCubit,
      act: (bloc) => bloc
        ..addTodo(todo1)
        ..addTodo(todo2)
        ..toggleIsDone(todo1)
        ..toggleIsDone(todo2),
      skip: 2,
      expect: () => <TodoState>[
        TodoChangeState(todos: [todo2, todo1Toggled]),
        TodoChangeState(todos: [todo2Toggled, todo1Toggled]),
      ],
    );
  });
}
