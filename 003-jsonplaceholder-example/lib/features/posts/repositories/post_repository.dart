import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/comment_model.dart';
import '../models/post_model.dart';

class PostRepository {
  /// Base url.
  static const _base = 'https://jsonplaceholder.typicode.com';

  /// Fetch posts from api.
  Future<List<Post>> getAllPosts() async {
    try {
      final res = await http.get(Uri.parse('$_base/posts'));
      final rawPosts = jsonDecode(res.body) as List;
      return rawPosts.map((e) => Post.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Fetch post by id.
  Future<Post> getPostById(int id) async {
    try {
      final res = await http.get(Uri.parse('$_base/posts/$id'));
      final rawPost = json.decode(res.body);
      return Post.fromMap(rawPost);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Fetch all post by userId.
  Future<List<Post>> getAllPostsByUser(int userId) async {
    try {
      final res = await http.get(Uri.parse('$_base/users/$userId/posts'));
      final rawPosts = jsonDecode(res.body) as List;
      return rawPosts.map((e) => Post.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Fetch all comments of a post.
  Future<List<Comment>> getAllCommentsOfPost(int postId) async {
    try {
      final res = await http.get(Uri.parse('$_base/posts/$postId/comments'));
      final rawComments = jsonDecode(res.body) as List;
      return rawComments.map((e) => Comment.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
