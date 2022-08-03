import 'package:flutter/material.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'New Todo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Title'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _onSave,
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onSave() {
    // Save new todo
  }
}
