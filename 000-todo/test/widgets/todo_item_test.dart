import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/models.dart';
import 'package:todo/widgets/widgets.dart';

import '../helpers/tester_extension.dart';
import '../mocks/mocks.dart';

void main() {
  group('TodoItem', () {
    late Todo todo;
    late TodoCubit todoCubit;

    setUp(() {
      todo = Todo(title: 'T');
      todoCubit = MockTodoCubit();
    });

    // Finders
    late final checkboxListTile =
        find.widgetWithText(CheckboxListTile, todo.title);
    final editButton = find.widgetWithIcon(IconButton, Icons.edit);
    final deleteButton = find.widgetWithIcon(IconButton, Icons.delete);
    final dismissible = find.byType(Dismissible);

    // Common tests for web and mobile
    for (final isWeb in [true, false]) {
      final platform = isWeb ? 'web' : 'mobile';

      testWidgets(
        'should have CheckboxListTile with Todo.title in $platform',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
          expect(checkboxListTile, findsOneWidget);
        },
      );

      testWidgets(
        'CheckboxListTile.value is same as Todo.isDone in $platform',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
          expect(
            tester.widget<CheckboxListTile>(checkboxListTile).value,
            isFalse,
          );
          await tester.pumpAndWrap(
            TodoItem(todo: todo.copyWith(isDone: true)),
            inWeb: isWeb,
          );
          expect(
            tester.widget<CheckboxListTile>(checkboxListTile).value,
            isTrue,
          );
        },
      );

      testWidgets(
        'CheckboxListTile.subtitle should be null '
        'if Todo.description is empty in $platform',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
          expect(
            tester.widget<CheckboxListTile>(checkboxListTile).subtitle,
            isNull,
          );
        },
      );

      testWidgets(
        'should have Todo.description in $platform',
        (tester) async {
          await tester.pumpAndWrap(
            TodoItem(todo: todo.copyWith(description: 'D')),
            inWeb: isWeb,
          );
          expect(find.text('D'), findsOneWidget);
        },
      );

      testWidgets(
        'should have edit button in $platform',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
          expect(editButton, findsOneWidget);
        },
      );

      testWidgets(
        'should call TodoCubit.toggleIsDone when pressed in $platform',
        (tester) async {
          await tester.pumpAndWrap(
            TodoItem(todo: todo),
            todoCubit: todoCubit,
            inWeb: isWeb,
          );
          await tester.tap(checkboxListTile);
          verify(() => todoCubit.toggleIsDone(todo)).called(1);
        },
      );

      testWidgets(
        'should open TodoForm dialog when edit button pressed in $platform',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
          await tester.tap(editButton);
          await tester.pump();
          expect(find.byType(Dialog), findsOneWidget);
          expect(find.byType(TodoForm), findsOneWidget);
        },
      );
    }

    group('on mobile', () {
      testWidgets(
        'should have Dismissible widget',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo));
          expect(dismissible, findsOneWidget);
        },
      );

      testWidgets(
        'should not have a delete button',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo));
          expect(deleteButton, findsNothing);
        },
      );

      testWidgets(
        'should call TodoCubit.deleteTodo when dismissed to left',
        (tester) async {
          await tester.pumpAndWrap(
            TodoItem(todo: todo),
            todoCubit: todoCubit,
          );
          await tester.drag(checkboxListTile, const Offset(-500, 0));
          await tester.pumpAndSettle();
          verify(() => todoCubit.deleteTodo(todo)).called(1);
        },
      );
    });

    group('on web', () {
      testWidgets(
        'should not have Dismissible widget',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: true);
          expect(dismissible, findsNothing);
        },
      );

      testWidgets(
        'should have delete button',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: true);
          expect(deleteButton, findsOneWidget);
        },
      );

      testWidgets(
        'should call TodoCubit.deleteTodo when delete button pressed',
        (tester) async {
          await tester.pumpAndWrap(
            TodoItem(todo: todo),
            todoCubit: todoCubit,
            inWeb: true,
          );
          await tester.tap(deleteButton);
          verify(() => todoCubit.deleteTodo(todo)).called(1);
        },
      );
    });
  });
}
