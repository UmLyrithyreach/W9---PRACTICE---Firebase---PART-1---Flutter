// song_repository_mock.dart

import '../../../model/songs/song.dart';
import 'song_repository.dart';

class SongRepositoryMock implements SongRepository {
  static const String assetPath = 'assets/picture/ronan_the_best.jpg';
  final List<Song> _songs = [
    Song(
      id: 's1',
      title: 'Ronan the best song 1',
      artistId: 'artist-1',
      duration: const Duration(minutes: 2, seconds: 50),
      assetPath: assetPath,
      imageUrl: '',
    ),
    Song(
      id: 's2',
      title: 'Ronan the best song 2',
      artistId: 'artist-2',
      duration: const Duration(minutes: 3, seconds: 20),
      assetPath: assetPath,
      imageUrl: '',
    ),
    Song(
      id: 's3',
      title: 'Ronan the best song 3',
      artistId: 'artist-3',
      duration: const Duration(minutes: 3, seconds: 20),
      assetPath: assetPath,
      imageUrl: '',
    ),
    Song(
      id: 's4',
      title: 'Ronan the best song 4',
      artistId: 'artist-4',
      duration: const Duration(minutes: 3, seconds: 20),
      assetPath: assetPath,
      imageUrl: '',
    ),
    Song(
      id: 's5',
      title: 'Ronan the best song 5',
      artistId: 'artist-5',
      duration: const Duration(minutes: 3, seconds: 20),
      assetPath: assetPath,
      imageUrl: '',
    ),
  ];

  @override
  Future<List<Song>> fetchSongs() async {
    return Future.delayed(Duration(seconds: 1), () {
      return _songs;
    });
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    return Future.delayed(Duration(seconds: 4), () {
      return _songs.firstWhere(
        (song) => song.id == id,
        orElse: () => throw Exception("No song with id $id in the database"),
      );
    });
  }
}
