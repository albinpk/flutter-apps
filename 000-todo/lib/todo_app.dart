import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

import 'cubit/todo_cubit.dart';
import 'pages/pages.dart';
import 'repositories/repositories.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({
    super.key,
    required this.localStorage,
  });

  final LocalStorage localStorage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(
      create: (context) => TodoCubit(
        repository: LocalStorageTodoRepository(localStorage),
      )..getTodos(),
      child: MaterialApp(
        title: 'Todo',
        darkTheme: ThemeData.dark(),
        home: const TodoPage(),
      ),
    );
  }
}
