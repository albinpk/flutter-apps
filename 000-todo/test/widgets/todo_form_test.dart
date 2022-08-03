import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/widgets/todo_form.dart';

void main() {
  testWidgets('todo form should have a Form', (tester) async {
    await tester.pumpWidget(
      BlocProvider<TodoCubit>(
        create: (context) => TodoCubit(),
        child: const MaterialApp(
          home: Scaffold(body: TodoForm()),
        ),
      ),
    );

    final todoTitleField = find.byType(TextFormField);
    final todoTitleFieldErrorText = find.text('Please enter todo title');
    final cancelButton = find.text('Cancel');
    final saveButton = find.text('Save');

    expect(find.byType(Form), findsOneWidget);
    expect(find.text('New Todo'), findsOneWidget);
    expect(todoTitleField, findsOneWidget);
    expect(todoTitleFieldErrorText, findsNothing);
    expect(cancelButton, findsOneWidget);
    expect(saveButton, findsOneWidget);

    await tester.tap(saveButton);
    await tester.pump();

    expect(todoTitleFieldErrorText, findsOneWidget);

    await tester.enterText(todoTitleField, '    ');
    await tester.tap(saveButton);
    await tester.pump();

    expect(todoTitleFieldErrorText, findsOneWidget);

    await tester.enterText(todoTitleField, 'title');
    await tester.tap(saveButton);
    await tester.pump();

    expect(todoTitleFieldErrorText, findsNothing);
  });
}
