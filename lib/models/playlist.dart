import 'package:plonde/models/song.dart';
import 'package:uuid/uuid.dart' as uuid;

const uuidGenerator = uuid.Uuid();

class Playlist {
  final String id;
  final String name;
  final String description;
  final String coverArtUri;
  final List<Song> songs;

  Playlist({
    required this.name,
    this.description = '',
    required this.coverArtUri,
    required this.songs,
  }) : id = uuidGenerator.v4();

  int get length => songs.length;

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      name: json['name'],
      coverArtUri: json['cover_art_uri'],
      songs: json['songs'],
    );
  }
}
