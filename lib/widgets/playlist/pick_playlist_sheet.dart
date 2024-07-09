import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/playlist.dart';
import 'package:plonde/providers/playlist_provider.dart';
import 'package:plonde/widgets/playlist/playlist_list_item.dart';

class PickPlaylistSheet extends ConsumerWidget {
  final bool Function(Playlist playlist)? playlistFilter;

  const PickPlaylistSheet({super.key, this.playlistFilter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistState = ref.watch(playlistProvider);
    final playlists = playlistFilter == null
        ? playlistState
        : playlistState.where(playlistFilter!).toList();

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Choose a Playlist',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return PlaylistListItem(
                  playlist: playlist,
                  showOptions: false,
                  onPlaylistTap: (playlist) {
                    Navigator.of(context).pop(playlist);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
