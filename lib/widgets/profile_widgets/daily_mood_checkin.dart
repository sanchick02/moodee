import 'package:flutter/material.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/styles.dart';

class DailyMoodCheckIn extends StatelessWidget {
  DailyMoodCheckIn({
    super.key,
    this.image = '',
    required this.day,
  });

  late String image;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton.outlined(
              onPressed: () {},
              icon: image.isNotEmpty
                  ? Image.asset(
                      image,
                      width: 25,
                      height: 25,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          day,
          style: AppFonts.smallLightText,
        ),
      ],
    );
  }
}
