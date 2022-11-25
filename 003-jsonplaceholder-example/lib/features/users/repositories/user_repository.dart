import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserRepository {
  /// Base url.
  static const _base = 'https://jsonplaceholder.typicode.com';

  /// Fetch users from api.
  Future<List<User>> getAllUsers() async {
    try {
      final res = await http.get(Uri.parse('$_base/users'));
      final rawUsers = json.decode(res.body) as List;
      return rawUsers.map((e) => User.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<User> getUserById(int id) async {
    try {
      final res = await http.get(Uri.parse('$_base/users/$id'));
      final rawUser = json.decode(res.body);
      return User.fromMap(rawUser);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
