import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/song.dart';
import 'package:plonde/providers/song_provider.dart';
import 'package:plonde/screens/update_song.dart';
import 'package:plonde/widgets/song_list.dart';

class PlaylistsScreen extends ConsumerWidget {
  const PlaylistsScreen({super.key});

  void _deleteSong(Song song, BuildContext context, WidgetRef ref) {
    int index = ref.read(songProvider).indexOf(song);
    ref.read(songProvider.notifier).removeSong(song);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${song.title} removed from library.'),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          ref.read(songProvider.notifier).insertSong(index, song);
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(songProvider);

    return Scaffold(
      appBar: AppBar(
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
      body: SongList(
        songs: songs,
        onSongDismiss: (song) => _deleteSong(song, context, ref),
      ),
    );
  }
}
