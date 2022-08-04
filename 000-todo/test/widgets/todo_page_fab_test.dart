import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/widgets/widgets.dart';

void main() {
  testWidgets(
    'TodoPageFab should have a FloatingActionButton '
    'and should open TodoForm on tap',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: TodoPageFab()),
      );

      final fab = find.widgetWithIcon(FloatingActionButton, Icons.add);
      expect(fab, findsOneWidget);

      await tester.tap(fab);
      await tester.pump();

      expect(find.byType(Dialog), findsOneWidget);
      expect(find.byType(TodoForm), findsOneWidget);
    },
  );
}
