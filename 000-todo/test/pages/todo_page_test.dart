import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/pages/pages.dart';
import 'package:todo/repositories/repositories.dart';
import 'package:todo/widgets/widgets.dart';

import '../mocks/mock_local_storage_todo_repository.dart';

void main() {
  late LocalStorageTodoRepository localStorageTodoRepository;
  late TodoCubit todoCubit;

  setUp(() {
    localStorageTodoRepository = MockLocalStorageTodoRepository();
    todoCubit = TodoCubit(repository: localStorageTodoRepository);
    when(
      () => localStorageTodoRepository.setTodos(any<List<Todo>>()),
    ).thenAnswer((_) async {});
    when(
      () => localStorageTodoRepository.getTodos(),
    ).thenAnswer(
      (_) => Future.delayed(Duration.zero, () => []),
    );
  });

  testWidgets(
    'TodoPage should have TodoPageAppBar, '
    'TodoView and TodoPageFab. '
    'And should show info text if todos list is empty',
    (tester) async {
      await tester.pumpWidget(
        BlocProvider<TodoCubit>(
          create: (context) => todoCubit,
          child: const MaterialApp(home: TodoPage()),
        ),
      );

      expect(find.byType(TodoPageAppBar), findsOneWidget);
      expect(find.byType(TodoView), findsOneWidget);
      expect(find.text('Create a todo'), findsOneWidget);
      expect(find.byType(TodoPageFab), findsOneWidget);

      todoCubit.addTodo(Todo(title: 'title1'));
      await tester.pump();

      expect(find.text('Create a todo'), findsNothing);
      expect(find.text('title1'), findsOneWidget);
    },
  );

  testWidgets(
    'should show a progress indicator when TodoState in TodoLoading',
    (tester) async {
      await tester.pumpWidget(
        BlocProvider<TodoCubit>(
          create: (context) => todoCubit,
          child: const MaterialApp(home: TodoPage()),
        ),
      );

      final progressIndicator = find.byType(CircularProgressIndicator);
      expect(progressIndicator, findsNothing);

      todoCubit.getTodos();
      await tester.pump();
      expect(progressIndicator, findsOneWidget);

      await tester.pumpAndSettle();
      expect(progressIndicator, findsNothing);
      expect(find.text('Create a todo'), findsOneWidget);
    },
  );

  group('SnackBar', () {
    testWidgets(
      'should show when a todo deleted',
      (tester) async {
        final todo = Todo(title: 'title1');

        final dpi = tester.binding.window.devicePixelRatio;
        tester.binding.window.physicalSizeTestValue =
            Size(600 * dpi, 1000 * dpi);

        await tester.pumpWidget(
          BlocProvider<TodoCubit>(
            create: (context) => todoCubit,
            child: const MaterialApp(home: TodoPage()),
          ),
        );

        todoCubit.addTodo(todo);
        await tester.pump();
        await tester.drag(
          find.widgetWithText(CheckboxListTile, 'title1'),
          const Offset(-500, 0),
        );
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(
          find.text('Todo "title1" deleted!', findRichText: true),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'should replace title if length > 15',
      (tester) async {
        final todo = Todo(title: 'very very long title');

        final dpi = tester.binding.window.devicePixelRatio;
        tester.binding.window.physicalSizeTestValue =
            Size(600 * dpi, 1000 * dpi);

        await tester.pumpWidget(
          BlocProvider<TodoCubit>(
            create: (context) => todoCubit,
            child: const MaterialApp(home: TodoPage()),
          ),
        );

        todoCubit.addTodo(todo);
        await tester.pump();
        await tester.drag(
          find.widgetWithText(CheckboxListTile, 'very very long title'),
          const Offset(-500, 0),
        );
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        // Should replace characters after [15] to "..."
        expect(
          find.text('Todo "very very long ..." deleted!', findRichText: true),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'should restore deleted todo when "Undo" SnackBarAction pressed',
      (tester) async {
        final todo = Todo(title: 'title1');

        final dpi = tester.binding.window.devicePixelRatio;
        tester.binding.window.physicalSizeTestValue =
            Size(600 * dpi, 1000 * dpi);

        await tester.pumpWidget(
          BlocProvider<TodoCubit>(
            create: (context) => todoCubit,
            child: const MaterialApp(home: TodoPage()),
          ),
        );

        todoCubit.addTodo(todo);
        await tester.pump();
        final todoTile = find.widgetWithText(CheckboxListTile, 'title1');
        await tester.drag(todoTile, const Offset(-500, 0));
        await tester.pumpAndSettle();

        expect(todoTile, findsNothing);
        final undoButton = find.text('Undo');
        expect(undoButton, findsOneWidget);

        await tester.tap(undoButton);
        await tester.pump();
        expect(todoTile, findsOneWidget);
      },
    );
  });
}
