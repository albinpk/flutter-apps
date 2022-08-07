import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../models/models.dart';

class TodoForm extends StatefulWidget {
  final Todo? todo;

  const TodoForm({
    super.key,
    this.todo,
  });

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.todo == null ? 'New Todo' : 'Edit Todo',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.todo?.title,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Title'),
                  ),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter todo title';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value!.trim(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.todo?.description,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Description'),
                  ),
                  maxLines: 3,
                  onSaved: (value) => _description = value?.trim() ?? '',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _onSave,
                      child: const Text('Save'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.todo == null) {
        context.read<TodoCubit>().addTodo(Todo(title: _title));
      } else {
        context
            .read<TodoCubit>()
            .updateTodo(widget.todo!.copyWith(title: _title));
      }

      Navigator.of(context).pop();
    }
  }
}
