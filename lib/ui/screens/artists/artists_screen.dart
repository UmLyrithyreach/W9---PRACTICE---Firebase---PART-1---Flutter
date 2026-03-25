import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/screens/library/view_model/artist_view_model.dart';
import 'package:flutter_application_1/ui/widgets/artist/artists_content.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/artists/artist_repository.dart';


class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArtistsViewModel(
        artistRepository: context.read<ArtistRepository>(),
      ),
      child: const ArtistsContent(),
    );
  }
}