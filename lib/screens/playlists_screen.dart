import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/playlist.dart';
import 'package:plonde/screens/navigation_screen.dart';
import 'package:plonde/screens/update_song_screen.dart';
import 'package:plonde/widgets/playlist_list.dart';
import 'package:plonde/providers/playlist_provider.dart';

class PlaylistsScreen extends ConsumerWidget {
  final PageController pageController;
  const PlaylistsScreen({super.key, required this.pageController});

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => pageController.animateToPage(
            Pages.player.index,
            duration: const Duration(milliseconds: 256),
            curve: Curves.easeInOut,
          ),
          icon: const Icon(Icons.arrow_back),
        ),
        // backgroundColor: Colors.grey.shade900,
        title: const Text('Mixtapes'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UpdateSongScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: PlaylistList(
        playlists: playlists,
        onPlaylistDismiss: (playlist) =>
            _deletePlaylist(playlist, context, ref),
      ),
    );
  }
}