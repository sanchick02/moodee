import 'package:flutter/material.dart';
import 'package:moodee/screens/Main%20Pages/Chat.dart';
import 'package:moodee/screens/Main%20Pages/Home_Page.dart';
import 'package:moodee/navbar.dart';
import 'package:moodee/screens/Main%20Pages/Notification.dart';
import 'package:moodee/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
