import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/auth_widget_tree.dart';
import 'package:moodee/nav_bar.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/screens/profile/calendar_screen.dart';
import 'package:moodee/services/database.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/divider_line.dart';
import 'package:moodee/widgets/profile_widgets/calendar_widget.dart';
import 'package:moodee/widgets/profile_widgets/daily_mood_checkin.dart';
import 'package:moodee/widgets/toggle_switch.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DateTime? _selectedDay = DateTime.now();
  File? _pickedImageFile; // Move it here

  void _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AuthWidgetTree()),
        ));
  }

  DateTime _normalizeDateTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  // To store the events created
  Map<DateTime?, List<String>> _remindersMap = {};
  List<String> reminders = [];

  Future<void> _fetchRemindersFromFirebase() async {
    try {
      Map<DateTime?, List<String>> remindersFromFirebase =
          await DatabaseService().fetchReminders();

      print("Selected Day: $_selectedDay");
      print("Reminders from Firebase: $remindersFromFirebase");

      setState(() {
        _remindersMap = remindersFromFirebase;
        reminders = _remindersMap[_selectedDay] ?? [];
        print("Updated reminders: $reminders");
      });
    } catch (e) {
      print("Error fetching reminders: $e");
      // Handle the error as needed
    }
  }

  void _pickedImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_profile_image')
        .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

    await storageRef.putFile(File(pickedImage.path));

    final imageURL = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'profileImageURL': imageURL});

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  void initState() {
    super.initState();

    // Fetch reminders from Firebase when the screen is initialized
    _fetchRemindersFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        color: AppColor.backgroundColor,
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
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                ClipOval(
                                  child: provider.userProviderData!.imageURL !=
                                          ''
                                      ? Image.network(
                                          provider.userProviderData!.imageURL
                                              .toString(),
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "lib/assets/images/userAnon.png",
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                // if (provider.userProviderData!.imageURL == '')
                                  // Material(
                                  //   color: AppColor.fontColorPrimary,
                                  //   borderRadius: BorderRadius.circular(999),
                                  //   child: IconButton(
                                  //     onPressed: () {
                                  //       _pickedImage();
                                  //     },
                                  //     icon: const Icon(Icons.camera_alt),
                                  //     color: AppColor.btnColorSecondary,
                                  //   ),
                                  // ),
                              ],
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
                          "${provider.userProviderData!.firstName} ${provider.userProviderData!.lastName}",
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
                              height: 30,
                              fontStyle: AppFonts.smallLightTextWhite,
                              width: 120,
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(width: 10),
                            DefaultButton(
                              text: "Sign Out", // CHANGED THIS
                              press: () {
                                _signOut();
                              },
                              backgroundColor: AppColor.btnColorPrimary,
                              height: 30,
                              fontStyle: AppFonts.smallLightTextWhite,
                              width: 120,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DailyMoodCheckIn(
                                      day: "Mon",
                                      image: "lib/assets/images/emojiHappy.png",
                                    ),
                                  ),
                                  Expanded(
                                    child: DailyMoodCheckIn(
                                      day: "Tue",
                                      image: "lib/assets/images/emojiHappy.png",
                                    ),
                                  ),
                                  Expanded(
                                    child: DailyMoodCheckIn(
                                      day: "Wed",
                                      image: "lib/assets/images/emojiHappy.png",
                                    ),
                                  ),
                                  Expanded(
                                    child: DailyMoodCheckIn(
                                      day: "Thu",
                                      image: '',
                                    ),
                                  ),
                                  Expanded(
                                    child: DailyMoodCheckIn(
                                      day: "Fri",
                                    ),
                                  ),
                                  Expanded(
                                    child: DailyMoodCheckIn(
                                      day: "Sat",
                                    ),
                                  ),
                                  Expanded(
                                    child: DailyMoodCheckIn(
                                      day: "Sun",
                                    ),
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
                eventLoader: (day) {
                  DateTime normalizedDay = _normalizeDateTime(day);
                  return _remindersMap[normalizedDay] ?? [];
                },
                calendarStyle: CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: AppColor.btnColorPrimary,
                    shape: BoxShape.circle,
                  ),
                  markerMargin: const EdgeInsets.symmetric(
                    horizontal: 0.5,
                    vertical: 5.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
