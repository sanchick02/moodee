import 'package:flutter/material.dart';
import 'package:moodee/models/forum_channels_model.dart';
import 'package:moodee/models/user_model.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/screens/community/community_screen.dart';
import 'package:moodee/screens/home_screen.dart';
import 'package:moodee/screens/prev_chat_screen.dart';
import 'package:moodee/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BottomNavigationBar get navigationBar {
    return _NavigationState.navigatorKey.currentWidget as BottomNavigationBar;
  }

  int currentIndex = 0;
  bool _isLoading = true;

  List<Widget> pages = [
    const HomeScreen(),
    const ChatScreen(),
    const CommunityScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)
        .fetchUserData()
        .then((value) => setState(() {
              _isLoading = false;
            }));
    super.initState();
    // _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
