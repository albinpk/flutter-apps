import 'package:flutter/material.dart';

/// Transparent AppBar.
class TransparentAppBar extends StatelessWidget with PreferredSizeWidget {
  const TransparentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.grey,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
