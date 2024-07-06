import 'package:plonde/data/temp_data.dart';
import 'package:plonde/models/playlist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistNotifier extends StateNotifier<List<Playlist>> {
  PlaylistNotifier() : super(storedPlaylists);

  void addPlaylist(Playlist playlist) {
    state = [...state, playlist];
  }

  void insertPlaylist(int index, Playlist playlist) {
    state = [...state]..insert(index, playlist);
  }

  void removePlaylist(Playlist playlist) {
    state = [...state]..remove(playlist);
  }
}

final playlistProvider =
    StateNotifierProvider<PlaylistNotifier, List<Playlist>>(
  (ref) => PlaylistNotifier(),
);
