import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/forum_channels.dart';
import 'package:moodee/data/forum_moodeeBoard.dart';
import 'package:moodee/forum_list_.dart';
import 'package:moodee/new_forum.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/providers/forum_post_provider.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/widgets/community_widgets/community_buttons.dart';
import 'package:moodee/widgets/community_widgets/forum_channel_card.dart';
import 'package:moodee/widgets/community_widgets/forum_moodeeBoard_card.dart';
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
  String selectedCategory = "All";
  bool isSelected = false;

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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        backgroundColor: AppColor.fontColorSecondary,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              boxShadow: [
                AppShadow.innerShadow3,
                AppShadow.innerShadow4,
              ],
              borderRadius: AppStyles.borderRadiusTop,
            ), // Set the desired height
            child: NewForum(
              onAddExpense: _addExpense,
            ),
          );
        }); //ctx also is a context
  }

  void _addExpense(ForumPost forumPost) {
    setState(() {
      _registeredExpenses.add(forumPost);
      // use time to sort
      _registeredExpenses.sort((a, b) => b.time.compareTo(a.time));
    });
  }

  void _removeExpense(ForumPost forumPost) {
    final expenseIndex = _registeredExpenses.indexOf(forumPost);
    _registeredExpenses.remove(forumPost);

    // Show a snackbar with an option to undo
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Forum Deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, forumPost);
          });
        },
      ),
    ));
  }

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
      child: Text('No expense found, Start adding some!'),
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
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: const ScreenTitle(title: "Community"),
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
                          flex: 2,
                          child: filterButton("All", isSelected = true,
                              (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          }, selectedCategory),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 4,
                          child: filterButton(
                              "Forum Channels", isSelected = false, (category) {
                            setState(() {
                              selectedCategory = category;
                            });
                          }, selectedCategory),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 4,
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 3, bottom: 13),
                          child: Row(
                            children: [
                              Text(
                                "moodeeBoard",
                                style: AppFonts.normalRegularText,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              _openAddExpenseOverlay, // change to create post!
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
                                        child: Image.network(
                                      _provider.userProviderData!.imageURL
                                          .toString(),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Expanded(
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Share your thoughts here...",
                                            // style: AppFonts.smallLightText, // You may need to define this style
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Divider(
                                            thickness: 1,
                                            // color: AppColor.fontColorPrimary.withOpacity(0.5), // You may need to define this color
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
