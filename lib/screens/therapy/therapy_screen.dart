import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/therapy/therapy_filtered.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/nav_bar.dart';
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
      // bottomNavigationBar: CustomNavigationBar(
      //   selectedIndex: 1,
      //   onDestinationSelected: (index) {
      //     navbarNavigation(context, 1, index);
      //   },
      // ),
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
                    Expanded(
                        flex: 2, child: filterButton("All", isSelected = true)),
                    SizedBox(width: 10),
                    Expanded(
                        flex: 3,
                        child: filterButton("Meditation", isSelected = false)),
                    SizedBox(width: 10),
                    Expanded(
                        flex: 2,
                        child: filterButton("Music", isSelected = false)),
                    SizedBox(width: 10),
                    Expanded(
                        flex: 2,
                        child: filterButton("Stories", isSelected = false)),
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
                        children: List.generate(
                          meditationList.length,
                          (index) => TherapyCard(
                            meditationList[index],
                            mediaItem: meditationList[index],
                            margin: EdgeInsets.only(
                              left: 15,
                              right:
                                  index == meditationList.length - 1 ? 15 : 0,
                            ),
                          ),
                        ),
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
                        children: List.generate(
                          musicList.length,
                          (index) => TherapyCard(
                            musicList[index],
                            mediaItem: musicList[index],
                            margin: EdgeInsets.only(
                              left: 15,
                              right: index == musicList.length - 1 ? 15 : 0,
                            ),
                          ),
                        ),
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
                        children: List.generate(
                          storyList.length,
                          (index) => TherapyCard(
                            storyList[index],
                            mediaItem: storyList[index],
                            margin: EdgeInsets.only(
                              left: 15,
                              right: index == storyList.length - 1 ? 15 : 0,
                            ),
                          ),
                        ),
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

  Widget filterButton(String category, bool isSelected) {
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
        width: 50,
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
