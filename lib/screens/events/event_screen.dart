// JUST FOR TESTING
import 'package:flutter/material.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/screens/events/events_All.dart';
import 'package:moodee/nav_bar.dart';
import 'package:moodee/widgets/screen_title.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (index) {
          navbarNavigation(context, 1, index);
        },
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBarLogoNotif(),
              ScreenTitle(title: "Events Nearby"),
              SizedBox(height: 15),
              EventsAll(),
            ],
          ),
        ),
      ),
    );
  }
}
