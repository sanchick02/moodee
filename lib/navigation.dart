import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/models/forum_channels_model.dart';
import 'package:moodee/models/user_model.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/screens/community/community_screen.dart';
import 'package:moodee/screens/home_screen.dart';
import 'package:moodee/screens/prev_chat_screen.dart';
import 'package:moodee/screens/profile/profile_screen.dart';
import 'package:moodee/screens/splash_screen.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.fontColorSecondary,

       body: _isLoading ? SplashScreen() : pages[currentIndex],
      bottomNavigationBar: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
                color: AppColor.btnColorSecondary,
                borderRadius: AppStyles.borderRadiusTop,
                boxShadow: [AppShadow.innerShadow1]),
          ),
          NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: AppColor.fontColorPrimary.withOpacity(0.1),
            ),
            child: NavigationBar(
              elevation: 0,
              selectedIndex: currentIndex,
              onDestinationSelected: (int newIndex) {
                setState(() {
                  currentIndex = newIndex;
                });
              },
              height: 70,
              backgroundColor: Colors.transparent,
              destinations: [
                NavigationDestination(
                  icon: Image.asset(
                    "lib/assets/images/home.png",
                    width: 40,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Image.asset(
                    "lib/assets/images/chat.png",
                    width: 40,
                  ),
                  label: 'Chat',
                ),
                NavigationDestination(
                  icon: Image.asset(
                    "lib/assets/images/bot.png",
                    width: 40,
                  ),
                  label: 'Bazoot',
                ),
                NavigationDestination(
                  icon: Image.asset(
                    "lib/assets/images/forum.png",
                    width: 40,
                  ),
                  label: 'Forum',
                ),
                NavigationDestination(
                  icon: Image.asset(
                    "lib/assets/images/profile.png",
                    width: 40,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
