import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

import 'todo_app.dart';
import 'utils/test_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorage = LocalStorage('000-todo.json');
  final isLocalStorageReady = await localStorage.ready;
  assert(isLocalStorageReady);

  runApp(
    RepositoryProvider<TestHelper>(
      create: (context) => const TestHelper(),
      child: TodoApp(localStorage: localStorage),
    ),
  );
}
