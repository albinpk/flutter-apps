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
            child: StreamBuilder<int>(
              stream: todosRef.snapshots().map((event) => event.docs.length),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                }

                if (snapshot.hasError) return const Text('An error');

                if (!snapshot.hasData || snapshot.data! == 0) {
                  return const SizedBox.shrink();
                }

                return Text(
                  '${snapshot.data!}',
                  style: Theme.of(context).textTheme.titleLarge,
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
