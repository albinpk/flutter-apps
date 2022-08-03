import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/todo_model.dart';

void main() {
  group('TodoCubit', () {
    late TodoCubit todoCubit;
    final todo = Todo(title: 'title');

    setUp(() {
      todoCubit = TodoCubit();
    });

    test('TodoCubit should have an initial state of [TodoInitial]', () {
      expect(todoCubit.state, isA<TodoInitial>());
    });

    blocTest<TodoCubit, TodoState>(
      'emits [TodoChangeState] with given todo when addTodo is called.',
      build: () => todoCubit,
      act: (bloc) => bloc.addTodo(todo),
      expect: () => <TodoState>[
        TodoChangeState(todos: [todo]),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'emits [TodoChangeState] with updated todo when toggleIsDone is called.',
      build: () => todoCubit,
      act: (bloc) => bloc
        ..addTodo(todo)
        ..toggleIsDone(todo),
      expect: () => <TodoState>[
        TodoChangeState(todos: [todo.copyWith(isDone: true)]),
      ],
    );
  });
}
