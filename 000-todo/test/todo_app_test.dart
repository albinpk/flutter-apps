import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/pages/pages.dart';
import 'package:todo/todo_app.dart';

import 'helpers/tester_extension.dart';
import 'mocks/mocks.dart';

void main() {
  group('TodoApp', () {
    late LocalStorage localStorage;

    setUp(() {
      localStorage = MockLocalStorage();
    });

    testWidgets(
      'should have a TodoPage and should call localstorage.getItems',
      (tester) async {
        await tester.pumpAndWrap(
          TodoApp(localStorage: localStorage),
          withMaterial: false,
          withScaffold: false,
        );
        expect(find.byType(TodoPage), findsOneWidget);
        // localStorage.getItem() will called from getTodos() method in TodoCubit
        verify(() => localStorage.getItem(any())).called(1);
      },
    );
  });
}
