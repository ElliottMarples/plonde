import 'package:flutter/material.dart';
import 'package:plonde/models/song.dart';

class SongListItem extends StatelessWidget {
  final Song song;
  final bool isInPlaylist;
  final void Function(Song song)? onSongTap;
  final void Function(Song song)? onAddQueueTap;
  final void Function(Song song)? onPlaylistRemoveTap;

  const SongListItem({
    super.key,
    required this.song,
    this.isInPlaylist = false,
    this.onSongTap,
    this.onAddQueueTap,
    this.onPlaylistRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => onSongTap?.call(song),
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
          trailing: isInPlaylist
              ? PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () => onAddQueueTap?.call(song),
                        child: const Text('Add to Queue'),
                      ),
                      PopupMenuItem(
                        onTap: () => onPlaylistRemoveTap?.call(song),
                        child: const Text('Remove from Playlist'),
                      ),
                    ];
                  },
                )
              : PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () => onAddQueueTap?.call(song),
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
