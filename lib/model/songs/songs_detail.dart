import 'song.dart';

/// Holds a Song together with the resolved artist info.
/// Created in the ViewModel after fetching both collections.
class SongDetail {
  final Song song;
  final String artistName;
  final String artistGenre;

  SongDetail({
    required this.song,
    required this.artistName,
    required this.artistGenre,
  });
}