import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:plonde/models/song.dart';

class AudioNotifier extends StateNotifier<AudioPlayer> {
  AudioNotifier() : super(AudioPlayer());

  void setAudioUri(AudioUriType type, String uri) {
    if (type == AudioUriType.file) {
      state.setFilePath(uri);
    } else {
      state.setUrl(uri);
    }
  }

  void playOrPause() {
    if (state.playing) {
      state.pause();
    } else {
      state.play();
    }
  }
}

// final audioProvider = Provider<AudioPlayer>(
//   (ref) => AudioPlayer(),
// );

final audioProvider =
    StateNotifierProvider<AudioNotifier, AudioPlayer>((ref) => AudioNotifier());
