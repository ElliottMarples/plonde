import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/playlist.dart';

class PlaylistListItem extends ConsumerWidget {
  final void Function(Playlist playlist)? onPlaylistTap;

  const PlaylistListItem({
    super.key,
    required this.playlist,
    this.onPlaylistTap,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => onPlaylistTap?.call(playlist),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              playlist.coverArtUri,
              height: 48,
              width: 48,
            ),
          ),
          title: Text(playlist.name),
          subtitle: Text('${playlist.length} Songs'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
