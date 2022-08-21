import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/models.dart';
import 'package:todo/pages/pages.dart';
import 'package:todo/widgets/widgets.dart';

import '../helpers/tester_extension.dart';
import '../mocks/mocks.dart';

void main() {
  group('TodoPage', () {
    late TodoCubit todoCubit;
    final todo = Todo(title: 'T');

    setUp(() {
      todoCubit = MockTodoCubit();
      when(() => todoCubit.state).thenReturn(const TodoInitial());
    });

    // Finders
    final progressIndicator = find.byType(CircularProgressIndicator);
    final listView = find.byType(ListView);

    for (final isWeb in [true, false]) {
      group('(${isWeb ? 'web' : 'mobile'})', () {
        testWidgets(
          'should have TodoView, TodoPageAppBar',
          (tester) async {
            await tester.pumpAndWrap(
              const TodoPage(),
              withScaffold: false,
              todoCubit: todoCubit,
              inWeb: isWeb,
            );
            expect(find.byType(TodoView), findsOneWidget);
            expect(find.byType(TodoPageAppBar), findsOneWidget);
          },
        );

        testWidgets(
          'should have FAB if todos is not empty',
          (tester) async {
            // If todos is empty
            await tester.pumpAndWrap(
              const TodoPage(),
              withScaffold: false,
              todoCubit: todoCubit,
              inWeb: isWeb,
            );
            expect(find.byType(TodoPageFab), findsNothing);

            // If todos is not empty
            when(() => todoCubit.state).thenReturn(TodoFetched(todos: [todo]));
            final dpi = tester.binding.window.devicePixelRatio;
            tester.binding.window.physicalSizeTestValue =
                Size(800 * dpi, 800 * dpi);
            await tester.pumpAndWrap(
              const TodoPage(),
              withScaffold: false,
              todoCubit: todoCubit,
              inWeb: isWeb,
            );
            expect(find.byType(TodoPageFab), findsOneWidget);
          },
        );

        group('TodoView', () {
          testWidgets(
            'should render progress indicator if TodoState is TodoLoading',
            (tester) async {
              when(() => todoCubit.state).thenReturn(const TodoLoading());
              await tester.pumpAndWrap(
                const TodoView(),
                todoCubit: todoCubit,
                inWeb: isWeb,
              );
              expect(progressIndicator, findsOneWidget);
              expect(listView, findsNothing);
            },
          );

          testWidgets(
            'should render TodoForm if todos list is empty',
            (tester) async {
              when(() => todoCubit.state).thenReturn(
                const TodoFetched(todos: []),
              );
              await tester.pumpAndWrap(
                const TodoView(),
                todoCubit: todoCubit,
                inWeb: isWeb,
              );
              expect(find.byType(TodoForm), findsOneWidget);
              expect(progressIndicator, findsNothing);
              expect(listView, findsNothing);
            },
          );

          testWidgets(
            'should render ListView with todo if todos list is not empty',
            (tester) async {
              when(() => todoCubit.state).thenReturn(
                TodoFetched(todos: [todo]),
              );
              await tester.pumpAndWrap(
                const TodoView(),
                todoCubit: todoCubit,
                inWeb: isWeb,
              );
              expect(listView, findsOneWidget);
              expect(find.widgetWithText(TodoItem, todo.title), findsOneWidget);
              expect(progressIndicator, findsNothing);
            },
          );

          testWidgets(
            'should render ListView and TodoForm in Row if todos list is not empty',
            (tester) async {
              final dpi = tester.binding.window.devicePixelRatio;
              tester.binding.window.physicalSizeTestValue =
                  Size(801 * dpi, 800 * dpi);

              when(() => todoCubit.state).thenReturn(
                TodoFetched(todos: [todo]),
              );
              await tester.pumpAndWrap(
                const TodoView(),
                todoCubit: todoCubit,
                inWeb: isWeb,
              );
              expect(listView, findsOneWidget);
              if (isWeb) expect(find.byType(TodoForm), findsOneWidget);
            },
          );

          // Snackbar test
          testWidgets(
            'should show a snackbar if TodoState is TodoDeleted, and should '
            'call TodoCubit.undoDelete when action button(Undo) pressed',
            (tester) async {
              when(() => todoCubit.stream).thenAnswer(
                (_) => Stream.fromIterable(
                  [TodoDeleted(deletedTodo: todo, todos: const [])],
                ),
              );
              await tester.pumpAndWrap(
                const TodoView(),
                todoCubit: todoCubit,
                inWeb: isWeb,
              );
              await tester.pumpAndSettle();
              expect(find.byType(SnackBar), findsOneWidget);
              expect(
                find.text('Deleting: ${todo.title}', findRichText: true),
                findsOneWidget,
              );
              await tester.tap(find.text('Undo'));
              verify(() => todoCubit.undoDelete()).called(1);
            },
          );
        });
      });
    }
  });
}
