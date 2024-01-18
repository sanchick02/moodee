import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/button.dart';

class SectionTitleAndButton extends StatelessWidget {
  SectionTitleAndButton({
    super.key,
    required this.sectionTitle,
    required this.press,
  });

  final String sectionTitle;
  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Text(
            sectionTitle,
            style: AppFonts.normalRegularText,
          ),
          Spacer(),
          DefaultButton(
              text: "See All",
              press: press,
              backgroundColor: AppColor.btnColorPrimary,
              height: 35,
              fontStyle: AppFonts.smallLightTextWhite,
              width: 100,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
        ],
      ),
    );
  }
}
