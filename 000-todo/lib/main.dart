import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:window_size/window_size.dart';

import 'todo_app.dart';
import 'utils/extensions/target_platform_extension.dart';
import 'utils/test_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform.isDesktop) {
    setWindowTitle('Todo');
    setWindowMinSize(const Size(400, 450));
  }

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
