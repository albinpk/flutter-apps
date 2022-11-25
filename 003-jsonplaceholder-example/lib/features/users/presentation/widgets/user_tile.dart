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
          const Icon(Icons.location_on, size: 16),
          Text(
            '${user.address.street}, ${user.address.city}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return UserScreen(user: user);
            },
          ),
        );
      },
    );
  }
}