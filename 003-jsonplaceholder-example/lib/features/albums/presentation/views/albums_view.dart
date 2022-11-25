import 'package:flutter/material.dart';

import '../../models/album_model.dart';
import '../../repositories/albums_repository.dart';
import '../widgets/album_tile.dart';

class AlbumsView extends StatefulWidget {
  const AlbumsView({super.key});

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  final _albumsFuture = AlbumRepository().getAllAlbums();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
      future: _albumsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) return const Center(child: Text('An error!'));

        if (!snapshot.hasData) {
          return const Center(child: Text('No data found!'));
        }

        final albums = snapshot.data!;

        if (albums.isEmpty) {
          return const Center(child: Text('No Albums found!'));
        }

        return ListView.builder(
          itemCount: albums.length,
          itemBuilder: (context, index) {
            return AlbumTile(album: albums[index]);
          },
        );
      },
    );
  }
}
