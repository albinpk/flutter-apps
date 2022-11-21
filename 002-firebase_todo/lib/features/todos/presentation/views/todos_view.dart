import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo/features/todos/models/todo_model.dart';
import 'package:firebase_todo/features/todos/presentation/views/todo_form.dart';
import 'package:firebase_todo/features/todos/presentation/views/todo_tile.dart';
import 'package:flutter/material.dart';

final CollectionReference<Todo> todosRef = FirebaseFirestore.instance
    .collection('todos')
    .withConverter<Todo>(
      fromFirestore: (snapshot, options) => Todo.fromMap(snapshot.data() ?? {}),
      toFirestore: (value, options) => value.toMap(),
    );

class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: todosRef.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('No todos found!'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return TodoTile(todoDocumentSnapshot: docs[index]);
            },
          );
        },
      ),
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
