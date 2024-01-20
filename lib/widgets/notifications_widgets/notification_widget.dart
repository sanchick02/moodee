import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/notifications.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          AppShadow.innerShadow3,
          AppShadow.innerShadow4,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                notificationsList[index].title,
                style: AppFonts.smallRegularText,
              ),
              Text(
                notificationsList[index].time,
                style: AppFonts.extraSmallRegularText,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            notificationsList[index].notificationText,
            style: AppFonts.extraSmallLightText,
          )
        ],
      ),
    );
  }
}
