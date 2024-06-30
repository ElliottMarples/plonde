import 'package:plonde/data/temp_data.dart';
import 'package:plonde/models/song.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SongNotifier extends StateNotifier<List<Song>> {
  SongNotifier() : super(storedSongs);

  void addSong(Song song) {
    state = [...state, song];
  }

  void insertSong(int index, Song song) {
    state = [...state]..insert(index, song);
  }

  void removeSong(Song song) {
    state = [...state]..remove(song);
  }
}

final songProvider = StateNotifierProvider<SongNotifier, List<Song>>(
  (ref) => SongNotifier(),
);
