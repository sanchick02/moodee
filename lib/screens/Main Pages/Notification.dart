import 'package:flutter/material.dart';
import 'package:moodee/widgets/Home_Chat_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE5E7F2),
        body: SingleChildScrollView(
          child: Container(
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
                  "Notifications",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    NotificationWidget(
                        Time: "1min Ago",
                        Event: "🎨 Event Reminder",
                        Desc:
                            "Art and Expressive Therapy (Jan 07) is just around the corner. Get ready and see you there!"),
                    SizedBox(
                      height: 15,
                    ),
                    NotificationWidget(
                        Time: "1min Ago",
                        Event: "📚 Calling all book lovers!",
                        Desc:
                            "Book Clubs & Literature Circles is almost here. Grab your favorite read, bring your thoughts! 📖"),
                    SizedBox(
                      height: 15,
                    ),
                    NotificationWidget(
                        Time: "1hr Ago",
                        Event: "✨ New feature unveiled",
                        Desc:
                            "We've just rolled out our latest feature: an AI Chatbot! Ready to chat?"),
                    SizedBox(
                      height: 15,
                    ),
                    NotificationWidget(
                        Time: "2hrs Ago",
                        Event: "🎉 Celebrating your progress",
                        Desc:
                            "Book Clubs & Literature Circles is almost here. Grab your favorite read, bring your thoughts! 📖"),
                    SizedBox(
                      height: 15,
                    ),
                    NotificationWidget(
                        Time: "1min Ago",
                        Event: "📚 Calling all book lovers!",
                        Desc:
                            "Book Clubs & Literature Circles is almost here. Grab your favorite read, bring your thoughts! 📖"),
                    SizedBox(
                      height: 15,
                    ),
                    NotificationWidget(
                        Time: "1min Ago",
                        Event: "📚 Calling all book lovers!",
                        Desc:
                            "Book Clubs & Literature Circles is almost here. Grab your favorite read, bring your thoughts! 📖"),
                    SizedBox(
                      height: 15,
                    ),
                    NotificationWidget(
                        Time: "1min Ago",
                        Event: "📚 Calling all book lovers!",
                        Desc:
                            "Book Clubs & Literature Circles is almost here. Grab your favorite read, bring your thoughts! 📖"),
                    SizedBox(
                      height: 15,
                    ),
                    NotificationWidget(
                        Time: "1min Ago",
                        Event: "📚 Calling all book lovers!",
                        Desc:
                            "Book Clubs & Literature Circles is almost here. Grab your favorite read, bring your thoughts! 📖"),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
