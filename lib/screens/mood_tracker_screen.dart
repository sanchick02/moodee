import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/widgets/button.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/assets/images/meshGrad1.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Mood Tracker",
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 120),
                Text(
                  "Track Your Mood",
                  style: AppFonts.heading3,
                ),
                Text(
                  "Look into the camera and hold still",
                  style: AppFonts.smallLightText,
                ),
                const SizedBox(height: 30),
                ClipOval(
                  child: Image.asset(
                    "lib/assets/images/face1.jpg",
                    width: 240,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(left: 30),
                      width: 140,
                      height: 155,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Happy:",
                                style: AppFonts.smallLightText,
                              ),
                              Text(
                                "100%",
                                style: AppFonts.smallLightText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Surprise:",
                                style: AppFonts.smallLightText,
                              ),
                              Text(
                                "0%",
                                style: AppFonts.smallLightText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Angry:",
                                style: AppFonts.smallLightText,
                              ),
                              Text(
                                "0%",
                                style: AppFonts.smallLightText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sad:",
                                style: AppFonts.smallLightText,
                              ),
                              Text(
                                "0%",
                                style: AppFonts.smallLightText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Neutral:",
                                style: AppFonts.smallLightText,
                              ),
                              Text(
                                "0%",
                                style: AppFonts.smallLightText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Column(
                        children: [
                          Text(
                            "Your Mood Right Now",
                            style: AppFonts.normalRegularText,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            color: AppColor.fontColorPrimary,
                            width: 190,
                            height: 0.8,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 190,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "lib/assets/images/emojiHappy.png",
                                  width: 100,
                                ),
                                Text(
                                  "HAPPY",
                                  style: AppFonts.largeMediumText,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: DefaultButton(
                    press: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    text: "Done",
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
          )
        ],
      ),
    );
  }
}
