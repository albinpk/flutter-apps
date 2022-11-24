import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_todo/features/todos/models/todo_model.dart';
import 'package:firebase_todo/features/todos/presentation/views/todos_view.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({
    super.key,
    this.todoSnapshot,
  });

  /// To update an existing Todo.
  final QueryDocumentSnapshot<Todo>? todoSnapshot;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add new todo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autofocus: true,
              initialValue: widget.todoSnapshot?.data().title,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) return 'Title is required!';
                return null;
              },
              onSaved: (newValue) => _title = newValue!.trim(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _onSave,
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.todoSnapshot != null) {
        widget.todoSnapshot!.reference.update({'title': _title});
      } else {
        todosRef.add(
          Todo(
            title: _title,
            createdAt: DateTime.now(),
          ),
        );
      }
      Navigator.pop(context);
    }
  }
}
