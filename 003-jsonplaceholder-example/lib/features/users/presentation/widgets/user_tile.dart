import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../screens/user_screen.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Row(
        children: [
          const Icon(Icons.location_on, size: 16, color: Colors.grey),
          Text(
            '${user.address.street}, ${user.address.city}',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return UserScreen(userId: user.id);
            },
          ),
        );
      },
    );
  }
}
