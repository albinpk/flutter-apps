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
                  previous.doneCount != current.doneCount;
            },
            builder: (context, state) {
              if (state.todos.isEmpty) return const SizedBox.shrink();

              return Text(
                '${state.doneCount}/${state.todos.length}',
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
