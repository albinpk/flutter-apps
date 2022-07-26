import 'package:firebase_todo/features/todos/presentation/views/todo_form.dart';
import 'package:firebase_todo/features/todos/presentation/views/todos_view.dart';
import 'package:firebase_todo/features/todos/presentation/widgets/todos_app_bar.dart';
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
    return Scaffold(
      appBar: const TodosAppBar(),
      body: const TodosView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const Dialog(
                child: TodoForm(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
