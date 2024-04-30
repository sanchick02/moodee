import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/forum_channels.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/screens/community/create_post_screen.dart';
import 'package:moodee/widgets/community_widgets/forum_list_.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/providers/forum_post_provider.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/widgets/community_widgets/community_buttons.dart';
import 'package:moodee/widgets/community_widgets/forum_channel_card.dart';
import 'package:moodee/widgets/screen_title.dart';
import 'package:moodee/models/forum.dart';
import 'package:moodee/presets/shadow.dart';

import 'package:moodee/widgets/topbar_logo_notif.dart';
import 'package:provider/provider.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({
    super.key,
  });

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String selectedCategory = "Community";
  bool isSelected = false;
  bool isSelectedPollAnswer1 = false;
  bool isSelectedPollAnswer2 = false;
  bool isSelectedPollAnswer3 = false;
  bool isSelectedPollAnswer4 = false;

  final List<ForumPost> _registeredExpenses = [
    ForumPost(
        uid: '',
        pid: '',
        userImage: '',
        userName: '',
        time: '',
        caption: '',
        postImage: '',
        likes: 0),
  ];

  @override
  void initState() {
    Provider.of<ForumProvider>(context, listen: false)
        .fetchUserData()
        .then((_) {
      setState(() {
        _registeredExpenses;
        // Sorting logic based on the time attribute
        // _registeredExpenses.sort((a, b) => b.time.compareTo(a.time));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<UserProvider>(context);

    Widget mainContent = const Center(
      child: Text('No posts found, start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = const ForumLists();
    }
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopBarLogoNotif(),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: ScreenTitle(title: "Community"),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: filterButton("Community", isSelected = true,
                              (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          }, selectedCategory),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: filterButton("moodeeHouse", isSelected = false,
                              (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          }, selectedCategory),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: filterButton("moodeeBoard", isSelected = false,
                              (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          }, selectedCategory),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (selectedCategory == "moodeeHouse") ...[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 3, bottom: 13),
                      child: Row(
                        children: [
                          Text(
                            "moodeeHouse",
                            style: AppFonts.largeMediumText,
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 3, bottom: 13),
                          child: Row(
                            children: [
                              Text(
                                "moodeeBoard",
                                style: AppFonts.largeMediumText,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => navigateNextPage(context,
                              const CreatePostScreen()), // change to create post!
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 5),
                            width: double.infinity,
                            constraints: const BoxConstraints(
                                minHeight: 80,
                                maxHeight: 100), // ADJUST LATER!!
                            decoration: BoxDecoration(
                              color: AppColor.fontColorSecondary,
                              borderRadius: AppStyles.borderRadiusAll,
                              boxShadow: [
                                AppShadow.innerShadow3,
                                AppShadow.innerShadow4,
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: SizedBox(
                                      child: _provider
                                                  .userProviderData!.imageURL !=
                                              ''
                                          ? Image.network(
                                              _provider
                                                  .userProviderData!.imageURL
                                                  .toString(),
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "lib/assets/images/userAnon.png",
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Share your thoughts here...",
                                            style: AppFonts.smallLightText,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: AppColor.fontColorPrimary
                                                .withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        mainContent
                      ],
                    ),
                  ] else if (selectedCategory == "Community") ...[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 30,
                            child: Text(
                              "Every Voice Matters: Stories of Hope",
                              style: AppFonts.normalRegularText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildSuccessStoryWidget(context),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15),
                      child: Row(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: Text(
                            "Daily Poll: Feeling Okay?",
                            style: AppFonts.normalRegularText,
                          ),
                        ),
                      ]),
                    ),
                    buildDailyPollWidget(),
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

  Container buildSuccessStoryWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        color: AppColor.btnColorSecondary,
        boxShadow: [AppShadow.innerShadow3],
        borderRadius: AppStyles.borderRadiusAll,
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 280,
                decoration: BoxDecoration(
                  boxShadow: [AppShadow.innerShadow3],
                  borderRadius: AppStyles.borderRadiusAll,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Image.asset(
                    "lib/assets/images/claudias-part_branch/successtory.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff252525).withOpacity(0.4),
                  boxShadow: [AppShadow.innerShadow3],
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Emily's Story",
                      style: AppFonts.smallLightTextWhite,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 280,
            padding: const EdgeInsets.all(20),
            child: Text(
              """\"It's taken most of my life to learn I am worthy of living.
                        
You are not too broken to get better.
You are not a failure for wanting help.
And you are not alone.\"""",
              style: AppFonts.smallLightText,
            ),
          )
        ],
      ),
    );
  }

  Container buildDailyPollWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
        color: AppColor.btnColorSecondary,
        borderRadius: AppStyles.borderRadiusAll,
        boxShadow: [AppShadow.innerShadow3],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                "lib/assets/images/claudias-part_branch/poll.png",
                width: 35,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Poll from Dr. Sheryl",
                style: AppFonts.normalRegularText,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 35),
            decoration: BoxDecoration(
              color: const Color(0xff252525).withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              "☺️ When was the last time you felt genuinely happy?",
              style: AppFonts.smallLightText,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSelectedPollAnswer1 = !isSelectedPollAnswer1;
                isSelectedPollAnswer2 = false;
                isSelectedPollAnswer3 = false;
                isSelectedPollAnswer4 = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 35),
              decoration: BoxDecoration(
                color: const Color(0xff252525).withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: isSelectedPollAnswer1
                          ? AppColor.btnColorPrimary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelectedPollAnswer1
                            ? AppColor.btnColorPrimary
                            : Colors.black, // Border color
                        width: 1, // Border width
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Today",
                    style: AppFonts.smallLightText,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSelectedPollAnswer2 = !isSelectedPollAnswer2;
                isSelectedPollAnswer1 = false;
                isSelectedPollAnswer3 = false;
                isSelectedPollAnswer4 = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 35),
              decoration: BoxDecoration(
                color: const Color(0xff252525).withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: isSelectedPollAnswer2
                          ? AppColor.btnColorPrimary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelectedPollAnswer2
                            ? AppColor.btnColorPrimary
                            : Colors.black, // Border color
                        width: 1, // Border width
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "The past week",
                    style: AppFonts.smallLightText,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSelectedPollAnswer3 = !isSelectedPollAnswer3;
                isSelectedPollAnswer1 = false;
                isSelectedPollAnswer2 = false;
                isSelectedPollAnswer4 = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 35),
              decoration: BoxDecoration(
                color: const Color(0xff252525).withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: isSelectedPollAnswer3
                          ? AppColor.btnColorPrimary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelectedPollAnswer3
                            ? AppColor.btnColorPrimary
                            : Colors.black, // Border color
                        width: 1, // Border width
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "The past month",
                    style: AppFonts.smallLightText,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSelectedPollAnswer4 = !isSelectedPollAnswer4;
                isSelectedPollAnswer1 = false;
                isSelectedPollAnswer2 = false;
                isSelectedPollAnswer3 = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 35),
              decoration: BoxDecoration(
                color: const Color(0xff252525).withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: isSelectedPollAnswer4
                          ? AppColor.btnColorPrimary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelectedPollAnswer4
                            ? AppColor.btnColorPrimary
                            : Colors.black, // Border color
                        width: 1, // Border width
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "I don't remember",
                    style: AppFonts.smallLightText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
