import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/models/events_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/screens/events/event_details.dart';

class EventCard extends StatelessWidget {
  EventCard({
    super.key,
    required this.eventList,
    required this.index,
    required this.margin,
  });

  List<Event> eventList;
  final int index;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(
              index: index,
              eventList: eventList,
              eventImage: '',
            ),
          ),
        );
      },
      child: Container(
        margin: margin,
        child: Stack(
          children: [
            Container(
              height: 230,
              width: 180,
              decoration: BoxDecoration(
                color: AppColor.btnColorSecondary,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  AppShadow.innerShadow3,
                  AppShadow.innerShadow4,
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                eventList[index].month,
                                style: AppFonts.smallLightText,
                              ),
                              Text(
                                eventList[index].date,
                                style: AppFonts.extraSmallLightText,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 1,
                          color: AppColor.fontColorPrimary,
                        ),
                        Container(
                          height: 50,
                          width: 120,
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                eventList[index].day,
                                style: AppFonts.smallLightText,
                              ),
                              Text(
                                eventList[index].time,
                                style: AppFonts.extraSmallLightText,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: AppStyles.borderRadiusTop,
                    boxShadow: [
                      AppShadow.innerShadow3,
                      AppShadow.innerShadow4,
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: AppStyles.borderRadiusTop,
                    child: Stack(
                      children: [
                        Image.asset(
                          eventList[index].image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          opacity: const AlwaysStoppedAnimation(0.7),
                        ),
                        Image.asset(
                          "lib/assets/images/meshGrad1.png",
                          width: double.infinity,
                          fit: BoxFit.cover,
                          opacity: const AlwaysStoppedAnimation(0.7),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 180,
                  width: 180,
                  padding: const EdgeInsets.only(
                    top: 50,
                    right: 15,
                    left: 10,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: AppStyles.borderRadiusTop,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Text(eventList[index].name).data!,
                              style: AppFonts.normalRegularTextHeight,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              Text(eventList[index].description).data!,
                              style: AppFonts.extraSmallLightText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: 180,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "lib/assets/icons/Location.png",
                        height: 15,
                        width: 15,
                      ),
                      Text(
                        eventList[index].location,
                        style: AppFonts.extraSmallRegularText,
                      )
                    ],
                  ),
                  Image.asset(
                    "lib/assets/icons/bell.png",
                    height: 20,
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
