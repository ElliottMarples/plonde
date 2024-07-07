import 'package:flutter/material.dart';
import 'package:plonde/providers/audio_provider.dart';
import 'package:plonde/screens/navigation_screen.dart';
import 'package:provider/provider.dart';

class QueueScreen extends StatelessWidget {
  final PageController pageController;

  const QueueScreen({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final songQueue = context.watch<AudioNotifer>().songQueue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue'),
        actions: [
          IconButton(
            onPressed: () {
              pageController.animateToPage(
                Pages.player.index,
                duration: const Duration(milliseconds: 256),
                curve: Curves.easeInOut,
              );
            },
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
              child: song.albumArtUri == null
                  ? const SizedBox(height: 48, width: 48)
                  : Image.network(
                      song.albumArtUri!,
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
