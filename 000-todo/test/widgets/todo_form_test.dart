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
    'TodoForm should have a title, Form, TextFormField '
    'and Cancel & Save buttons. '
    'And it should show error text on form validation '
    'and should call TodoCubit.addTodo() on save',
    (tester) async {
      await tester.pumpWidget(
        BlocProvider<TodoCubit>(
          create: (context) => todoCubit,
          child: const MaterialApp(
            home: Scaffold(body: TodoForm()),
          ),
        ),
      );

      final titleFormField = find.byType(TextFormField);
      final titleFormFieldErrorText = find.text('Please enter todo title');
      final cancelButton = find.widgetWithText(TextButton, 'Cancel');
      final saveButton = find.widgetWithText(ElevatedButton, 'Save');

      expect(find.byType(Form), findsOneWidget);
      expect(find.text('New Todo'), findsOneWidget);
      expect(titleFormField, findsOneWidget);
      expect(tester.widget<TextFormField>(titleFormField).initialValue, '');
      expect(titleFormFieldErrorText, findsNothing);
      expect(cancelButton, findsOneWidget);
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);
      await tester.pump();

      verifyNever(() => todoCubit.addTodo(any()));
      expect(titleFormFieldErrorText, findsOneWidget);

      await tester.enterText(titleFormField, '    ');
      await tester.tap(saveButton);
      await tester.pump();

      verifyNever(() => todoCubit.addTodo(any()));
      expect(titleFormFieldErrorText, findsOneWidget);

      await tester.enterText(titleFormField, 'title1');
      await tester.tap(saveButton);
      await tester.pump();

      verify(
        () => todoCubit.addTodo(
          any(
            that: isA<Todo>().having(
              (todo) => todo.title,
              'title',
              'title1',
            ),
          ),
        ),
      ).called(1);
      verifyNever(() => todoCubit.updateTodo(any()));
      expect(titleFormFieldErrorText, findsNothing);
    },
  );

  testWidgets(
    'TodoForm having [todo] argument should call updateTodo() on save',
    (tester) async {
      final todo = Todo(title: 'title1');

      await tester.pumpWidget(
        BlocProvider<TodoCubit>(
          create: (context) => todoCubit,
          child: MaterialApp(
            home: Scaffold(body: TodoForm(todo: todo)),
          ),
        ),
      );

      final titleFormField = find.byType(TextFormField);
      final titleFormFieldErrorText = find.text('Please enter todo title');
      final saveButton = find.widgetWithText(ElevatedButton, 'Save');

      expect(find.text('Edit Todo'), findsOneWidget);
      expect(
        tester.widget<TextFormField>(titleFormField).initialValue,
        todo.title,
      );
      expect(titleFormFieldErrorText, findsNothing);

      await tester.tap(saveButton);

      verify(() => todoCubit.updateTodo(todo)).called(1);
      verifyNever(() => todoCubit.addTodo(any()));
    },
  );
}
