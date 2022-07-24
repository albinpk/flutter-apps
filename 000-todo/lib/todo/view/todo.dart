import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  /// ```
  /// name = '/';
  /// ```
  static const name = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: const TodoView(),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CheckboxListTile(
          value: true,
          title: Text(
            'Todo 1',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(decoration: TextDecoration.lineThrough),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (_) {},
        ),
        CheckboxListTile(
          value: false,
          title: Text(
            'Todo 2',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (_) {},
        ),
      ],
    );
  }
}
