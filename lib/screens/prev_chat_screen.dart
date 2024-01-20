import 'package:flutter/material.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/nav_bar.dart';
import 'package:moodee/widgets/prev_chat_widgets/chat_preview.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE5E7F2),
        bottomNavigationBar: CustomNavigationBar(
          selectedIndex: 1,
          onDestinationSelected: (index) {
            navbarNavigation(context, null, index);
          },
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBarLogoNotif(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chat History",
                      style: AppFonts.largeMediumText,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      width: 400,
                      height: 600,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Column(
                        children: [
                          ChatPreview(index: 0),
                          ChatPreview(index: 1),
                          ChatPreview(index: 2),
                          ChatPreview(index: 3),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
