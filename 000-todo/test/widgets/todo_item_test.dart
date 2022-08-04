import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/models.dart';
import 'package:todo/widgets/widgets.dart';

class _FakeTodo extends Fake implements Todo {}

class _MockTodoCubit extends MockCubit<TodoState> implements TodoCubit {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeTodo());
  });

  late TodoCubit todoCubit;

  setUp(() {
    todoCubit = _MockTodoCubit();
  });

  testWidgets(
    'TodoItem should have a CheckboxListTile with value false '
    'and should call TodoCubit.toggleIsDone() with given [todo] on tap',
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

      expect(todoTile, findsOneWidget);
      expect(tester.widget<CheckboxListTile>(todoTile).value, isFalse);

      await tester.tap(todoTile);
      await tester.pump();

      verify(
        () => todoCubit.toggleIsDone(
          any(that: equals(todo)),
        ),
      ).called(1);
    },
  );
}
