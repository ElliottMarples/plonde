import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/song.dart';
import 'package:plonde/providers/song_provider.dart';
import 'package:plonde/widgets/song/new_song_form.dart';

class UpdateSongScreen extends ConsumerWidget {
  const UpdateSongScreen({super.key});

  void _updateSong(Song song, WidgetRef ref) {
    ref.read(songProvider.notifier).addSong(song);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Song'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: NewSongForm(
            onFormSubmitted: (song) => _updateSong(song, ref),
          ),
        ),
      ),
    );
  }
}
