import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
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
          String todoTitle = state.deletedTodo.title;
          if (todoTitle.length > 15) {
            todoTitle = todoTitle.replaceRange(15, null, '...');
          }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                    ),
                    children: [
                      const TextSpan(text: 'Todo '),
                      TextSpan(
                        text: '"$todoTitle"',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' deleted!')
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

        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, i) {
            return TodoItem(todo: state.todos[i]);
          },
        );
      },
    );
  }
}
