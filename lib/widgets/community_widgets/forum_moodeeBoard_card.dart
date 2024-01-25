import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/forum_moodeeboard.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';

class ForumMoodeeBoardCard extends StatelessWidget {
  const ForumMoodeeBoardCard({
    super.key,
    required this.index,
    required this.margin,
  });

  final int index;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      margin: margin,
      width: (MediaQuery.of(context).size.width) - 30,
      constraints: BoxConstraints(minHeight: 200),
      decoration: BoxDecoration(
        color: AppColor.fontColorSecondary,
        borderRadius: AppStyles.borderRadiusAll,
        boxShadow: [
          AppShadow.innerShadow3,
          AppShadow.innerShadow4,
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                forumMoodeeBoardList[index].userImage,
                width: 60,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forumMoodeeBoardList[index].name,
                    style: AppFonts.smallLightText,
                  ),
                  Text(
                    forumMoodeeBoardList[index].time,
                    style: AppFonts.extraSmallLightText,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${forumMoodeeBoardList[index].caption} ...See More',
            style: AppFonts.smallLightText,
          )
        ],
      ),
    );
  }
}
