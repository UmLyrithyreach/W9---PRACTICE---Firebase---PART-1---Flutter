import '../../model/songs/song.dart';

class SongDto {
  static const String titleKey = 'title';
  static const String artistIdKey = 'artistId';
  static const String durationKey = 'durationMs'; // in ms
  static const String assetPathKey = 'assetPath';
  static const String imageUrlKey = 'imageUrl';

  static Song fromJson(String id, Map<String, dynamic> json) {
    int durationMs = 0;
    if (json[durationKey] != null) {
      if (json[durationKey] is String) {
        durationMs = int.parse(json[durationKey]);
      } else {
        durationMs = json[durationKey] as int;
      }
    }

    return Song(
      id: id,
      title: json[titleKey] ?? '',
      artistId: json[artistIdKey] ?? '',
      duration: Duration(milliseconds: durationMs),
      assetPath: json[assetPathKey] ?? '',
      imageUrl: json[imageUrlKey] ?? '',
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      titleKey: song.title,
      artistIdKey: song.artistId,
      durationKey: song.duration.inMilliseconds,
      assetPathKey: song.assetPath,
    };
  }
}
