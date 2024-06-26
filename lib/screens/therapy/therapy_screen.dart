import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/therapy/therapy_filtered.dart';
import 'package:moodee/widgets/button.dart';
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
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

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
                  const ScreenTitle(title: "Therapy"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 30, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 2, child: filterButton("All", isSelected = true)),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 3,
                        child: filterButton("Meditation", isSelected = false)),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 2,
                        child: filterButton("Relax", isSelected = false)),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 2,
                        child: filterButton("Sleep", isSelected = false)),
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
                  ] else if (selectedCategory == "Relax") ...[
                    // Widget for "Therapy2" category
                    TherapyFiltered(
                      mediaItem: musicList[0],
                      index: 0,
                    )
                  ] else if (selectedCategory == "Sleep") ...[
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
                            "Meditation",
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
                            image: meditationList[index].image,
                            title: meditationList[index].title,
                            singerOrAuthor: meditationList[index].singerOrAuthor,
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
                            "Relax",
                            style: AppFonts.normalRegularText,
                          ),
                          const Spacer(),
                          seeAllButton("Relax"),
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
                            image: musicList[index].image,
                            title: musicList[index].title,
                            singerOrAuthor: musicList[index].singerOrAuthor,
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
                            "Sleep",
                            style: AppFonts.normalRegularText,
                          ),
                          const Spacer(),
                          seeAllButton("Sleep"),
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
                            image: storyList[index].image,
                            title: storyList[index].title,
                            singerOrAuthor: storyList[index].singerOrAuthor,
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
