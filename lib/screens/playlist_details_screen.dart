import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/playlist.dart';
import 'package:plonde/providers/audio_provider.dart';
import 'package:plonde/providers/playlist_provider.dart';
import 'package:plonde/util/functions.dart';
import 'package:plonde/widgets/song_list.dart';
import 'package:provider/provider.dart';

class PlaylistDetails extends ConsumerWidget {
  final String playlistId;

  const PlaylistDetails({
    super.key,
    required this.playlistId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistState = ref.watch(playlistProvider);
    Playlist playlist =
        playlistState.firstWhere((element) => element.id == playlistId);
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.name),
      ),
      body: SongList(
        songs: playlist.songs,
        isInPlaylist: true,
        onSongDismiss: (song) {},
        onItemTap: (song) {
          final audioProvider = context.read<AudioNotifer>();
          audioProvider.setSongQueue([song]);
          audioProvider.playSong(song);
        },
        onAddQueueTap: (song) {
          context.read<AudioNotifer>().enqueueSong(song);
        },
        onPlaylistRemoveTap: (song) {
          final index = playlist.songs.indexOf(song);
          ref
              .read(playlistProvider.notifier)
              .removeSongFromPlaylist(playlist, song);
          showUndoSnackBar(
            context,
            '${song.title} removed from playlist.',
            () => ref
                .read(playlistProvider.notifier)
                .insertSongIntoPlaylist(playlist, index, song),
          );
        },
      ),
    );
  }
}
