import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/forum_channels.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/widgets/button.dart';

class ForumChannelCard extends StatelessWidget {
  const ForumChannelCard({
    super.key,
    required this.index, required this.margin,
  });

  final int index;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 30,
      ),
      margin: margin,
      width: (MediaQuery.of(context).size.width) - 30,
      height: 165,
      decoration: BoxDecoration(
        color: AppColor.fontColorSecondary,
        borderRadius: AppStyles.borderRadiusAll,
        boxShadow: [
          AppShadow.innerShadow3,
          AppShadow.innerShadow4,
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.asset(
                forumChannelList[index].image,
                width: 80,
                height: 80,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColor.fontColorPrimary,
                  borderRadius: AppStyles.borderRadiusAll,
                ),
                child: Text(
                  "11+",
                  textAlign: TextAlign.center,
                  style: AppFonts.smallLightTextWhite,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forumChannelList[index].title,
                  style: AppFonts.normalRegularTextHeight,
                ),
                const SizedBox(height: 10),
                DefaultButton(
                    text: "Join Channel",
                    press: () {},
                    backgroundColor: AppColor.btnColorPrimary,
                    height: 30,
                    fontStyle: AppFonts.smallLightTextWhite,
                    width: 150,
                    padding: EdgeInsets.zero)
              ],
            ),
          )
        ],
      ),
    );
  }
}
