import 'package:flutter/material.dart';
import 'package:plonde/models/song.dart';
import 'package:plonde/widgets/song_list_item.dart';

class SongList extends StatelessWidget {
  final List<Song> songs;
  final void Function(Song song) onSongDismiss;

  const SongList({
    super.key,
    required this.songs,
    required this.onSongDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return Dismissible(
          key: ValueKey(song.id),
          background: Container(
            alignment: Alignment.centerRight,
            color: theme.colorScheme.errorContainer,
            padding: const EdgeInsets.only(right: 25),
            child: Icon(
              Icons.delete,
              color: theme.colorScheme.onErrorContainer,
              size: 30,
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) => onSongDismiss(song),
          child: SongListItem(song: song),
        );
      },
    );
  }
}
