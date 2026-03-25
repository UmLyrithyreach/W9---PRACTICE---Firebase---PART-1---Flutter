import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'testproject-478e9-default-rtdb.firebaseio.com',
    '/songs.json',
  );

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> songsJson = json.decode(response.body);
      return songsJson.entries
          .map((entry) => SongDto.fromJson(entry.key, entry.value))
          .toList();
    } else {
      print('Firebase error: Status ${response.statusCode}');
      print('Firebase URL: $songsUri');
      print('Firebase response: ${response.body}');
      throw Exception('Failed to load songs - Status: ${response.statusCode}');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    final Uri uri = Uri.https(
      'testproject-478e9-default-rtdb.firebaseio.com',
      '/songs/$id.json',
    );
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200 && response.body != 'null') {
      Map<String, dynamic> json2 = json.decode(response.body);
      return SongDto.fromJson(id, json2);
    }
    return null;
  }
}
