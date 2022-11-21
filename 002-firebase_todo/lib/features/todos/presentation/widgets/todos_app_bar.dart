import 'package:firebase_todo/features/todos/models/todo_model.dart';
import 'package:firebase_todo/features/todos/presentation/views/todos_view.dart';
import 'package:flutter/material.dart';

class TodosAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TodosAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Todos'),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: StreamBuilder<Iterable<Todo>>(
              stream: todosRef
                  .snapshots()
                  .map((event) => event.docs.map((e) => e.data())),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                }

                if (snapshot.hasError) return const Text('An error');

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Row(
                  children: [
                    Text(
                      '${snapshot.data!.where((t) => t.isCompleted).length}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '/${snapshot.data!.length}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white54,
                          ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
