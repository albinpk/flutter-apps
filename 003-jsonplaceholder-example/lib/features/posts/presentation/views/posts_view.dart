import 'package:flutter/material.dart';

import '../../models/post_model.dart';
import '../../repositories/post_repository.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  final Future<List<Post>> _postsFuture = PostRepository().getAllPosts();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) return const Center(child: Text('An error!'));

        if (!snapshot.hasData) {
          return const Center(child: Text('No data found!'));
        }

        final posts = snapshot.data!;

        if (posts.isEmpty) {
          return const Center(child: Text('No Posts found!'));
        }

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Text(posts[index].title);
          },
        );
      },
    );
  }
}
