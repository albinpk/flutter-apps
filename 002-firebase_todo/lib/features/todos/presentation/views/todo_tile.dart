import 'package:firebase_todo/features/todos/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          todo.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
