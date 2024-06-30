import 'package:flutter/material.dart';
import 'package:plonde/models/song.dart';

class SongListItem extends StatelessWidget {
  const SongListItem({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {},
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              song.albumArtUri,
              height: 48,
              width: 48,
            ),
          ),
          title: Text(song.title),
          subtitle: Text(song.artist),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
