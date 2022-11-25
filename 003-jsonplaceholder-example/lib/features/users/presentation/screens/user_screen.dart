import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueGrey,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                user.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 5),
            Center(child: Text('@${user.username}')),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: IconTheme(
                data: const IconThemeData(
                  color: Colors.blueGrey,
                  size: 18,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(width: 5),
                        Text(user.email),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.link),
                        const SizedBox(width: 5),
                        Text(
                          user.website,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.call),
                        const SizedBox(width: 5),
                        Text(
                          user.phone,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 5),
                        Text(user.address.toStringShort()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
