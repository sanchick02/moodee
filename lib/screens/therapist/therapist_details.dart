import 'package:flutter/material.dart';
import 'package:moodee/call_page.dart';
import 'package:moodee/chat_screen.dart';
import 'package:moodee/models/therapists_model.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/screens/prev_chat_screen.dart';
import 'package:moodee/widgets/therapist_widgets/therapist_availability_rows.dart';
import 'package:moodee/widgets/button.dart';

class TherapistDetailsScreen extends StatelessWidget {
  const TherapistDetailsScreen({
    Key? key,
    required this.index,
    required this.therapistList,
  }) : super(key: key);

  final List<Therapist> therapistList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "lib/assets/images/meshGrad1.png",
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 300,
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              Text(therapistList[index].name).data!,
                              style: AppFonts.heading3,
                            ),
                            Text(
                              Text(therapistList[index].title).data!,
                              style: AppFonts.normalRegularText,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "lib/assets/icons/Rating.png",
                                  width: 12,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  therapistList[index].rating.toString(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                DefaultButton(
                                  text: "Call",
                                  press: () {
                                    navigateNextPage(context, const CallPage());
                                  },
                                  backgroundColor: AppColor.btnColorPrimary,
                                  height: 25,
                                  fontStyle: AppFonts.extraSmallLightTextWhite,
                                  width: 75,
                                  padding: EdgeInsets.zero,
                                ),
                                const SizedBox(width: 5),
                                DefaultButton(
                                  text: "Message",
                                  press: () {
                                    navigateNextPage(
                                        context, const ChatScreen1());
                                  },
                                  backgroundColor: AppColor.btnColorPrimary,
                                  height: 25,
                                  fontStyle: AppFonts.extraSmallLightTextWhite,
                                  width: 75,
                                  padding: EdgeInsets.zero,
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      alignment: Alignment.bottomCenter,
                      constraints:
                          const BoxConstraints(maxWidth: 170, maxHeight: 300),
                      child: Image.asset(
                        therapistList[index].image,
                      ),
                    ),
                  ],
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    "Therapist Booking",
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
                constraints: BoxConstraints(minHeight: 210),
                decoration: BoxDecoration(
                  borderRadius: AppStyles.borderRadiusAll,
                  color: AppColor.fontColorPrimary.withOpacity(0.05),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Achievements",
                          style: AppFonts.normalRegularText,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          therapistList[index].achievements.map((achievement) {
                        return Text(
                          achievement,
                          style: AppFonts.extraSmallLightText,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
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
                child: Column(
                  children: [
                    Text(
                      "Availability for Consultation",
                      style: AppFonts.normalRegularText,
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: [
                        AvailabilityRows(
                          availabilityList: therapistList[index].availability,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
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
                          'Therapist Consultation Reminder',
                          style: AppFonts.largeMediumText,
                        ),
                        content: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reminder has been set for you.'),
                            Text(
                                'You will get notified before the consultation through notifications.')
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
                text: "Book Consultation",
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
          ],
        ),
      ),
    );
  }
}
