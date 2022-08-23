import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/models.dart';
import 'package:todo/widgets/widgets.dart';

import '../helpers/tester_extension.dart';
import '../mocks/mocks.dart';

void main() {
  group('TodoForm', () {
    setUpAll(() {
      registerFallbackValue(FakeTodo());
    });

    late TodoCubit todoCubit;

    setUp(() {
      todoCubit = MockTodoCubit();
    });

    // Finders
    final formTitle = find.byKey(const Key('todo-form-title-text'));
    final titleFormField = find.widgetWithText(TextFormField, 'Title');
    final descriptionFormField = find.widgetWithText(
      TextFormField,
      'Description',
    );
    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    final saveButton = find.widgetWithText(ElevatedButton, 'Save');

    for (final isWeb in [true, false]) {
      group('(${isWeb ? 'web' : 'mobile'})', () {
        testWidgets(
          'should have a form, title, two text form fields '
          'and cancel/save buttons',
          (tester) async {
            await tester.pumpAndWrap(const TodoForm(), inWeb: isWeb);
            expect(find.byType(Form), findsOneWidget);
            expect(formTitle, findsOneWidget);
            expect(tester.widget<Text>(formTitle).data, 'New Todo');
            expect(titleFormField, findsOneWidget);
            expect(descriptionFormField, findsOneWidget);
            expect(cancelButton, findsOneWidget);
            expect(saveButton, findsOneWidget);
          },
        );

        testWidgets(
          'should close dialog when cancel button pressed',
          (tester) async {
            await tester.pumpAndWrap(const TodoForm(), inWeb: isWeb);
            await tester.tap(cancelButton);
            await tester.pumpAndSettle();
            expect(find.byType(TodoForm), findsNothing);
          },
        );

        testWidgets(
          'should validate & format inputs and call TodoCubit.addTodo on save',
          (tester) async {
            await tester.pumpAndWrap(
              const TodoForm(),
              todoCubit: todoCubit,
              inWeb: isWeb,
            );
            final titleErrorText = find.text('Please enter todo title');

            // With no input
            await tester.tap(saveButton);
            await tester.pump();
            expect(titleErrorText, findsOneWidget);

            // With description only
            await tester.enterText(descriptionFormField, '  \n D  ');
            await tester.tap(saveButton);
            await tester.pump();
            expect(titleErrorText, findsOneWidget);
            verifyNever(() => todoCubit.addTodo(any()));

            // With title
            await tester.enterText(titleFormField, '  \n T\n ');
            await tester.tap(saveButton);
            await tester.pump();
            expect(titleErrorText, findsNothing);
            verify(
              () => todoCubit.addTodo(
                any(
                  that: isA<Todo>()
                      .having((t) => t.title, 'title', 'T')
                      .having((t) => t.description, 'description', 'D'),
                ),
              ),
            ).called(1);

            // Should close the form dialog
            await tester.pumpAndSettle();
            expect(find.byType(TodoForm), findsNothing);

            verifyNever(() => todoCubit.updateTodo(any()));
          },
        );

        testWidgets(
          'should reset inputs if canPop is false',
          (tester) async {
            await tester.pumpAndWrap(
              const TodoForm(canPop: false),
              todoCubit: todoCubit,
              inWeb: isWeb,
            );

            await tester.enterText(titleFormField, 'T');
            expect(find.text('T'), findsOneWidget);
            await tester.tap(saveButton);
            await tester.pumpAndSettle();

            // Should reset the form
            expect(find.text('T'), findsNothing);
            expect(find.byType(TodoForm), findsOneWidget);
          },
        );

        group('with [todo]', () {
          final todo = Todo(title: 'T', description: 'D');

          testWidgets(
            'should have "Edit Todo" title',
            (tester) async {
              await tester.pumpAndWrap(TodoForm(todo: todo), inWeb: isWeb);
              expect(tester.widget<Text>(formTitle).data, 'Edit Todo');
            },
          );

          testWidgets(
            'should have initial values in form fields',
            (tester) async {
              await tester.pumpAndWrap(
                TodoForm(todo: todo),
                inWeb: isWeb,
              );
              expect(
                tester.widget<TextFormField>(titleFormField).initialValue,
                todo.title,
              );
              expect(
                tester.widget<TextFormField>(descriptionFormField).initialValue,
                todo.description,
              );
            },
          );

          testWidgets(
            'should close form dialog when save button '
            'pressed without any change',
            (tester) async {
              await tester.pumpAndWrap(
                TodoForm(todo: todo),
                todoCubit: todoCubit,
                inWeb: isWeb,
              );
              await tester.tap(saveButton);
              await tester.pumpAndSettle();

              verifyNever(() => todoCubit.updateTodo(any()));
              verifyNever(() => todoCubit.addTodo(any()));
              expect(find.byType(TodoForm), findsNothing);
            },
          );

          testWidgets(
            'should call TodoCubit.updateTodo on save',
            (tester) async {
              await tester.pumpAndWrap(
                TodoForm(todo: todo),
                todoCubit: todoCubit,
                inWeb: isWeb,
              );
              await tester.enterText(titleFormField, 'T2');
              await tester.enterText(descriptionFormField, 'D2');
              await tester.tap(saveButton);
              await tester.pumpAndSettle();

              verify(
                () => todoCubit.updateTodo(todo.copyWith(
                  title: 'T2',
                  description: 'D2',
                )),
              ).called(1);

              // Should close the form dialog
              await tester.pumpAndSettle();
              expect(find.byType(TodoForm), findsNothing);

              verifyNever(() => todoCubit.addTodo(any()));
            },
          );
        });
      });
    }
  });
}
