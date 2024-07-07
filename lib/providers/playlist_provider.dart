import 'package:plonde/data/temp_data.dart';
import 'package:plonde/models/playlist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plonde/models/song.dart';
import 'package:plonde/util/extensions.dart';

class PlaylistNotifier extends StateNotifier<List<Playlist>> {
  PlaylistNotifier() : super(storedPlaylists);

  Playlist getPlaylist(String playlistId) {
    return state.firstWhere((element) => element.id == playlistId);
  }

  void addPlaylist(Playlist playlist) {
    state = [...state, playlist];
  }

  void insertPlaylist(int index, Playlist playlist) {
    state = [...state]..insert(index, playlist);
  }

  void removePlaylist(Playlist playlist) {
    state = [...state]..remove(playlist);
  }

  void addSongToPlaylist(Playlist playlist, Song song) {
    final index = state.indexOf(playlist);
    playlist.songs.add(song);
    state = [...state]..replace(index, playlist);
  }

  void insertSongIntoPlaylist(Playlist playlist, int songIndex, Song song) {
    final playlistIndex = state.indexOf(playlist);
    playlist.songs.insert(songIndex, song);
    state = [...state]..replace(playlistIndex, playlist);
  }

  void removeSongFromPlaylist(Playlist playlist, Song song) {
    final index = state.indexOf(playlist);
    playlist.songs.remove(song);
    state = [...state]..replace(index, playlist);
  }
}

final playlistProvider =
    StateNotifierProvider<PlaylistNotifier, List<Playlist>>(
  (ref) => PlaylistNotifier(),
);
