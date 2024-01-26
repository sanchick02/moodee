import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/screens/auth/auth_screen.dart';
import 'package:rive/rive.dart' as rive;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
          const rive.RiveAnimation.asset(
            "lib/assets/rive/emoji_bubbles.riv",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 500),
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Text(
                      "Your well-being matters.",
                      style: AppFonts.smallRegularText,
                    ),
                  ),
                  Image.asset(
                    "lib/assets/images/Logo.png",
                    width: 250,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              navigateNextPage(context, const AuthScreen());
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 86,
                decoration: BoxDecoration(
                  // gradient: greenBlueGradient(),
                  color: AppColor.btnColorPrimary,
                  borderRadius: AppStyles.borderRadiusTop,
                  boxShadow: [
                    AppShadow.innerShadow1,
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Explore moodee",
                        style: AppFonts.largeMediumTextWhite,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconButton(
                        onPressed: () {
                          navigateNextPage(context, const AuthScreen());
                        },
                        icon: Image.asset(
                          "lib/assets/icons/arrow_next_white_big.png",
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
