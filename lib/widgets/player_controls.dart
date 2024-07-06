import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/providers/audio_provider.dart';

class PlayerControls extends ConsumerStatefulWidget {
  const PlayerControls({super.key});

  @override
  ConsumerState<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends ConsumerState<PlayerControls> {
  @override
  Widget build(BuildContext context) {
    bool isPlaying = ref.watch(audioProvider).playing;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Slider(
            min: 0,
            max: 100,
            value: 50,
            onChanged: (value) {},
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('00:00'),
              Text('00:01'),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shuffle),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    iconSize: 36,
                  ),
                  icon: const Icon(Icons.skip_previous),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(audioProvider.notifier).playOrPause();
                  },
                  style: IconButton.styleFrom(
                    iconSize: 64,
                  ),
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                const SizedBox(width: 6),
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    iconSize: 36,
                  ),
                  icon: const Icon(Icons.skip_next),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.repeat),
            ),
          ],
        )
      ],
    );
  }
}
