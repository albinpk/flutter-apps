import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/models/models.dart';
import 'package:todo/widgets/widgets.dart';

void main() {
  testWidgets(
    'TodoItem should have a CheckboxListTile with value false',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoItem(
              todo: Todo(title: 'Todo title'),
            ),
          ),
        ),
      );

      final todoTile = find.widgetWithText(CheckboxListTile, 'Todo title');

      expect(todoTile, findsOneWidget);
      expect(tester.widget<CheckboxListTile>(todoTile).value, isFalse);
    },
  );
}
