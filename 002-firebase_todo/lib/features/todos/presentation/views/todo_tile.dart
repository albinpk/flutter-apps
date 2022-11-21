import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo/features/todos/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todoDocumentSnapshot,
  });

  final QueryDocumentSnapshot<Todo> todoDocumentSnapshot;

  @override
  Widget build(BuildContext context) {
    final todo = todoDocumentSnapshot.data();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                todo.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              onPressed: () => todoDocumentSnapshot.reference.delete(),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
