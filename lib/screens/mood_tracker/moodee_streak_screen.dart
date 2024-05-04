import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/button.dart';

class MoodeeStreakScreen extends StatelessWidget {
  const MoodeeStreakScreen({super.key});

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
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Row(
                    children: [
                      Image.asset(
                        "lib/assets/images/Logo.png",
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Streak",
                        style: AppFonts.normalRegularText,
                      ),
                    ],
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
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Keep It Up.",
                      style: AppFonts.heading3,
                    ),
                    Text(
                      "You’re better than 74% of people.",
                      style: AppFonts.normalRegularText,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "lib/assets/images/claudia_therapist_branch/bubble.png",
                              width: MediaQuery.of(context).size.width / 1.8,
                            ),
                            Column(
                              children: [
                                Text(
                                  "28",
                                  style: TextStyle(
                                    fontFamily: "LeagueSpartan",
                                    fontSize:
                                        MediaQuery.of(context).size.width / 4.5,
                                    fontWeight: FontWeight.w700, // heading 1
                                    color: AppColor.fontColorPrimary,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  "days",
                                  style: AppFonts.heading3Height,
                                )
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          "lib/assets/images/claudia_therapist_branch/emojis.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DefaultButton(
                    press: () {},
                    text: "View Mood Report",
                    backgroundColor: AppColor.btnColorPrimary,
                    height: 55,
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
        ],
      ),
    );
  }
}
