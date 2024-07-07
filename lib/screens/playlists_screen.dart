import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/playlist.dart';
import 'package:plonde/widgets/playlist_list.dart';
import 'package:plonde/providers/playlist_provider.dart';

class PlaylistsScreen extends ConsumerWidget {
  const PlaylistsScreen({super.key});

  void _deletePlaylist(Playlist playlist, BuildContext context, WidgetRef ref) {
    int index = ref.read(playlistProvider).indexOf(playlist);
    ref.read(playlistProvider.notifier).removePlaylist(playlist);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${playlist.name} removed from library.'),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          ref.read(playlistProvider.notifier).insertPlaylist(index, playlist);
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlists = ref.watch(playlistProvider);

    return Scaffold(
      body: PlaylistList(
        playlists: playlists,
        onPlaylistDismiss: (playlist) =>
            _deletePlaylist(playlist, context, ref),
      ),
    );
  }
}
