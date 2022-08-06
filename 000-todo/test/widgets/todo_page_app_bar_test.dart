import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/widgets/widgets.dart';

void main() {
  testWidgets(
    'TodoPageAppBar should have a title',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TodoPageAppBar(),
        ),
      );

      expect(find.widgetWithText(AppBar, 'Todo'), findsOneWidget);
    },
  );
}
