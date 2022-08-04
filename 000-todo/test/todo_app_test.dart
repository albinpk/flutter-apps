import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/pages/pages.dart';
import 'package:todo/todo_app.dart';

void main() {
  testWidgets(
    'TodoApp should have MateriaApp with title and TodoPage widget',
    (tester) async {
      await tester.pumpWidget(const TodoApp());

      final materialApp = find.byType(MaterialApp);

      expect(materialApp, findsOneWidget);
      expect(find.byType(TodoPage), findsOneWidget);
      expect(tester.widget<MaterialApp>(materialApp).title, 'Todo');
    },
  );
}
