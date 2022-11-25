import 'package:flutter/material.dart';

import '../../models/album_model.dart';
import '../screens/album_screen.dart';

class AlbumTile extends StatelessWidget {
  const AlbumTile({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(album.title),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return AlbumScreen(albumId: album.id);
            },
          ),
        );
      },
    );
  }
}
