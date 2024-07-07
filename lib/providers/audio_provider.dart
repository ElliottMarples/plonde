import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:plonde/models/song.dart';

enum LoopMode {
  none,
  all,
  one,
}

class AudioNotifer with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<Song> _songQueue = [];
  int _currentSongIndex = 0;

  bool _isPlaying = false;
  LoopMode _loopMode = LoopMode.none;

  AudioNotifer() {
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _playNextSong();
      }
      _isPlaying = playerState.playing;
      notifyListeners();
    });
    _audioPlayer.positionStream.listen((_) {
      notifyListeners();
    });
  }

  AudioPlayer get audioPlayer => _audioPlayer;
  List<Song> get songQueue => _songQueue;
  int get currentSongIndex => _currentSongIndex;
  Song? get currentSong =>
      _songQueue.isNotEmpty ? _songQueue[_currentSongIndex] : null;
  bool get isPlaying => _isPlaying;
  Duration? get position => _audioPlayer.position;
  Duration? get duration => _audioPlayer.duration;
  LoopMode get loopMode => _loopMode;

  void setSongQueue(List<Song> songs) {
    _songQueue = songs;
    notifyListeners();
  }

  void enqueueSong(Song song) {
    _songQueue.add(song);
    notifyListeners();
  }

  void dequeueSong(Song song) {
    _songQueue.remove(song);
    notifyListeners();
  }

  void dequeueSongByIndex(int index) {
    final song = _songQueue[index];
    dequeueSong(song);
  }

  void playOrPause() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    notifyListeners();
  }

  void playSong(Song song) async {
    if (!_songQueue.contains(song)) {
      return;
    }
    final index = _songQueue.indexOf(song);
    _currentSongIndex = index;
    if (song.audioUriType == AudioUriType.network) {
      await _audioPlayer.setUrl(song.audioUri);
    } else {
      await _audioPlayer.setFilePath(song.audioUri);
    }
    _audioPlayer.play();
    notifyListeners();
  }

  void playSongByIndex(int index) async {
    final song = _songQueue[index];
    playSong(song);
  }

  void _playNextSong() {
    if (_loopMode == LoopMode.one) {
      playSongByIndex(_currentSongIndex);
    } else if (_currentSongIndex + 1 < _songQueue.length) {
      playSongByIndex(_currentSongIndex + 1);
    } else if (_loopMode == LoopMode.all) {
      playSongByIndex(0);
    }
  }

  void _playPreviousSong() {
    if (_currentSongIndex - 1 >= 0) {
      playSongByIndex(_currentSongIndex - 1);
    }
  }

  void toggleLoop() {
    if (_loopMode == LoopMode.none) {
      _loopMode = LoopMode.all;
    } else if (_loopMode == LoopMode.all) {
      _loopMode = LoopMode.one;
    } else {
      _loopMode = LoopMode.none;
    }
    notifyListeners();
  }

  void seekSong(Duration position) {
    _audioPlayer.seek(position);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
