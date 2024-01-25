import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/song_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/repositories/song_repository.dart';

import 'package:moodee/widgets/back_button_top.dart';
import 'package:moodee/widgets/therapy_widgets/player_logo_and_title.dart';
import 'package:moodee/widgets/therapy_widgets/player_widget.dart';
import 'package:provider/provider.dart';

class TestPlayerScreen extends StatelessWidget {
  const TestPlayerScreen({
    super.key,
    required this.song,
    // required this.mediaItem,
  });

  // final CustomMediaItem mediaItem;
  final Song song;

  @override
  Widget build(BuildContext context) {
    // late List<CustomMediaItem> mediaList;
    // if (mediaItem is MusicItem) {
    //   mediaList = musicList;
    // } else if (mediaItem is MeditationItem) {
    //   mediaList = meditationList;
    // } else if (mediaItem is StoryItem) {
    //   mediaList = storyList;
    // }
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/assets/images/meshGrad1.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Row(
                  children: [
                    BackButtonTop(
                      onBackButtonPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              PlayerLogoAndTitle(title: Text(song.therapyType).data!),
              // PlayerWidget(
              //   mediaItem: song,
              //   mediaList: mediaList,
              // ),
              GestureDetector(
                onTap: () {
                  context.read<SongRepository>().setCurrentSong(song);
                  context.read<SongRepository>().play();
                },
                child: Container(
                  color: Colors.yellow,
                  width: 80,
                  height: 40,
                  child: Text("Play"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
