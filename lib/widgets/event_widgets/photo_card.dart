import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/models/events_model.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    super.key,
    required this.eventList,
    required this.index,
    required this.eventImage,
  });

  final List<Event> eventList;
  final int index;
  final String eventImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 15.0,
          right: index == eventList[index].eventImages.length - 1 ? 15.0 : 0.0),
      height: 230,
      width: 170,
      child: ClipRRect(
        borderRadius: AppStyles.borderRadiusAll,
        child: Stack(
          children: [
            Image.asset(
              eventImage,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  AppShadow.innerShadow3,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
