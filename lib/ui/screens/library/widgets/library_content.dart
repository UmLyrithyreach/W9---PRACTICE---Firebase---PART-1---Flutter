import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/songs/songs_detail.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    AsyncValue<List<SongDetail>> asyncValue = mv.songsValue;

    Widget content;
    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;
      case AsyncValueState.success:
        List<SongDetail> details = asyncValue.data!;
        content = ListView.builder(
          itemCount: details.length,
          itemBuilder: (context, index) => SongTile(
            songDetail: details[index],
            isPlaying: mv.isSongPlaying(details[index].song),
            onTap: () {
              mv.start(details[index].song);
            },
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text('Library', style: AppTextStyles.heading),
          const SizedBox(height: 50),
          Expanded(child: content),
        ],
      ),
    );
  }
}