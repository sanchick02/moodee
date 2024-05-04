import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/screens/chatbot/chatbot_screen.dart';
import 'package:moodee/screens/community/community_screen.dart';
import 'package:moodee/screens/profile/profile_screen.dart';
import 'package:moodee/screens/therapy/music_player.dart';
import 'package:moodee/screens/home_screen.dart';
import 'package:moodee/screens/therapy/therapy_screen.dart';

navigateNextPage(BuildContext context, Widget nextPage) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => nextPage),
  );
}

void navigateToPlayer(BuildContext context, MediaItem mediaItem) {
  MediaItem media = mediaItem;
  List<MediaItem> list = [];
  if (mediaItem is MusicItem) {
    list = musicList;
  } else if (mediaItem is MeditationItem) {
    list = meditationList;
  } else if (mediaItem is StoryItem) {
    list = storyList;
  }
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MusicPlayer(mediaItem: media, mediaList: list),
    ),
  );
}

navbarNavigation(BuildContext context, int? currentIndex, int? selectedIndex) {
  if (currentIndex != selectedIndex) {
    switch (selectedIndex) {
      case 0:
        navigateNextPage(
          context,
          HomeScreen(
            mediaItem: meditationList[0],
            mediaList: meditationList,
          ),
        );
        break;
      case 1:
        navigateNextPage(
          context,
          HomeScreen(
            mediaItem: meditationList[0],
            mediaList: meditationList,
          ),
        );
        // TherapyScreen(
        //   mediaItem: meditationList[0],
        // ));
        break;
      case 2:
        navigateNextPage(
            context, const ChatBotScreen()); // to be changed to AI Chatbot
        break;
      case 3:
        navigateNextPage(
            context,
            // TherapyScreen(
            //   mediaItem: meditationList[0],
            // ),
            CommunityScreen());
        break;
      case 4:
        navigateNextPage(context, ProfileScreen());
        break;

      case null:
        break;

      default:
        // Handle other cases if needed
        break;
    }
  }
}
