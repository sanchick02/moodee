import 'package:flutter/material.dart';
import 'package:moodee/call_page.dart';
import 'package:moodee/chat_messages.dart';
import 'package:moodee/new_message_chat.dart';
import 'package:moodee/page_navigator.dart';

class ChatScreen1 extends StatelessWidget {
  const ChatScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
          actions: [
            IconButton(
                onPressed: () {
                  // navigate to video call screen
                  navigateNextPage(context, const CallPage());
                },
                icon: const Icon(Icons.video_call_rounded))
          ],
        ),
        body: const Column(
          children: [
            Expanded(child: ChatMessages()),
            NewMessage(),
          ],
        ));
  }
}
