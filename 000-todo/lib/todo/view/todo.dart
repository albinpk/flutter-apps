import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  /// ```
  /// name = '/';
  /// ```
  static const name = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Todo Page'),
    );
  }
}
