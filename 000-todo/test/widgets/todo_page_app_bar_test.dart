import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/models.dart';
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
  });

  testWidgets(
    'TodoPageAppBar should have a title '
    'and todo status text should update on TodoState change',
    (tester) async {
      final todo = Todo(title: 'title');

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => todoCubit,
          child: const MaterialApp(
            home: TodoPageAppBar(),
          ),
        ),
      );

      expect(find.widgetWithText(AppBar, 'Todo'), findsOneWidget);
      expect(find.text('0/0'), findsNothing);

      todoCubit.addTodo(todo);
      await tester.pump();

      expect(find.text('0/1'), findsOneWidget);

      todoCubit.toggleIsDone(todo);
      await tester.pumpAndSettle();

      expect(find.text('1/1'), findsOneWidget);

      todoCubit.toggleIsDone(todo.copyWith(isDone: true));
      await tester.pumpAndSettle();

      expect(find.text('0/1'), findsOneWidget);

      todoCubit.deleteTodo(todo);
      await tester.pumpAndSettle();

      expect(find.text('0/0'), findsNothing);
    },
  );
}
