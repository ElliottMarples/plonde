import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/providers/playlist_provider.dart';
import 'package:plonde/widgets/playlist/playlist_list_item.dart';

class PickPlaylistSheet extends ConsumerWidget {
  const PickPlaylistSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlists = ref.watch(playlistProvider);

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
