import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/widgets/messages.dart';

import "package:moodee/models/message.dart";
import "package:moodee/utils/style.dart";
import "package:moodee/utils/size.dart";
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: Text('Bazoot AI',
            style:
                GoogleFonts.poppins(color: black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
            padding: const EdgeInsets.symmetric(
                horizontal: medium, vertical: medium),
            child: TextFormField(
              maxLines: 6,
              minLines: 1,
              controller: _userMessage,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(medium, 10, small, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: 'Ask me Anything...',
                hintStyle: hintText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (!isLoading && _userMessage.text.isNotEmpty) {
                      sendMessage();
                    }
                  },
                  child: isLoading
                      ? Container(
                          width: medium,
                          height: medium,
                          margin: const EdgeInsets.all(xsmall),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(black),
                            strokeWidth: 3,
                          ),
                        )
                      : Icon(
                          Icons.arrow_upward,
                          color: _userMessage.text.isNotEmpty
                              ? const Color.fromARGB(255, 216, 0, 0)
                              : const Color.fromARGB(90, 0, 0, 0),
                        ),
                ),
              ),
              style: promptText,
              onChanged: (value) {
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}
