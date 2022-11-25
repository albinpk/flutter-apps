import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';
import '../widgets/user_tile.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final Future<List<User>> _usersFuture = UserRepository().getAllUsers();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _usersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) return const Center(child: Text('An error!'));

        if (!snapshot.hasData) {
          return const Center(child: Text('No data found!'));
        }

        final users = snapshot.data!;

        if (users.isEmpty) {
          return const Center(child: Text('No Users found!'));
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return UserTile(user: users[index]);
          },
        );
      },
    );
  }
}
