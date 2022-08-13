import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/models.dart';
import 'package:todo/widgets/widgets.dart';

import '../mocks/fake_todo.dart';
import '../mocks/mock_todo_cubit.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTodo());
  });

  late TodoCubit todoCubit;

  setUp(() {
    todoCubit = MockTodoCubit();
  });

  testWidgets(
    'TodoItem should have a CheckboxListTile with value false '
    'and should call TodoCubit.toggleIsDone() with given [todo] on tap '
    'and should have edit button',
    (tester) async {
      final todo = Todo(title: 'title1');

      await tester.pumpWidget(
        BlocProvider<TodoCubit>(
          create: (context) => todoCubit,
          child: MaterialApp(
            home: Scaffold(
              body: TodoItem(todo: todo),
            ),
          ),
        ),
      );

      final todoTile = find.widgetWithText(CheckboxListTile, 'title1');
      final editButton = find.widgetWithIcon(IconButton, Icons.edit);

      expect(todoTile, findsOneWidget);
      expect(tester.widget<CheckboxListTile>(todoTile).value, isFalse);
      expect(tester.widget<CheckboxListTile>(todoTile).subtitle, isNull);
      expect(editButton, findsOneWidget);
      expect(tester.widget<IconButton>(editButton).tooltip, 'Edit');

      await tester.tap(todoTile);

      verify(() => todoCubit.toggleIsDone(todo)).called(1);

      await tester.tap(editButton);
      await tester.pump();

      expect(find.byType(Dialog), findsOneWidget);
      expect(find.byType(TodoForm), findsOneWidget);
    },
  );

  testWidgets(
    'TodoItem with [description] should render description',
    (tester) async {
      final todo = Todo(
        title: 'title1',
        description: 'description',
        isDone: true,
      );

      await tester.pumpWidget(
        BlocProvider<TodoCubit>(
          create: (context) => todoCubit,
          child: MaterialApp(
            home: Scaffold(
              body: TodoItem(todo: todo),
            ),
          ),
        ),
      );

      final checkboxListTile = tester.widget<CheckboxListTile>(
        find.widgetWithText(CheckboxListTile, 'title1'),
      );
      expect(checkboxListTile.value, isTrue);
      expect(checkboxListTile.subtitle, isNotNull);
      expect(find.text('description'), findsOneWidget);
    },
  );

  testWidgets(
    'should call deleteTodo() with given todo when dismiss to left',
    (tester) async {
      final todo = Todo(title: 'title1');

      final dpi = tester.binding.window.devicePixelRatio;
      tester.binding.window.physicalSizeTestValue = Size(600 * dpi, 1000 * dpi);

      await tester.pumpWidget(
        BlocProvider<TodoCubit>(
          create: (context) => todoCubit,
          child: MaterialApp(
            home: Scaffold(
              body: TodoItem(todo: todo),
            ),
          ),
        ),
      );

      final dismissible = find.byType(Dismissible);
      expect(dismissible, findsOneWidget);

      final checkboxListTile = find.widgetWithText(CheckboxListTile, 'title1');

      await tester.drag(checkboxListTile, const Offset(-500, 0));
      await tester.pumpAndSettle();

      verify(() => todoCubit.deleteTodo(todo)).called(1);
    },
  );
}
