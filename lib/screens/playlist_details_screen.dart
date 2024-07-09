import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/playlist.dart';
import 'package:plonde/providers/audio_provider.dart';
import 'package:plonde/providers/playlist_provider.dart';
import 'package:plonde/util/functions.dart';
import 'package:plonde/widgets/playlist/pick_playlist_sheet.dart';
import 'package:plonde/widgets/song/song_list.dart';
import 'package:provider/provider.dart';

class PlaylistDetails extends ConsumerWidget {
  final String playlistId;

  const PlaylistDetails({
    super.key,
    required this.playlistId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final playlistState = ref.watch(playlistProvider);
    Playlist playlist =
        playlistState.firstWhere((element) => element.id == playlistId);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 0, 26, 13),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    playlist.coverArtUri,
                    height: 144,
                    width: 144,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        playlist.name,
                        style: theme.textTheme.titleMedium,
                      ),
                      Text('${playlist.songs.length} Tracks'),
                      Text(
                        playlist.description,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha(160),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SongList(
              songs: playlist.songs,
              isInPlaylist: true,
              onSongDismiss: (song) {},
              onItemTap: (song) {
                final audioProvider = context.read<AudioNotifer>();
                audioProvider.setSongQueue([song]);
                audioProvider.playSong(song);
              },
              onAddQueueTap: (song) =>
                  context.read<AudioNotifer>().enqueueSong(song),
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
              onPlaylistAddOtherTap: (song) async {
                Playlist? newPlaylist = await showModalBottomSheet(
                  context: context,
                  builder: (context) => PickPlaylistSheet(
                    playlistFilter: (p) => p.id != playlist.id,
                  ),
                );
                if (newPlaylist != null) {
                  ref
                      .read(playlistProvider.notifier)
                      .addSongToPlaylist(newPlaylist, song);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
