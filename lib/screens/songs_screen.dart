import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/song.dart';
import 'package:plonde/providers/audio_provider.dart';
import 'package:plonde/providers/song_provider.dart';
import 'package:plonde/util/functions.dart';
import 'package:plonde/widgets/song_list.dart';
import 'package:provider/provider.dart';

class SongsScreen extends ConsumerWidget {
  const SongsScreen({super.key});

  void _deleteSong(Song song, BuildContext context, WidgetRef ref) {
    int index = ref.read(songProvider).indexOf(song);
    ref.read(songProvider.notifier).removeSong(song);
    // '${song.title} removed from library.'
    showUndoSnackBar(
      context,
      '${song.title} removed from library.',
      () => ref.read(songProvider.notifier).insertSong(index, song),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(songProvider);

    return Scaffold(
      body: SongList(
        songs: songs,
        onSongDismiss: (song) => _deleteSong(song, context, ref),
        onItemTap: (song) {
          final audioProvider = context.read<AudioNotifer>();
          audioProvider.setSongQueue([song]);
          audioProvider.playSong(song);
        },
      ),
    );
  }
}
