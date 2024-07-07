import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plonde/providers/audio_provider.dart';

class PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode loopMode;
  final Duration? position;
  final Duration? duration;
  final void Function()? onPlayTap;
  final void Function()? onSkipNextTap;
  final void Function()? onSkipPreviousTap;
  final void Function()? onShuffleTap;
  final void Function()? onLoopTap;
  final void Function(double value)? onSeek;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.loopMode,
    required this.position,
    required this.duration,
    this.onPlayTap,
    this.onSkipNextTap,
    this.onSkipPreviousTap,
    this.onShuffleTap,
    this.onLoopTap,
    this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Slider(
            min: 0,
            max: duration?.inMilliseconds.toDouble() ?? 100,
            value: clampDouble(position?.inMilliseconds.toDouble() ?? 0, 0,
                duration?.inMilliseconds.toDouble() ?? 100),
            onChanged: onSeek,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(position != null
                  ? '${position!.inMinutes}:${'${position!.inSeconds % 60}'.padLeft(2, '0')}'
                  : '0:00'),
              Text(duration != null
                  ? '${duration!.inMinutes}:${'${duration!.inSeconds % 60}'.padLeft(2, '0')}'
                  : '0:00'),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: onShuffleTap,
              icon: const Icon(Icons.shuffle),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onSkipPreviousTap,
                  style: IconButton.styleFrom(
                    iconSize: 36,
                  ),
                  icon: const Icon(Icons.skip_previous),
                ),
                IconButton(
                  onPressed: onPlayTap,
                  style: IconButton.styleFrom(
                    iconSize: 64,
                  ),
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                const SizedBox(width: 6),
                IconButton(
                  onPressed: onSkipNextTap,
                  style: IconButton.styleFrom(
                    iconSize: 36,
                  ),
                  icon: const Icon(Icons.skip_next),
                ),
              ],
            ),
            IconButton(
              onPressed: onLoopTap,
              icon: loopMode == LoopMode.one
                  ? const Icon(Icons.repeat_one)
                  : const Icon(Icons.repeat),
              color:
                  loopMode == LoopMode.none ? null : theme.colorScheme.primary,
            ),
          ],
        )
      ],
    );
  }
}
