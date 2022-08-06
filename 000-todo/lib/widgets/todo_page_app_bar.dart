import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';

class TodoPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TodoPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Todo'),
      actions: [
        Center(
          widthFactor: 2,
          child: BlocBuilder<TodoCubit, TodoState>(
            buildWhen: (previous, current) {
              return previous.todos.length != current.todos.length ||
                  previous.todos.where((t) => t.isDone).length !=
                      current.todos.where((t) => t.isDone).length;
            },
            builder: (context, state) {
              final isDoneCount = state.todos.where((t) => t.isDone).length;
              final status = '$isDoneCount/${state.todos.length}';
              return Text(
                status,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
