import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';

class EmojiMood extends StatelessWidget {
  const EmojiMood({
    super.key,
    required this.image,
    required this.mood,
  });
  final String image;
  final String mood;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 4) - 20,
      height: ((MediaQuery.of(context).size.width / 4) - 30) * 1.25,
      decoration: BoxDecoration(
        color: AppColor.btnColorSecondary,
        borderRadius: AppStyles.borderRadiusAll,
        boxShadow: [AppShadow.innerShadow3],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,
              height: ((MediaQuery.of(context).size.width / 4) - 30) * 0.7),
          Text(
            mood,
            style: AppFonts.extraSmallLightText,
          ),
        ],
      ),
    );
  }
}
