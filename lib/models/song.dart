import 'package:uuid/uuid.dart' as uuid;

const uuidGenerator = uuid.Uuid();

class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String albumArtUri;

  Song({
    required this.title,
    required this.artist,
    required this.album,
    required this.albumArtUri,
  }) : id = uuidGenerator.v4();

  bool isLiked = false;

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      albumArtUri: json['album_art_uri'],
    );
  }
}
