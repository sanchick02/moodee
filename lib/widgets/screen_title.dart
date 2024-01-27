import 'package:flutter/material.dart';
import 'package:moodee/presets/fonts.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.largeMediumText,
        ),
      ],
    );
  }
}
