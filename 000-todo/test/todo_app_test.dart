import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/pages/pages.dart';
import 'package:todo/todo_app.dart';

class _MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late LocalStorage localStorage;

  setUp(() {
    localStorage = _MockLocalStorage();
  });

  testWidgets(
    'TodoApp should have MateriaApp with title and TodoPage widget '
    'and should call todoCubit.getTodos() when BlocProvider created',
    (tester) async {
      await tester.pumpWidget(TodoApp(localStorage: localStorage));

      final materialApp = find.byType(MaterialApp);

      expect(materialApp, findsOneWidget);
      expect(find.byType(TodoPage), findsOneWidget);
      expect(tester.widget<MaterialApp>(materialApp).title, 'Todo');
      // localStorage.getItem() will called from getTodos() method in TodoCubit
      verify(() => localStorage.getItem(any())).called(1);
    },
  );
}
