import 'package:flutter/material.dart';

class TodoPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TodoPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Todo'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
