import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/artists/artist_repository.dart';
import 'package:flutter_application_1/data/repositories/songs/song_repository_firebase.dart';
import 'package:provider/provider.dart';
import 'view_model/library_view_model.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import 'widgets/library_content.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the dependencies from the parent providers
    final songRepository = context.read<SongRepositoryFirebase>();
    final playerState = context.read<PlayerState>();
    final artistRepository = context.read<ArtistRepository>();

    return ChangeNotifierProvider(
      create: (_) => LibraryViewModel(
        playerState: playerState,
        songRepository: songRepository,
        artistRepository: artistRepository,
      ),
      child: LibraryContent(),
    );
  }
}
