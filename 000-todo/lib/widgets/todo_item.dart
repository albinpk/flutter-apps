import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../models/models.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium?.copyWith(
          decoration: todo.isDone ? TextDecoration.lineThrough : null,
          fontWeight: todo.isDone ? null : FontWeight.w500,
        );
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title, style: style),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (_) {
        context.read<TodoCubit>().toggleIsDone(todo);
      },
    );
  }
}
