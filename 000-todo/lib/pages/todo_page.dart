import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: const TodoView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new Todo
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, i) {
        if (i == 0) return TodoItem(todo: Todo(title: 'title'));
        return TodoItem(todo: Todo(title: 'title', isDone: true));
      },
    );
  }
}
