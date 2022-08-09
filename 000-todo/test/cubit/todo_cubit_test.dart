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
      'emits [TodoAdded] with addedTodo when addTodo() is called. '
      'and new todo should add to the top of list',
      build: () => todoCubit,
      act: (bloc) => bloc
        ..addTodo(todo1)
        ..addTodo(todo2),
      expect: () => <TodoState>[
        TodoAdded(addedTodo: todo1, todos: [todo1]),
        TodoAdded(addedTodo: todo2, todos: [todo2, todo1]),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'emits [TodoDeleted] with deletedTodo when deleteTodo() is called.',
      build: () => todoCubit,
      act: (bloc) => bloc
        ..addTodo(todo1)
        ..deleteTodo(todo1),
      skip: 1,
      expect: () => <TodoState>[
        TodoDeleted(deletedTodo: todo1, todos: const []),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'emits [TodoRestored] with restoredTodo when undoDelete() is called.',
      build: () => todoCubit,
      act: (bloc) => bloc
        ..addTodo(todo1)
        ..deleteTodo(todo1)
        ..undoDelete(),
      skip: 2,
      expect: () => <TodoState>[
        TodoRestored(restoredTodo: todo1, todos: [todo1]),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'emits [TodoUpdated] with updatedTodo when updateTodo() is called.',
      build: () => todoCubit,
      act: (bloc) => bloc
        ..addTodo(todo1)
        ..updateTodo(todo1.copyWith(title: 'new title')),
      skip: 1,
      expect: () => <TodoState>[
        TodoUpdated(
          updatedTodo: todo1.copyWith(title: 'new title'),
          todos: [todo1.copyWith(title: 'new title')],
        )
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'emits [TodoUpdated] with updatedTodo when toggleIsDone() is called. '
      'and it should maintain todos order',
      build: () => todoCubit,
      act: (bloc) => bloc
        ..addTodo(todo1)
        ..addTodo(todo2)
        ..toggleIsDone(todo1)
        ..toggleIsDone(todo2),
      skip: 2,
      expect: () => <TodoState>[
        TodoUpdated(
          updatedTodo: todo1Toggled,
          todos: [todo2, todo1Toggled],
        ),
        TodoUpdated(
          updatedTodo: todo2Toggled,
          todos: [todo2Toggled, todo1Toggled],
        ),
      ],
    );
  });
}
