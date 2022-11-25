import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/album_model.dart';
import '../models/photo_model.dart';

class AlbumRepository {
  /// Base url.
  static const _base = 'https://jsonplaceholder.typicode.com';

  Future<List<Album>> getAllAlbums() async {
    try {
      final res = await http.get(Uri.parse('$_base/albums'));
      final rawAlbums = jsonDecode(res.body) as List;
      return rawAlbums.map((e) => Album.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Album> getAlbumById(int id) async {
    try {
      final res = await http.get(Uri.parse('$_base/albums/$id'));
      final rawAlbum = json.decode(res.body);
      return Album.fromMap(rawAlbum);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<Album>> getAllAlbumByUser(int userId) async {
    try {
      final res = await http.get(Uri.parse('$_base/users/$userId/albums'));
      final rawAlbum = jsonDecode(res.body) as List;
      return rawAlbum.map((e) => Album.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<Photo>> getPhotosByAlbum(int albumId) async {
    try {
      final res = await http.get(Uri.parse('$_base/albums/$albumId/photos'));
      final rawPhotos = jsonDecode(res.body) as List;
      return rawPhotos.map((e) => Photo.fromMap(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
