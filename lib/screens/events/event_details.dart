import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/models/events_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/widgets/event_widgets/photo_card.dart';
import 'package:moodee/widgets/button.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({
    Key? key,
    required this.index,
    required this.eventList,
    required this.eventImage,
  }) : super(key: key);

  final List<Event> eventList;
  final int index;
  final String eventImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      eventList[index].image,
                      fit: BoxFit.cover,
                      height: 300,
                      width: double.infinity,
                      opacity: const AlwaysStoppedAnimation(0.7),
                    ),
                    Image.asset(
                      "lib/assets/images/meshGrad1.png",
                      height: 300,
                      width: double.infinity - 50,
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(0.7),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 300,
                        constraints: const BoxConstraints(maxWidth: 400),
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              Text(eventList[index].name).data!,
                              style: AppFonts.heading3Height,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              Text(eventList[index].description).data!,
                              style: AppFonts.smallLightText,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "lib/assets/icons/Location.png",
                                  width: 15,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  Text(eventList[index].location).data!,
                                  style: AppFonts.smallLightText,
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    "Event Details",
                    style: AppFonts.normalRegularText,
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      "lib/assets/icons/arrow_back_gray_small.png",
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 60.0),
                decoration: BoxDecoration(
                  borderRadius: AppStyles.borderRadiusAll,
                  color: AppColor.fontColorPrimary.withOpacity(0.05),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          Text(eventList[index].month).data!,
                          style: AppFonts.smallLightText,
                        ),
                        Text(
                          Text(eventList[index].date).data!,
                          style: AppFonts.smallLightText,
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 40,
                      width: 0.8,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Text(eventList[index].day).data!,
                          style: AppFonts.smallLightText,
                        ),
                        Text(
                          Text(eventList[index].time).data!,
                          style: AppFonts.smallLightText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 50.0),
                decoration: BoxDecoration(
                  borderRadius: AppStyles.borderRadiusAll,
                  color: AppColor.fontColorPrimary.withOpacity(0.05),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Why You Should Join This Event",
                          style: AppFonts.normalRegularText,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    ...eventList[index].eventHighlights.map((highlight) {
                      return Text(
                        highlight,
                        style: AppFonts.extraSmallLightText,
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return PhotoCard(
                    eventList: eventList,
                    index: i,
                    eventImage: eventList[index].eventImages[i],
                  );
                },
                itemCount: eventList[index].eventImages.length,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DefaultButton(
                press: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppColor.fontColorSecondary,
                        scrollable: true,
                        title: Text(
                          'Event Reminder',
                          style: AppFonts.largeMediumText,
                        ),
                        content: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reminder has been set for you.'),
                            Text('You will get notified before the event.')
                          ],
                        ),
                        actions: [
                          DefaultButton(
                            backgroundColor: AppColor.btnColorPrimary,
                            text: "Okay",
                            height: 30,
                            fontStyle: AppFonts.smallLightTextWhite,
                            width: double.infinity,
                            padding: EdgeInsets.zero,
                            press: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                text: "Remind Me",
                backgroundColor: AppColor.btnColorPrimary,
                height: 40,
                fontStyle: AppFonts.normalRegularTextWhite,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
