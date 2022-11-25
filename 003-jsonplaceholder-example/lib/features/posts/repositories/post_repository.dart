import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

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

  Future<Post> getPostById() async {
    throw UnimplementedError();
  }
}
