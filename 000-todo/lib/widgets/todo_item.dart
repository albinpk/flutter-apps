import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../models/models.dart';
import '../utils/extensions/target_platform_extension.dart';
import 'todo_form.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return (Theme.of(context).platform.isMobile)
        ? _MobileTile(todo: todo)
        : _DesktopTile(todo: todo);
  }
}

class _MobileTile extends StatelessWidget {
  final Todo todo;

  const _MobileTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: CheckboxListTile(
        value: todo.isDone,
        title: _TodoTitle(todo: todo),
        subtitle: todo.description.isNotEmpty ? Text(todo.description) : null,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (_) {
          context.read<TodoCubit>().toggleIsDone(todo);
        },
        secondary: _EditButton(todo: todo),
      ),
    );
  }
}

class _DesktopTile extends StatelessWidget {
  final Todo todo;

  const _DesktopTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _TodoTitle(todo: todo),
      leading: Checkbox(
        value: todo.isDone,
        onChanged: (value) {
          context.read<TodoCubit>().toggleIsDone(todo);
        },
      ),
      subtitle: todo.description.isNotEmpty ? Text(todo.description) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _EditButton(todo: todo),
          IconButton(
            tooltip: 'Delete',
            onPressed: () => context.read<TodoCubit>().deleteTodo(todo),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Edit',
      onPressed: () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          child: TodoForm(todo: todo),
        ),
      ),
      icon: const Icon(Icons.edit),
    );
  }
}

class _TodoTitle extends StatelessWidget {
  const _TodoTitle({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Text(
      todo.title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            fontWeight: todo.isDone ? null : FontWeight.w500,
          ),
    );
  }
}
