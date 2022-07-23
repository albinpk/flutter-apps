import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/todo/todo.dart';

void main() {
  testWidgets('TodoPage should have a Scaffold ', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: TodoPage()),
    );

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
