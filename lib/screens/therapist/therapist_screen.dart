import 'package:flutter/material.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/widgets/therapist_widgets/therapist_all.dart';
import 'package:moodee/widgets/nav_bar.dart';
import 'package:moodee/widgets/screen_title.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';

class TherapistScreen extends StatelessWidget {
  const TherapistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBarLogoNotif(),
              Row(
                children: [
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      "lib/assets/icons/arrow_back_gray_small.png",
                      width: 30,
                    ),
                  ),
                  ScreenTitle(title: "Therapist"),
                ],
              ),
              SizedBox(height: 15),
              TherapistAll(),
            ],
          ),
        ),
      ),
    );
  }
}
