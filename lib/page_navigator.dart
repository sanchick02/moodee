import 'package:flutter/material.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/screens/therapy/therapy_player_screen.dart';
import 'package:moodee/Home_Page.dart';

// to be reused as a navigator for switching pages

navigateNextPage(BuildContext context, Widget nextPage) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => nextPage),
  );
}

void navigateToPlayer(BuildContext context, MediaItem mediaItem) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TherapyPlayerScreen(mediaItem: mediaItem),
    ),
  );
}

navbarNavigation(BuildContext context, int index) {
  switch (index) {
    case 0:
      navigateNextPage(context, const HomeScreen());
      break;
    case 1:
      navigateNextPage(context, const HomeScreen());
      break;
    case 2:
      navigateNextPage(context, const HomeScreen());
      break;
    case 3:
      navigateNextPage(context, const HomeScreen());
      break;
    case 4:
      navigateNextPage(context, const HomeScreen());
      break;
  }
}
