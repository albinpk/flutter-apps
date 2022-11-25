import 'package:flutter/material.dart';

import '../../../users/models/user_model.dart';
import '../../../users/repositories/user_repository.dart';
import '../../models/post_model.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(post.body),
            const SizedBox(height: 10),
            _PostAuthor(userId: post.userId),
          ],
        ),
      ),
    );
  }
}

class _PostAuthor extends StatefulWidget {
  const _PostAuthor({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final int userId;

  @override
  State<_PostAuthor> createState() => _PostAuthorState();
}

class _PostAuthorState extends State<_PostAuthor> {
  late final _userFuture = UserRepository().getUserById(widget.userId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        if (snapshot.hasError) return const Text('An error!');

        if (!snapshot.hasData) return const Text('No user found!');

        return Text(snapshot.data!.name);
      },
    );
  }
}
