import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/screens/prev_chat_screen.dart';
import 'package:moodee/screens/community/community_screen.dart';
import 'package:moodee/screens/profile/profile_screen.dart';
import 'package:moodee/screens/therapy/therapy_player_screen.dart';
import 'package:moodee/screens/home_screen.dart';
import 'package:moodee/screens/therapy/therapy_screen.dart';

// to be reused as a navigator for switching pages

navigateNextPage(BuildContext context, Widget nextPage) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => nextPage),
  );
}

void navigateToPlayer(BuildContext context, CustomMediaItem mediaItem) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TherapyPlayerScreen(mediaItem: mediaItem),
    ),
  );
}

navbarNavigation(BuildContext context, int? currentIndex, int? selectedIndex) {
  if (currentIndex != selectedIndex) {
    switch (selectedIndex) {
      case 0:
        navigateNextPage(context, const HomeScreen());
        break;
      case 1:
        navigateNextPage(
            context,
            TherapyScreen(
              mediaItem: meditationList[0],
            ));
        break;
      case 2:
        navigateNextPage(
            context, const ChatScreen()); // to be changed to AI Chatbot
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
        navigateNextPage(context, const ProfileScreen());
        break;

      case null:
        break;

      default:
        // Handle other cases if needed
        break;
    }
  }
}
