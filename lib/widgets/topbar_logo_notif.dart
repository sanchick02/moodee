import 'package:flutter/material.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/screens/notifications_screen.dart';

class TopBarLogoNotif extends StatelessWidget {
  const TopBarLogoNotif({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Image.asset(
            "lib/assets/images/Logo.png",
            width: 100,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              navigateNextPage(context, const NotificationsScreen());
            },
            icon: Image.asset(
              "lib/assets/icons/bell.png",
              width: 30,
            ),
          ),
        ],
      ),
    );
  }
}
