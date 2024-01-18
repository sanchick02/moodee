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
  });

  List<Event> eventList;
  final int index;

  @override
  Widget build(BuildContext context) {
    // Determine if the index is even or odd
    bool isEvenIndex = index % 2 == 0;
    bool isOddIndex = !isEvenIndex;

    // Set left and right margins based on the index
    EdgeInsets cardMargin = EdgeInsets.only(
      left: isEvenIndex ? 15.0 : 0.0,
      right: isOddIndex ? 15.0 : 0.0,
    );
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
        margin: cardMargin,
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
                  bottom: 5,
                  left: 20,
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("View More"),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EventDetailsScreen(
                                  index: index,
                                  eventList: eventList,
                                  eventImage: '',
                                ),
                              ),
                            );
                          }, // open pop up
                          icon: Image.asset(
                            "lib/assets/icons/arrow_next_gray_small.png",
                            width: 25,
                          ),
                        ),
                      ],
                    ),
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
          ],
        ),
      ),
    );
  }
}
