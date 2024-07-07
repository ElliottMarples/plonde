import 'package:flutter/material.dart';
import 'package:plonde/providers/audio_provider.dart';
import 'package:plonde/screens/navigation_screen.dart';
import 'package:plonde/widgets/player_controls.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  final PageController pageController;
  const PlayerScreen({
    super.key,
    required this.pageController,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<AudioNotifer>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => widget.pageController.animateToPage(
            Pages.queue.index,
            duration: const Duration(milliseconds: 256),
            curve: Curves.easeInOut,
          ),
          icon: const Icon(Icons.queue_music),
        ),
        actions: [
          IconButton(
            onPressed: () => widget.pageController.animateToPage(
              Pages.library.index,
              duration: const Duration(milliseconds: 256),
              curve: Curves.easeInOut,
            ),
            icon: const Icon(Icons.library_music),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 400,
              width: 400,
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  provider.currentSong?.albumArtUri ??
                      'https://picsum.photos/512',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  width: 480,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 275,
                            child: Text(
                              provider.currentSong?.title ??
                                  '[Song Not Loaded]',
                              style: theme.textTheme.titleLarge,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                          Text(
                            provider.currentSong?.artist ?? '',
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      if (provider.currentSong != null)
                        IconButton(
                          icon: Icon(
                            _isLiked ? Icons.favorite : Icons.favorite_outline,
                            color: theme.colorScheme.primary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isLiked = !_isLiked;
                            });
                          },
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PlayerControls(
                    isPlaying: provider.isPlaying,
                    loopMode: provider.loopMode,
                    position: provider.position,
                    duration: provider.duration,
                    onPlayTap: () => provider.playOrPause(),
                    onLoopTap: () => provider.toggleLoop(),
                    onSeek: (value) => provider.seekSong(
                      Duration(
                        milliseconds: value.toInt(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
