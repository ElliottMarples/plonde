import 'package:flutter/material.dart';

class PlayerControls extends StatefulWidget {
  const PlayerControls({super.key});

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  bool _isPaused = false;

  @override
  Widget build(BuildContext context) {
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
                    setState(() {
                      _isPaused = !_isPaused;
                    });
                  },
                  style: IconButton.styleFrom(
                    iconSize: 64,
                  ),
                  icon: Icon(_isPaused ? Icons.pause : Icons.play_arrow),
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
