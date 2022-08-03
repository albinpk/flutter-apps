import 'package:flutter/material.dart';
import 'package:todo/pages/pages.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo',
      home: TodoPage(),
    );
  }
}
