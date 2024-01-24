import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moodee/screens/animation_screen.dart';
import 'package:moodee/screens/community/audio_room.dart';
import 'package:moodee/screens/home_screen.dart';
import 'package:moodee/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
