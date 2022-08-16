import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/widgets/widgets.dart';

import '../helpers/tester_extension.dart';

void main() {
  group('TodoPageFab', () {
    // Finders
    final fabWithIcon = find.widgetWithIcon(FloatingActionButton, Icons.add);

    // Common tests for web and mobile
    for (var isWeb in [true, false]) {
      final platform = isWeb ? 'web' : 'mobile';

      testWidgets(
        'should have add icon and tooltip in $platform',
        (tester) async {
          await tester.pumpAndWrap(
            const Scaffold(floatingActionButton: TodoPageFab()),
            withScaffold: false,
            inWeb: isWeb,
          );
          expect(fabWithIcon, findsOneWidget);
          expect(
            tester.widget<FloatingActionButton>(fabWithIcon).tooltip,
            'Add Todo',
          );
        },
      );

      testWidgets(
        'should open TodoForm dialog when pressed in $platform',
        (tester) async {
          await tester.pumpAndWrap(
            const Scaffold(floatingActionButton: TodoPageFab()),
            withScaffold: false,
            inWeb: isWeb,
          );
          await tester.tap(fabWithIcon);
          await tester.pump();
          expect(find.byType(Dialog), findsOneWidget);
          expect(find.byType(TodoForm), findsOneWidget);
        },
      );
    }
  });
}
