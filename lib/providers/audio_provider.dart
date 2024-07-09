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
  List<Song> _unshuffledSongQueue = [];
  int _currentSongIndex = 0;

  bool _isPlaying = false;
  LoopMode _loopMode = LoopMode.none;
  bool _isShuffled = false;

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
  Song? get nextSong => _songQueue.length > _currentSongIndex + 1
      ? _songQueue[_currentSongIndex + 1]
      : null;
  Song? get previousSong =>
      _currentSongIndex - 1 >= 0 ? _songQueue[_currentSongIndex - 1] : null;
  bool get isPlaying => _isPlaying;
  Duration? get position => _audioPlayer.position;
  Duration? get duration => _audioPlayer.duration;
  LoopMode get loopMode => _loopMode;
  bool get isShuffled => _isShuffled;

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
      playSong(currentSong!);
    } else if (nextSong != null) {
      playSong(nextSong!);
    } else if (_loopMode == LoopMode.all) {
      playSongByIndex(0);
    }
  }

  void _playPreviousSong() {
    if (previousSong != null) {
      playSong(previousSong!);
    }
  }

  void skipNextSong() {
    if (_loopMode == LoopMode.none && nextSong == null && duration != null) {
      seekSong(duration!);
    } else {
      _playNextSong();
    }
  }

  void skipPreviousSong() {
    if (position!.inSeconds >= const Duration(seconds: 10).inSeconds) {
      seekSong(Duration.zero);
    } else {
      _playPreviousSong();
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

  void toggleShuffle() {
    final song = _songQueue[_currentSongIndex];
    if (_isShuffled) {
      _songQueue = List.from(_unshuffledSongQueue);
      _unshuffledSongQueue.clear();
      _currentSongIndex = _songQueue.indexOf(song);
      _isShuffled = false;
    } else {
      final index = _songQueue.indexOf(song);
      _unshuffledSongQueue = List.from(_songQueue);
      _songQueue.remove(song);
      _songQueue.shuffle();
      _songQueue.insert(index, song);
      _isShuffled = true;
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
