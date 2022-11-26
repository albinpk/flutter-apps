import 'package:flutter/material.dart';

import '../../../../core/widgets/transparent_app_bar.dart';
import '../../models/album_model.dart';
import '../../models/photo_model.dart';
import '../../repositories/albums_repository.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({
    super.key,
    required this.albumId,
  });

  final int albumId;

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late final _albumFuture = AlbumRepository().getAlbumById(widget.albumId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(),
      body: FutureBuilder<Album>(
        future: _albumFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return const Center(child: Text('An error!'));

          if (!snapshot.hasData) {
            return const Center(child: Text('No data found!'));
          }

          final album = snapshot.data!;

          return _AlbumContent(album: album);
        },
      ),
    );
  }
}

class _AlbumContent extends StatefulWidget {
  const _AlbumContent({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  State<_AlbumContent> createState() => _AlbumContentState();
}

class _AlbumContentState extends State<_AlbumContent> {
  late final _photosFuture =
      AlbumRepository().getPhotosByAlbum(widget.album.id);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Text(
            widget.album.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Photo>>(
              future: _photosFuture,
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

                final photos = snapshot.data!;

                if (photos.isEmpty) {
                  return const Center(child: Text('No Photos found!'));
                }

                // This ClipRRect corresponds to the grid item's border radius.
                return ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(),
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      return _PhotoItem(photo: photos[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Return crossAxis count for GridView.
  int _getCrossAxisCount() {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 400) return 2;
    if (screenWidth < 600) return 3;
    if (screenWidth < 800) return 4;
    return 5;
  }
}

class _PhotoItem extends StatelessWidget {
  const _PhotoItem({
    Key? key,
    required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        footer: GridTileBar(
          title: Text(photo.title, maxLines: 2),
          backgroundColor: Colors.black26,
        ),
        child: Image.network(
          photo.url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}
