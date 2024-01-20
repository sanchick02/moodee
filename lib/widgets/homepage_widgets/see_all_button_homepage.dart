import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/button.dart';

class SeeAllButtonHomepage extends StatelessWidget {
  const SeeAllButtonHomepage({
    super.key,
    required this.press,
  });

  final VoidCallback press; // shorthand for void Function()

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: "See All",
      press: () {
        press;
      },
      backgroundColor: AppColor.btnColorPrimary,
      height: 35,
      fontStyle: AppFonts.smallLightTextWhite,
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
