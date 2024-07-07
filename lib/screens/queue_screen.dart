import 'package:flutter/material.dart';
import 'package:plonde/providers/audio_provider.dart';
import 'package:provider/provider.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final songQueue = context.watch<AudioNotifer>().songQueue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: songQueue.length,
        itemBuilder: (context, index) {
          final song = songQueue[index];
          return ListTile(
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
          );
        },
      ),
    );
  }
}
