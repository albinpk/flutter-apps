import 'package:flutter/material.dart';

import '../todo/todo.dart';

class AppRouter {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case TodoPage.name:
      default:
        return MaterialPageRoute(
          builder: (context) => const TodoPage(),
        );
    }
  }
}
