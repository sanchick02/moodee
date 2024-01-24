import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/screens/mood_tracker_screen.dart';

class MoodTrackerButton extends StatelessWidget {
  const MoodTrackerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateNextPage(context, MoodTrackerScreen()),
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            AppShadow.innerShadow3,
            AppShadow.innerShadow4,
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/images/moodtracker.png",
              width: 70,
              height: 70,
            ),
            Text("Mood Tracker", style: AppFonts.smallLightText)
          ],
        ),
      ),
    );
  }
}
