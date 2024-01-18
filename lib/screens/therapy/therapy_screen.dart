import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/therapy/therapy_filtered.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/nav_bar.dart';
import 'package:moodee/widgets/screen_title.dart';
import 'package:moodee/widgets/therapy_widgets/therapy_card.dart';

import 'package:moodee/widgets/topbar_logo_notif.dart';

class TherapyScreen extends StatefulWidget {
  const TherapyScreen({
    super.key,
    // required this.mediaList,
    required this.mediaItem,
  });
  // T mediaItem;
  final MediaItem mediaItem;
  // final List<MediaList> mediaList;

  @override
  State<TherapyScreen> createState() => _TherapyScreenState();
}

class _TherapyScreenState extends State<TherapyScreen> {
  String selectedCategory = "All";
  bool isSelected = false;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopBarLogoNotif(),
              const ScreenTitle(title: "Therapy"),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 30, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    filterButton("All", 70, isSelected = true),
                    filterButton("Meditation", 100, isSelected = false),
                    filterButton("Music", 90, isSelected = false),
                    filterButton("Stories", 90, isSelected = false),
                  ],
                ),
              ),
              Column(
                children: [
                  if (selectedCategory == "Meditation") ...[
                    TherapyFiltered(
                      mediaItem: meditationList[0],
                      index: 0,
                    )
                  ] else if (selectedCategory == "Music") ...[
                    // Widget for "Therapy2" category
                    TherapyFiltered(
                      mediaItem: musicList[0],
                      index: 0,
                    )
                  ] else if (selectedCategory == "Stories") ...[
                    // Widget for "Therapy2" category
                    TherapyFiltered(
                      mediaItem: storyList[0],
                      index: 0,
                    )
                  ] else if (selectedCategory == "All") ...[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15),
                      child: Row(
                        children: [
                          Text(
                            "Featured Meditation",
                            style: AppFonts.normalRegularText,
                          ),
                          const Spacer(),
                          seeAllButton("Meditation"),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TherapyCard(
                            meditationList[0],
                            mediaItem: meditationList[0],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            meditationList[1],
                            mediaItem: meditationList[1],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            meditationList[2],
                            mediaItem: meditationList[2],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            meditationList[3],
                            mediaItem: meditationList[3],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            meditationList[4],
                            mediaItem: meditationList[4],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            meditationList[5],
                            mediaItem: meditationList[5],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            meditationList[6],
                            mediaItem: meditationList[6],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            meditationList[7],
                            mediaItem: meditationList[7],
                            margin: const EdgeInsets.only(left: 15, right: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15),
                      child: Row(
                        children: [
                          Text(
                            "Featured Music",
                            style: AppFonts.normalRegularText,
                          ),
                          const Spacer(),
                          seeAllButton("Music"),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TherapyCard(
                            musicList[0],
                            mediaItem: musicList[0],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            musicList[1],
                            mediaItem: musicList[1],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            musicList[2],
                            mediaItem: musicList[2],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            musicList[3],
                            mediaItem: musicList[3],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            musicList[4],
                            mediaItem: musicList[4],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            musicList[5],
                            mediaItem: musicList[5],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            musicList[6],
                            mediaItem: musicList[6],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            musicList[7],
                            mediaItem: musicList[7],
                            margin: const EdgeInsets.only(left: 15, right: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15),
                      child: Row(
                        children: [
                          Text(
                            "Featured Stories",
                            style: AppFonts.normalRegularText,
                          ),
                          const Spacer(),
                          seeAllButton("Stories"),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TherapyCard(
                            storyList[0],
                            mediaItem: storyList[0],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            storyList[1],
                            mediaItem: storyList[1],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            storyList[2],
                            mediaItem: storyList[2],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            storyList[3],
                            mediaItem: storyList[3],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            storyList[4],
                            mediaItem: storyList[4],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            storyList[5],
                            mediaItem: storyList[5],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            storyList[6],
                            mediaItem: storyList[6],
                            margin: const EdgeInsets.only(left: 15),
                          ),
                          TherapyCard(
                            storyList[7],
                            mediaItem: storyList[7],
                            margin: const EdgeInsets.only(left: 15, right: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterButton(String category, double width, bool isSelected) {
    bool isSelected = category == selectedCategory;

    return DefaultButton(
        text: category,
        press: () {
          setState(() {
            selectedCategory = category;
          });
        },
        backgroundColor:
            isSelected ? AppColor.btnColorPrimary : AppColor.btnColorSecondary,
        height: 35,
        fontStyle:
            isSelected ? AppFonts.smallLightTextWhite : AppFonts.smallLightText,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8));
  }

  Widget seeAllButton(String category) {
    category == selectedCategory;

    return DefaultButton(
        text: "See All",
        press: () {
          setState(() {
            selectedCategory = category;
          });
        },
        backgroundColor: AppColor.btnColorPrimary,
        height: 35,
        fontStyle: AppFonts.smallLightTextWhite,
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8));
  }
}
