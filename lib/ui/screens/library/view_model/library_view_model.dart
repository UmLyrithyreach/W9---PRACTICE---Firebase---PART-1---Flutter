import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/songs/songs_detail.dart';

import '../../../../data/repositories/artists/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/artists/artist.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<SongDetail>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.artistRepository,
    required this.playerState,
  }) {
    playerState.addListener(notifyListeners);
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSongs();
  }

  void fetchSongs() async {
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // Fetch both collections in parallel
      final results = await Future.wait([
        songRepository.fetchSongs(),
        artistRepository.fetchArtists(),
      ]);

      List<Song> songs = results[0] as List<Song>;
      List<Artist> artists = results[1] as List<Artist>;

      // Build a lookup map for O(1) access
      Map<String, Artist> artistMap = {
        for (Artist a in artists) a.id: a,
      };

      List<SongDetail> details = songs.map((song) {
        Artist? artist = artistMap[song.artistId];
        return SongDetail(
          song: song,
          artistName: artist?.name ?? 'Unknown',
          artistGenre: artist?.genre ?? '',
        );
      }).toList();

      songsValue = AsyncValue.success(details);
    } catch (e) {
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}