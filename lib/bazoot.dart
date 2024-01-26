import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/constants.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class Bazoot_Screen extends StatefulWidget {
  const Bazoot_Screen({super.key});

  @override
  State<Bazoot_Screen> createState() => _Bazoot_ScreenState();
}

class _Bazoot_ScreenState extends State<Bazoot_Screen> {
  final _openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true);
  final ChatUser _currentUser = ChatUser(id: "1", firstName: "Charlie");
  final ChatUser _chatgptUser = ChatUser(id: "2", firstName: "Bazoot");
  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUser = <ChatUser>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 50),
              decoration: BoxDecoration(
                color: AppColor.fontColorSecondary,
                boxShadow: [AppShadow.innerShadow1],
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
                          "Bazoot",
                          style: AppFonts.heading3Height,
                        ),
                        Text(
                          "Your personalised 24/7 companion",
                          style: AppFonts.smallLightText,
                        )
                      ],
                    ),
                    leading: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: SizedBox(
                              // width: 5,
                              ),
                        ),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              "lib/assets/icons/bazoot.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    leadingWidth: 80,
                  ),
                ],
              ),
            ),
            Expanded(
              child: DashChat(
                  currentUser: _currentUser,
                  typingUsers: _typingUser,
                  messageOptions: MessageOptions(
                    currentUserContainerColor: AppColor.btnColorPrimary,
                    textColor: AppColor.fontColorPrimary,
                  ),
                  onSend: (ChatMessage m) {
                    getChatResponse(m);
                  },
                  messages: _messages),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    try {
      setState(() {
        _messages.insert(0, m);
        _typingUser.add(_chatgptUser);
      });
      List<Messages> _messagesHistory = _messages.reversed.map((m) {
        if (m.user == _currentUser) {
          return Messages(role: Role.user, content: m.text);
        } else {
          return Messages(role: Role.assistant, content: m.text);
        }
      }).toList();
      final request = ChatCompleteText(
          model: GptTurbo0301ChatModel(),
          messages: _messagesHistory,
          maxToken: 500);
      final response = await _openAI.onChatCompletion(request: request);
      for (var element in response!.choices) {
        if (element.message != null) {
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                  user: _chatgptUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content),
            );
          });
        }
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _typingUser.remove(_chatgptUser);
    });
  }
}
