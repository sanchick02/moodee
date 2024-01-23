import 'package:flutter/material.dart';
import 'package:moodee/screens/bazoot.dart';
import 'package:moodee/screens/community/community_screen.dart';
import 'package:moodee/screens/home_screen.dart';
import 'package:moodee/screens/profile/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CommunityScreen(),
    );
  }
}
