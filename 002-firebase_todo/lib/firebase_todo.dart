import 'package:firebase_todo/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

class FirebaseTodo extends StatelessWidget {
  const FirebaseTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo App',
      home: HomeView(),
    );
  }
}
