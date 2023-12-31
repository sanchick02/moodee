import 'package:flutter/material.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/screens/therapist/therapist_all.dart';
import 'package:moodee/widgets/nav_bar.dart';
import 'package:moodee/widgets/screen_title.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';

class TherapistScreen extends StatelessWidget {
  const TherapistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (index) {
          navbarNavigation(context, index);
        },
      ),
      body: const SingleChildScrollView(
        child: Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            children: [
              TopBarLogoNotif(),
              ScreenTitle(title: "Therapist"),
              SizedBox(height: 15),
              TherapistAll(),
            ],
          ),
        ),
      ),
    );
  }
}
