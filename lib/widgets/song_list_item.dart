import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/song.dart';
import 'package:plonde/providers/audio_provider.dart';

class SongListItem extends ConsumerWidget {
  const SongListItem({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          ref.read(audioProvider.notifier).setAudioUri(
                song.audioUriType,
                song.audioUri,
              );
          ref.read(audioProvider).play();
        },
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              song.albumArtUri,
              height: 48,
              width: 48,
            ),
          ),
          title: Text(song.title),
          subtitle: Text(song.artist),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
