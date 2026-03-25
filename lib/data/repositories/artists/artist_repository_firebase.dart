import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistsUri = Uri.https('testproject-478e9-default-rtdb.firebaseio.com', '/artists.json');

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistsJson = json.decode(response.body);
      return artistsJson.entries
          .map((entry) => ArtistDto.fromJson(entry.key, entry.value))
          .toList();
    } else {
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    final Uri uri = Uri.https('testproject-478e9-default-rtdb.firebaseio.com', '/artists/$id.json');
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200 && response.body != 'null') {
      Map<String, dynamic> json2 = json.decode(response.body);
      return ArtistDto.fromJson(id, json2);
    }
    return null;
  }
}