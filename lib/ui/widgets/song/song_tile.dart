import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/songs/songs_detail.dart';


class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.songDetail,
    required this.isPlaying,
    required this.onTap,
  });

  final SongDetail songDetail;
  final bool isPlaying;
  final VoidCallback onTap;

  String _formatDuration(Duration duration) {
    int minutes = duration.inMinutes;
    return '$minutes mins';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(songDetail.song.imageUrl),
          ),
          title: Text(songDetail.song.title),
          subtitle: Text(
            '${_formatDuration(songDetail.song.duration)}  '
            '${songDetail.artistName} – ${songDetail.artistGenre}',
          ),
          trailing: Icon(
            isPlaying ? Icons.favorite : Icons.favorite_border,
            color: Colors.blue[200],
          ),
        ),
      ),
    );
  }
}