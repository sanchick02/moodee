import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class ProgressBox extends StatelessWidget {
  const ProgressBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.3,
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          AppShadow.innerShadow3,
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "lib/assets/images/Logo.png",
                          width: MediaQuery.of(context).size.width * 0.17,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Streak",
                          style: AppFonts.smallRegularText,
                        ),
                      ],
                    ),
                    Text(
                      "You are doing better than 74% of people.",
                      style: AppFonts.extraSmallLightText,
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "28",
                        style: AppFonts.smallLightText,
                      ),
                      Text(
                        "days",
                        style: AppFonts.extraSmallLightText,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      backgroundColor: const Color(0xff252525).withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColor.btnColorPrimary,
                      ),
                      // backgroundColor: Colors.transparent,
                      value: 28 / 31,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
