import 'package:flutter/material.dart';

import '../../../../core/widgets/transparent_app_bar.dart';
import '../../../users/models/user_model.dart';
import '../../../users/presentation/screens/user_screen.dart';
import '../../../users/repositories/user_repository.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';
import '../../repositories/post_repository.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    super.key,
    required this.postId,
  });

  final int postId;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late final _postFuture = PostRepository().getPostById(widget.postId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Post>(
          future: _postFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('An error!'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data found!'));
            }

            final post = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PostAuthor(userId: post.userId),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    post.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(post.body),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Comments',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Expanded(
                  child: _PostComments(postId: post.id),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PostComments extends StatefulWidget {
  const _PostComments({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final int postId;

  @override
  State<_PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<_PostComments> {
  late final _commentsFuture =
      PostRepository().getAllCommentsOfPost(widget.postId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: _commentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('An error!'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('No data found!'));
        }

        final comments = snapshot.data!;

        if (comments.isEmpty) {
          return const Center(child: Text('No Comments found!'));
        }

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return const Divider(color: Colors.grey);
          },
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return _CommentTile(comment: comments[index]);
          },
        );
      },
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.email,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.blue,
                ),
          ),
          Text(comment.name),
        ],
      ),
      subtitle: Text(comment.body),
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

        final user = snapshot.data!;

        return TextButton.icon(
          icon: const Icon(Icons.person),
          label: Text(user.name),
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return UserScreen(userId: user.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
