// JUST FOR TESTING
import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/screens/events/events_All.dart';
import 'package:moodee/widgets/screen_title.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopBarLogoNotif(),
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
                  const ScreenTitle(title: "Events Nearby"),
                ],
              ),
              const SizedBox(height: 15),
              const EventsAll(),
            ],
          ),
        ),
      ),
    );
  }
}
