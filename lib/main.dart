import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:moodee/auth_widget_tree.dart';
import 'package:moodee/forum_screen.dart';
import 'package:moodee/display_forums.dart';
import 'package:moodee/models/forum.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';
import 'firebase_options.dart';

List<CameraDescription>? cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
      ],
      child: const MaterialApp(
        home: AuthWidgetTree(),
      ),
    );
  }
}
