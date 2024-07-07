import 'package:flutter/material.dart';
import 'package:plonde/models/song.dart';
import 'package:plonde/providers/audio_provider.dart';
import 'package:provider/provider.dart';

class SongListItem extends StatelessWidget {
  final void Function(Song song)? onTap;

  const SongListItem({
    super.key,
    required this.song,
    this.onTap,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => onTap?.call(song),
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
          trailing: PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    context.read<AudioNotifer>().addSong(song);
                  },
                  child: const Text('Add to Queue'),
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
