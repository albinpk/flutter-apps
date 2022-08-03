import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/todo_app.dart';

void main() {
  testWidgets('app should have MateriaApp widget', (tester) async {
    await tester.pumpWidget(const TodoApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
