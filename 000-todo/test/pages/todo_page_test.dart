import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/pages/pages.dart';
import 'package:todo/widgets/widgets.dart';

void main() {
  late TodoCubit todoCubit;

  setUp(() {
    todoCubit = TodoCubit();
  });

  testWidgets(
    'TodoPage should have AppBar with title, '
    'TodoView and TodoPageFab. '
    'And should show info text if todos list is empty',
    (tester) async {
      await tester.pumpWidget(
        BlocProvider<TodoCubit>(
          create: (context) => todoCubit,
          child: const MaterialApp(home: TodoPage()),
        ),
      );

      expect(find.widgetWithText(AppBar, 'Todo'), findsOneWidget);
      expect(find.byType(TodoView), findsOneWidget);
      expect(find.text('Create a todo'), findsOneWidget);
      expect(find.byType(TodoPageFab), findsOneWidget);

      todoCubit.addTodo(Todo(title: 'title1'));
      await tester.pump();

      expect(find.text('Create a todo'), findsNothing);
      expect(find.text('title1'), findsOneWidget);
    },
  );
}
