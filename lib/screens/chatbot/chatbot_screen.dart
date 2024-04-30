import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/widgets/chatbot_widgets/messages.dart';

import "package:moodee/models/message.dart";
import 'package:provider/provider.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatBotScreen> {
  TextEditingController _userMessage = TextEditingController();
  bool isLoading = false;

  static const apiKey = "AIzaSyB9urv4IRE8olJEX2fwui_clELhLV8oHdU";

  final List<Message> _messages = [];

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  void sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages.add(Message(
        isUser: true,
        message: message,
        date: DateTime.now(),
      ));
      isLoading = true;
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
        isUser: false,
        message: response.text ?? "",
        date: DateTime.now(),
      ));
      isLoading = false;
    });
  }

  void onAnimatedTextFinished() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
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
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                  name: message.isUser
                      ? provider.userProviderData!.firstName
                      : 'Bazoot AI',
                  onAnimatedTextFinished: onAnimatedTextFinished,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.fontColorSecondary,
                      boxShadow: [
                        AppShadow.innerShadow3,
                      ],
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  TextFormField(
                    maxLines: 6,
                    minLines: 1,
                    controller: _userMessage,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(999),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Ask me Anything...',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (!isLoading && _userMessage.text.isNotEmpty) {
                            sendMessage();
                          }
                        },
                        child: isLoading
                            ? Container(
                                width: 30,
                                height: 30,
                                margin: const EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColor.fontColorPrimary),
                                  strokeWidth: 3,
                                ),
                              )
                            : Icon(
                                Icons.arrow_upward_outlined,
                                color: _userMessage.text.isNotEmpty
                                    ? AppColor.btnColorPrimary
                                    : const Color.fromARGB(90, 0, 0, 0),
                              ),
                      ),
                    ),
                    style: AppFonts.smallLightText,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
