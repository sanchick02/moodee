import 'package:flutter/material.dart';
import 'package:moodee/navbar.dart';
import 'package:moodee/widgets/Home_Chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE5E7F2),
        body: Container(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "lib/assets/images/Logo.png",
                      height: 45,
                      width: 120,
                    ),
                    Image.asset(
                      "lib/assets/icons/bell.png",
                      height: 40,
                      width: 30,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Chat History",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  width: 400,
                  height: 600,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      Chat(
                        Photo: "lib/assets/images/therapist1.png",
                        Name: "jennifer",
                        Role: "Psychologist",
                        Desc: "It's my pleasure. Remember, you're...",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Chat(
                        Photo: "lib/assets/images/therapist2.png",
                        Name: "John",
                        Role: "Mental Health Counselor",
                        Desc: "CIBAII SHUT UP!!",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Chat(
                        Photo: "lib/assets/images/therapist3.png",
                        Name: "Monica",
                        Role: "Mental Health Counselor",
                        Desc: "CIBAII SHUT UP!!",
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
