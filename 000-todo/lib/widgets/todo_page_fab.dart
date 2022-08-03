import 'package:flutter/material.dart';

class TodoPageFab extends StatelessWidget {
  const TodoPageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onTap(context),
      child: const Icon(Icons.add),
    );
  }

  void _onTap(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Dialog(
          child: Text('Todo form'),
        );
      },
    );
  }
}
