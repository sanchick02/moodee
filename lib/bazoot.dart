import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:moodee/constants.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Bazoot Chat"),
      ),
      body: DashChat(
          currentUser: _currentUser,
          typingUsers: _typingUser,
          messageOptions: const MessageOptions(
              currentUserContainerColor: Color(0xff8E83FF)),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages),
      backgroundColor: Color(0xffE5E7F2),
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
