import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/models/models.dart';
import 'package:todo/widgets/widgets.dart';

import '../helpers/tester_extension.dart';
import '../mocks/mocks.dart';

void main() {
  group('TodoPageAppBar', () {
    late TodoCubit todoCubit;
    final todo = Todo(title: 'T');

    setUp(() {
      todoCubit = MockTodoCubit();
      when(() => todoCubit.state).thenReturn(const TodoInitial());
    });

    // Common tests for web and mobile
    for (var isWeb in [true, false]) {
      final platform = isWeb ? 'web' : 'mobile';

      testWidgets(
        'should have title in $platform',
        (tester) async {
          await tester.pumpAndWrap(
            const Scaffold(appBar: TodoPageAppBar()),
            todoCubit: todoCubit,
            inWeb: isWeb,
            withScaffold: false,
          );
          expect(find.text('Todo'), findsOneWidget);
        },
      );

      group('TodoStatus', () {
        // Finders
        final statusText = find.byKey(const Key('todo-status-text-key'));

        testWidgets(
          'should not render if todos is empty in $platform',
          (tester) async {
            await tester.pumpAndWrap(
              const Scaffold(appBar: TodoPageAppBar()),
              todoCubit: todoCubit,
              inWeb: isWeb,
              withScaffold: false,
            );
            expect(statusText, findsNothing);
          },
        );

        testWidgets(
          'should render if todos is not empty in $platform',
          (tester) async {
            when(() => todoCubit.state).thenReturn(TodoFetched(todos: [todo]));
            await tester.pumpAndWrap(
              const Scaffold(appBar: TodoPageAppBar()),
              todoCubit: todoCubit,
              inWeb: isWeb,
              withScaffold: false,
            );
            expect(statusText, findsOneWidget);
          },
        );

        testWidgets(
          'should correctly format on right side in $platform',
          (tester) async {
            when(() => todoCubit.state).thenReturn(TodoFetched(todos: [todo]));
            await tester.pumpAndWrap(
              const Scaffold(appBar: TodoPageAppBar()),
              todoCubit: todoCubit,
              inWeb: isWeb,
              withScaffold: false,
            );
            expect(tester.widget<Text>(statusText).data, '0/1');
          },
        );

        testWidgets(
          'should correctly format on left side in $platform',
          (tester) async {
            when(() => todoCubit.state).thenReturn(
              TodoFetched(todos: [todo.copyWith(isDone: true)]),
            );
            await tester.pumpAndWrap(
              const Scaffold(appBar: TodoPageAppBar()),
              todoCubit: todoCubit,
              inWeb: isWeb,
              withScaffold: false,
            );
            expect(tester.widget<Text>(statusText).data, '1/1');
          },
        );
      });
    }
  });
}
