import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/therapy_items_model.dart';

import 'package:moodee/widgets/back_button_top.dart';
import 'package:moodee/widgets/player_logo_and_title.dart';
import 'package:moodee/widgets/player_widget.dart';

class TherapyPlayerScreen extends StatelessWidget {
  const TherapyPlayerScreen({
    super.key,
    required this.mediaItem,
  });

  final MediaItem mediaItem;

  @override
  Widget build(BuildContext context) {
    late List<MediaItem> mediaList;
    if (mediaItem is MusicItem) {
      mediaList = musicList;
    } else if (mediaItem is MeditationItem) {
      mediaList = meditationList;
    } else if (mediaItem is StoryItem) {
      mediaList = storyList;
    }
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
              PlayerLogoAndTitle(title: Text(mediaItem.therapyType).data!),
              PlayerWidget(
                mediaItem: mediaItem,
                mediaList: mediaList,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
