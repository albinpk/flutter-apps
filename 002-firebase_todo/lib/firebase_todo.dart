import 'package:firebase_todo/features/todos/presentation/views/todos_view.dart';
import 'package:flutter/material.dart';

class FirebaseTodo extends StatelessWidget {
  const FirebaseTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      title: 'Todo App',
      home: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TodosView(),
    );
  }
}
