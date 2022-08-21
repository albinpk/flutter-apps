import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/models.dart';
import 'package:todo/widgets/widgets.dart';

import '../helpers/tester_extension.dart';
import '../mocks/mocks.dart';
import 'package:todo/utils/extensions/target_platform_extension.dart';

void main() {
  group('TodoItem', () {
    late Todo todo;
    late TodoCubit todoCubit;

    setUp(() {
      todo = Todo(title: 'T');
      todoCubit = MockTodoCubit();
    });

    // Finders
    final checkbox = find.byType(Checkbox);
    late final listTile = find.widgetWithText(ListTile, todo.title);
    late final checkboxListTile =
        find.widgetWithText(CheckboxListTile, todo.title);
    final editButton = find.widgetWithIcon(IconButton, Icons.edit);
    final deleteButton = find.widgetWithIcon(IconButton, Icons.delete);
    final dismissible = find.byType(Dismissible);

    // Common tests for web and mobile
    for (final isWeb in [true, false]) {
      group(isWeb ? '(web)' : '', () {
        testWidgets(
          'should have Todo.title',
          (tester) async {
            await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
            expect(find.text(todo.title), findsOneWidget);
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.all() as TestVariant,
        );

        testWidgets(
          'Checkbox.value is same as Todo.isDone',
          (tester) async {
            await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
            expect(
              tester.widget<Checkbox>(checkbox).value,
              isFalse,
            );
            await tester.pumpAndWrap(
              TodoItem(todo: todo.copyWith(isDone: true)),
              inWeb: isWeb,
            );
            expect(
              tester.widget<Checkbox>(checkbox).value,
              isTrue,
            );
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.all() as TestVariant,
        );

        testWidgets(
          'subtitle should be null '
          'if Todo.description is empty',
          (tester) async {
            await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
            expect(
              tester.widget<ListTile>(listTile).subtitle,
              isNull,
            );
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.all() as TestVariant,
        );

        testWidgets(
          'should have Todo.description',
          (tester) async {
            await tester.pumpAndWrap(
              TodoItem(todo: todo.copyWith(description: 'D')),
              inWeb: isWeb,
            );
            expect(find.text('D'), findsOneWidget);
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.all() as TestVariant,
        );

        testWidgets(
          'should have edit button',
          (tester) async {
            await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
            expect(editButton, findsOneWidget);
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.all() as TestVariant,
        );

        testWidgets(
          'should call TodoCubit.toggleIsDone when pressed',
          (tester) async {
            await tester.pumpAndWrap(
              TodoItem(todo: todo),
              todoCubit: todoCubit,
              inWeb: isWeb,
            );
            if (!isWeb && debugDefaultTargetPlatformOverride!.isMobile) {
              await tester.tap(checkboxListTile);
            } else {
              await tester.tap(checkbox);
            }
            verify(() => todoCubit.toggleIsDone(todo)).called(1);
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.all() as TestVariant,
        );

        testWidgets(
          'should open TodoForm dialog when edit button pressed',
          (tester) async {
            await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
            await tester.tap(editButton);
            await tester.pump();
            expect(find.byType(Dialog), findsOneWidget);
            expect(find.byType(TodoForm), findsOneWidget);
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.all() as TestVariant,
        );
      });
    }

    group('on mobile', () {
      testWidgets(
        'should have Dismissible widget',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo));
          expect(dismissible, findsOneWidget);
        },
        variant: TargetPlatformVariant.mobile(),
      );

      testWidgets(
        'should not have a delete button',
        (tester) async {
          await tester.pumpAndWrap(TodoItem(todo: todo));
          expect(deleteButton, findsNothing);
        },
        variant: TargetPlatformVariant.mobile(),
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
        variant: TargetPlatformVariant.mobile(),
      );
    });

    group('on desktop/web', () {
      for (var isWeb in [true, false]) {
        testWidgets(
          'should not have Dismissible widget',
          (tester) async {
            await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
            expect(dismissible, findsNothing);
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.desktop() as TestVariant,
        );

        testWidgets(
          'should have delete button',
          (tester) async {
            await tester.pumpAndWrap(TodoItem(todo: todo), inWeb: isWeb);
            expect(deleteButton, findsOneWidget);
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.desktop() as TestVariant,
        );

        testWidgets(
          'should call TodoCubit.deleteTodo when delete button pressed',
          (tester) async {
            await tester.pumpAndWrap(
              TodoItem(todo: todo),
              todoCubit: todoCubit,
              inWeb: isWeb,
            );
            await tester.tap(deleteButton);
            verify(() => todoCubit.deleteTodo(todo)).called(1);
          },
          variant: isWeb
              ? const DefaultTestVariant()
              : TargetPlatformVariant.desktop() as TestVariant,
        );
      }
    });
  });
}
