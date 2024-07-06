import 'package:flutter/material.dart';
import 'package:plonde/screens/playlists_screen.dart';
import 'package:plonde/widgets/player_controls.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({
    super.key,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PlaylistsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.library_music),
          ),
        ],
        title: const Text('Player Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                'https://picsum.photos/256',
                height: 256,
                width: 256,
              ),
            ),
            const SizedBox(height: 20),
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
                      Text(
                        'Song',
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        'Artist',
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
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
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const PlayerControls(),
            )
          ],
        ),
      ),
    );
  }
}
