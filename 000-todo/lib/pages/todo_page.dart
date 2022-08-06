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
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
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
