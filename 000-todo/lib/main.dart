import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorage = LocalStorage('000-todo.json');
  final isLocalStorageReady = await localStorage.ready;
  assert(isLocalStorageReady);

  runApp(TodoApp(localStorage: localStorage));
}
