import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../models/models.dart';
import 'todo_form.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return _TodoTile(todo: todo);

    return Dismissible(
      key: ValueKey(todo),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context.read<TodoCubit>().deleteTodo(todo);
      },
      background: const ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 25),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      child: _TodoTile(todo: todo),
    );
  }
}

class _TodoTile extends StatelessWidget {
  final Todo todo;

  const _TodoTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium?.copyWith(
          decoration: todo.isDone ? TextDecoration.lineThrough : null,
          fontWeight: todo.isDone ? null : FontWeight.w500,
        );
    return Center(
      child: SizedBox(
        width: kIsWeb ? 600 : null,
        child: CheckboxListTile(
          value: todo.isDone,
          title: Text(todo.title, style: style),
          subtitle: todo.description.isNotEmpty ? Text(todo.description) : null,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (_) {
            context.read<TodoCubit>().toggleIsDone(todo);
          },
          secondary: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Edit',
                onPressed: () => _onEditTap(context),
                icon: const Icon(Icons.edit),
              ),
              if (kIsWeb)
                IconButton(
                  tooltip: 'Delete',
                  onPressed: () => context.read<TodoCubit>().deleteTodo(todo),
                  icon: const Icon(Icons.delete),
                )
            ],
          ),
        ),
      ),
    );
  }

  void _onEditTap(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: TodoForm(todo: todo),
      ),
    );
  }
}
