import 'package:flutter/material.dart';
import 'package:plonde/models/playlist.dart';
import 'package:plonde/widgets/song_list.dart';

class PlaylistDetails extends StatelessWidget {
  final Playlist playlist;

  const PlaylistDetails({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.name),
      ),
      body: SongList(
        songs: playlist.songs,
        onSongDismiss: (song) {},
      ),
    );
  }
}
