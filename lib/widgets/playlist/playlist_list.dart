import 'package:flutter/material.dart';
import 'package:plonde/models/playlist.dart';
import 'package:plonde/screens/playlist_details_screen.dart';
import 'package:plonde/widgets/playlist/playlist_list_item.dart';

class PlaylistList extends StatelessWidget {
  final List<Playlist> playlists;
  final void Function(Playlist playlist) onPlaylistDismiss;
  final bool showPlaylistOptions;

  const PlaylistList({
    super.key,
    required this.playlists,
    required this.onPlaylistDismiss,
    this.showPlaylistOptions = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return Dismissible(
          key: ValueKey(playlist.id),
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
          onDismissed: (direction) => onPlaylistDismiss(playlist),
          child: PlaylistListItem(
            playlist: playlist,
            showOptions: showPlaylistOptions,
            onPlaylistTap: (playlist) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlaylistDetails(
                    playlistId: playlist.id,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
