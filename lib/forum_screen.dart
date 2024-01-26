import 'dart:io';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/new_forum.dart';
import 'package:moodee/forum_list_.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';

import 'package:moodee/models/forum.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/widgets/divider_line.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<ForumScreen> {
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
    });
  }

  void _removeExpense(ForumPost forumPost) {
    final expenseIndex = _registeredExpenses.indexOf(forumPost);
    setState(() {
      _registeredExpenses.remove(forumPost);
    });
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
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text('No expense found, Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ForumLists();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
            GestureDetector(
              onTap: _openAddExpenseOverlay, // change to create post!
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                width: double.infinity,
                constraints: const BoxConstraints(
                    minHeight: 80, maxHeight: 100), // ADJUST LATER!!
                decoration: BoxDecoration(
                  color: AppColor.fontColorSecondary,
                  borderRadius: AppStyles.borderRadiusAll,
                  boxShadow: [
                    AppShadow.innerShadow3,
                    AppShadow.innerShadow4,
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Row(
                    children: [
                      SizedBox(
                        child: ClipOval(
                          child: Image.asset(
                            "lib/assets/images/face1.jpg",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Share your thoughts here...",
                                style: AppFonts.smallLightText,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                thickness: 1,
                                color:
                                    AppColor.fontColorPrimary.withOpacity(0.5),
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
            Expanded(
              child: mainContent,
            )
          ],
        ),
      ),
    );
  }
}
