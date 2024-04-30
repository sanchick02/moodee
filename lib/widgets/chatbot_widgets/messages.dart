import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  final String name;
  final Function onAnimatedTextFinished;
  final isAnimated = ValueNotifier(false);

  Messages({
    Key? key,
    required this.isUser,
    required this.message,
    required this.date,
    required this.name,
    required this.onAnimatedTextFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 20,
        right: isUser ? 20 : 100,
      ),
      decoration: BoxDecoration(
        color: isUser ? AppColor.btnColorPrimary : AppColor.btnColorSecondary,
        boxShadow: [
          AppShadow.innerShadow3,
        ],
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
          topRight: const Radius.circular(20),
          bottomRight: !isUser ? const Radius.circular(20) : Radius.zero,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: isUser
                    ? AppFonts.smallRegularTextWhite
                    : AppFonts.smallRegularText,
              ),
              Text(
                date,
                style: isUser
                    ? AppFonts.extraSmallLightTextWhite
                    : AppFonts.extraSmallLightText,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          if (!isUser)
            Text(
              message,
              style: AppFonts.smallLightText,
            ),
          if (isUser)
            Text(
              message,
              style: AppFonts.smallLightTextWhite,
            ),
        ],
      ),
    );
  }
}
