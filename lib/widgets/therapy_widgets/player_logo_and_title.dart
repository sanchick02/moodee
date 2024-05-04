import 'package:flutter/material.dart';
import 'package:moodee/presets/fonts.dart';

class PlayerLogoAndTitle extends StatelessWidget {
  const PlayerLogoAndTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Text(
            title,
            style: AppFonts.largeMediumText,
          ),
        ),
        Image.asset(
          "lib/assets/images/Logo.png",
          width: 200,
        ),
      ],
    );
  }
}
