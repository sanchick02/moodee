// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/providers/therapist_provider.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/screens/therapist/therapist_call_screen.dart';
import 'package:moodee/widgets/back_button_top.dart';
import 'package:moodee/widgets/chat_widgets/chat_messages.dart';
import 'package:moodee/widgets/chatbot_widgets/new_message_chat.dart';
import 'package:moodee/page_navigator.dart';
import 'package:provider/provider.dart';

User auth = FirebaseAuth.instance.currentUser!;

class TherapistChatScreen extends StatefulWidget {
  const TherapistChatScreen({super.key});

  @override
  State<TherapistChatScreen> createState() => _TherapistChatScreenState();
}

class _TherapistChatScreenState extends State<TherapistChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    print("FirebaseMessaging token: $token");
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    var therapistProvider = Provider.of<TherapistProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    String usersTherapistId = userProvider.userProviderData!.therapist_id;

    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 50),
                decoration: BoxDecoration(
                  color: AppColor.fontColorSecondary,
                  boxShadow: [AppShadow.innerShadow3],
                ),
                child: Column(
                  children: [
                    AppBar(
                      scrolledUnderElevation: 0,
                      backgroundColor: Colors.transparent,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            therapistProvider.therapistsList
                                .firstWhere(
                                    (element) => element.id == usersTherapistId)
                                .name,
                            style: AppFonts.heading3Height,
                          ),
                          Text(
                            "Psychologist",
                            style: AppFonts.smallLightText,
                          )
                        ],
                      ),
                      leading: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BackButtonTop(
                              onBackButtonPressed: () =>
                                  Navigator.pop(context)),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.asset(
                                therapistProvider.therapistsList
                                    .firstWhere((element) =>
                                        element.id == usersTherapistId)
                                    .image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      leadingWidth: 120,
                      actions: [
                        IconButton(
                            onPressed: () {
                              // navigate to video call screen
                              navigateNextPage(context, const CallPage());
                            },
                            icon: Icon(
                              Icons.video_call_rounded,
                              color: AppColor.fontColorPrimary,
                              size: 35,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(child: ChatMessages()),
              const NewMessage(),
            ],
          ),
        ));
  }
}
