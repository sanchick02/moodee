import 'package:flutter/material.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/nav_bar.dart';
import 'package:moodee/widgets/notifications_widgets/notification_widget.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        // bottomNavigationBar: CustomNavigationBar(
        //   selectedIndex: 0,
        //   onDestinationSelected: (index) {
        //     navbarNavigation(context, 0, index);
        //   },
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopBarLogoNotif(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Notifications",
                        style: AppFonts.largeMediumText,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Column(
                        children: [
                          NotificationWidget(index: 0),
                          NotificationWidget(index: 1),
                          NotificationWidget(index: 2),
                          NotificationWidget(index: 3),
                          NotificationWidget(index: 4),
                          NotificationWidget(index: 5),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
