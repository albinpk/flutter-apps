import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../utils/extensions/target_platform_extension.dart';
import '../utils/test_helper.dart';
import '../widgets/widgets.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TodoPageAppBar(),
      body: TodoView(),
      floatingActionButton: TodoPageFab(),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoDeleted) {
          final isWeb = context.read<TestHelper>().isWeb;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior:
                    isWeb ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
                width: isWeb
                    ? MediaQuery.of(context).size.width > 600
                        ? 550
                        : null
                    : null,
                content: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                    ),
                    children: [
                      const TextSpan(text: 'Deleting: '),
                      TextSpan(
                        text: state.deletedTodo.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    context.read<TodoCubit>().undoDelete();
                  },
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.todos.isEmpty) {
          return const Center(
            child: Text('Create a todo'),
          );
        }

        return Row(
          children: [
            Expanded(
              child: ListView.builder(
                controller: ScrollController(),
                itemCount: state.todos.length + 1,
                itemBuilder: (context, i) {
                  // Adding extra height at the end,
                  // for spacing between last item and FAB
                  if (i == state.todos.length) {
                    return const SizedBox(height: 80);
                  }

                  return TodoItem(todo: state.todos[i]);
                },
              ),
            ),
            if ((context.select((TestHelper h) => h.isWeb) ||
                    Theme.of(context).platform.isDesktop) &&
                MediaQuery.of(context).size.width > 800)
              const Expanded(child: TodoForm()),
          ],
        );
      },
    );
  }
}
