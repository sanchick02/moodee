import 'package:flutter/material.dart';
import 'package:moodee/models/forum.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/providers/forum_post_provider.dart';
import 'package:moodee/widgets/community_widgets/new_forum.dart';
import 'package:provider/provider.dart';

import '../../widgets/screen_title.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final List<ForumPost> _registeredExpenses = [
    ForumPost(
        uid: '',
        pid: '',
        userImage: '',
        userName: '',
        time: '',
        caption: '',
        postImage: '',
        likes: 0,
        mood: ''),
  ];

  void _updateForumPosts(ForumPost forumPost) {
    setState(() {
      // Add the new forum post to the list
      _registeredExpenses.insert(0, forumPost);
    });
  }

  // void _removeExpense(ForumPost forumPost) {
  //   final expenseIndex = _registeredExpenses.indexOf(forumPost);
  //   _registeredExpenses.remove(forumPost);

  //   // Show a snackbar with an option to undo
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     duration: const Duration(seconds: 3),
  //     content: const Text('Forum Deleted'),
  //     action: SnackBarAction(
  //       label: 'Undo',
  //       onPressed: () {
  //         setState(() {
  //           _registeredExpenses.insert(expenseIndex, forumPost);
  //         });
  //       },
  //     ),
  //   ));
  // }

  @override
  void initState() {
    Provider.of<ForumProvider>(context, listen: false)
        .fetchUserData()
        .then((_) {
      setState(() {
        _registeredExpenses;
        // _registeredExpenses.sort((a, b) => b.time.compareTo(a.time));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  "moodeeBoard",
                  style: AppFonts.normalRegularText,
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "lib/assets/icons/arrow_back_gray_small.png",
                    width: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: ScreenTitle(title: "Create a Post"),
              ),
              NewForum(
                onAddExpense: _updateForumPosts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
