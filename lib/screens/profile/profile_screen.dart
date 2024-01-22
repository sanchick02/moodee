import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/screens/profile/calendar_screen.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/divider_line.dart';
import 'package:moodee/widgets/nav_bar.dart';
import 'package:moodee/widgets/profile_widgets/daily_mood_checkin.dart';
import 'package:moodee/widgets/toggle_switch.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final DateTime? _selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 4,
        onDestinationSelected: (index) {
          navbarNavigation(context, 4, index);
        },
      ),
      body: Container(
        color: AppColor.fontColorSecondary,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: AppColor.backgroundColor,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: AppColor.fontColorSecondary,
                          boxShadow: [
                            AppShadow.innerShadow3,
                            AppShadow.innerShadow4
                          ],
                        ),
                      ),
                      const TopBarLogoNotif(),
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 50),
                        height: 180,
                        child: Text(
                          "Profile",
                          style: AppFonts.largeMediumText,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                "lib/assets/images/face1.jpg",
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      children: [
                        Text(
                          "Evelyn Smith",
                          style: AppFonts.largeMediumText,
                        ),
                        Text(
                          "Age: 24",
                          style: AppFonts.smallLightText,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Learning, growing, and taking it one day at a time.",
                          style: AppFonts.extraSmallLightText,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultButton(
                              text: "Edit Profile",
                              press: () {},
                              backgroundColor: AppColor.btnColorPrimary,
                              height: 25,
                              fontStyle: AppFonts.extraSmallLightTextWhite,
                              width: 100,
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(width: 15),
                            DefaultButton(
                              text: "Delete Profile",
                              press: () {},
                              backgroundColor: AppColor.btnColorPrimary,
                              height: 25,
                              fontStyle: AppFonts.extraSmallLightTextWhite,
                              width: 100,
                              padding: EdgeInsets.zero,
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          constraints: const BoxConstraints(minHeight: 50),
                          decoration: BoxDecoration(
                            color: AppColor.fontColorSecondary,
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [
                              AppShadow.innerShadow3,
                              AppShadow.innerShadow4
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daily Mood Check-In",
                                style: AppFonts.normalRegularText,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DailyMoodCheckIn(
                                    day: "Mon",
                                    image: "lib/assets/images/emojiHappy.png",
                                  ),
                                  DailyMoodCheckIn(
                                    day: "Tue",
                                    image: "lib/assets/images/emojiHappy.png",
                                  ),
                                  DailyMoodCheckIn(
                                    day: "Wed",
                                    image: "lib/assets/images/emojiHappy.png",
                                  ),
                                  DailyMoodCheckIn(
                                    day: "Thu",
                                    image: '',
                                  ),
                                  DailyMoodCheckIn(
                                    day: "Fri",
                                  ),
                                  DailyMoodCheckIn(
                                    day: "Sat",
                                  ),
                                  DailyMoodCheckIn(
                                    day: "Sun",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () =>
                              navigateNextPage(context, CalendarScreen()),
                          child: _buildCustomCalendar(),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(minHeight: 100),
                          decoration: BoxDecoration(
                            color: AppColor.fontColorSecondary,
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [
                              AppShadow.innerShadow3,
                              AppShadow.innerShadow4
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text(
                                  "Profile Settings",
                                  style: AppFonts.normalRegularText,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: DividerLine(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Push notifications",
                                      style: AppFonts.smallLightText,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: ToggleSwitch(
                                      onToggle: (bool) {},
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Location Services",
                                      style: AppFonts.smallLightText,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: ToggleSwitch(
                                      onToggle: (bool) {},
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Camera Access",
                                      style: AppFonts.smallLightText,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: ToggleSwitch(
                                      onToggle: (bool) {},
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Change Password",
                                      style: AppFonts.smallLightText,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "lib/assets/icons/arrow_next_gray_small.png",
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                      ),
                                      child: Text(
                                        "Privacy Policy",
                                        style: AppFonts.smallLightText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Image.asset(
                                          "lib/assets/icons/arrow_next_gray_small.png",
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCustomCalendar() {
  return Column(
    children: [
      Container(
        width: double.infinity,
        height: 350,
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
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2024, 01, 01),
              lastDay: DateTime.utc(2025, 12, 31),
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
            ),
          ],
        ),
      ),
    ],
  );
}
