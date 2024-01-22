import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:moodee/data/forum_channels.dart';
import 'package:moodee/data/forum_moodeeBoard.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/community_widgets/community_buttons.dart';
import 'package:moodee/widgets/community_widgets/forum_channel_card.dart';
import 'package:moodee/widgets/community_widgets/forum_moodeeBoard_card.dart';
import 'package:moodee/nav_bar.dart';
import 'package:moodee/widgets/screen_title.dart';

import 'package:moodee/widgets/topbar_logo_notif.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({
    super.key,
  });

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String selectedCategory = "All";
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 3,
        onDestinationSelected: (index) {
          navbarNavigation(context, 3, index);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopBarLogoNotif(),
              const ScreenTitle(title: "Community"),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        filterButton("All", 90, isSelected = true, (category) {
                          setState(() {
                            selectedCategory = category;
                          });
                        }, selectedCategory),
                        filterButton("Forum Channels", 140, isSelected = false,
                            (category) {
                          setState(() {
                            selectedCategory = category;
                          });
                        }, selectedCategory),
                        filterButton("moodeeBoard", 120, isSelected = false,
                            (category) {
                          setState(() {
                            selectedCategory = category;
                          });
                        }, selectedCategory),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (selectedCategory == "Forum Channels") ...[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 3, bottom: 13),
                      child: Row(
                        children: [
                          Text(
                            "Forum Channels",
                            style: AppFonts.normalRegularText,
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: forumChannelList.asMap().entries.map((entry) {
                        final index = entry.key;
                        final isLastItem = index == forumChannelList.length - 1;
                        return ForumChannelCard(
                          margin: EdgeInsets.only(
                              top: 5, bottom: isLastItem ? 10 : 5),
                          index: index,
                        );
                      }).toList(),
                    ),
                  ] else if (selectedCategory == "moodeeBoard") ...[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 3, bottom: 13),
                      child: Row(
                        children: [
                          Text(
                            "moodeeBoard",
                            style: AppFonts.normalRegularText,
                          )
                        ],
                      ),
                    ),
                    Column(
                      children:
                          forumMoodeeBoardList.asMap().entries.map((entry) {
                        final index = entry.key;
                        final isLastItem =
                            index == forumMoodeeBoardList.length - 1;
                        return ForumMoodeeBoardCard(
                          margin: EdgeInsets.only(
                              top: 5, bottom: isLastItem ? 10 : 5),
                          index: index,
                        );
                      }).toList(),
                    ),
                  ] else if (selectedCategory == "All") ...[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15),
                      child: Row(
                        children: [
                          Text(
                            "Forum Channels",
                            style: AppFonts.normalRegularText,
                          ),
                          const Spacer(),
                          seeAllButton(
                            "Forum Channels",
                            (category) {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            selectedCategory,
                            (category) {
                              return Column(
                                children: List.generate(
                                  forumChannelList.length,
                                  (index) => ForumChannelCard(
                                    index: index,
                                    margin: EdgeInsets.only(
                                      left: 15,
                                      right:
                                          index == forumChannelList.length - 1
                                              ? 15
                                              : 0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          forumChannelList.length,
                          (index) => ForumChannelCard(
                            index: index,
                            margin: EdgeInsets.only(
                                left: 15,
                                right: index == forumChannelList.length - 1
                                    ? 15
                                    : 0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15),
                      child: Row(children: [
                        Text(
                          "moodeeBoard",
                          style: AppFonts.normalRegularText,
                        ),
                        const Spacer(),
                        seeAllButton(
                          "moodeeBoard",
                          (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          selectedCategory,
                          (category) {
                            return Column(
                              children: List.generate(
                                forumChannelList.length,
                                (index) => ForumChannelCard(
                                  index: index,
                                  margin: EdgeInsets.only(
                                    left: 15,
                                    right: index == forumChannelList.length - 1
                                        ? 15
                                        : 0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ]),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            forumMoodeeBoardList.length,
                            (index) => ForumMoodeeBoardCard(
                              index: index,
                              margin: EdgeInsets.only(
                                  left: 15,
                                  right:
                                      index == forumMoodeeBoardList.length - 1
                                          ? 15
                                          : 0),
                            ),
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
}
