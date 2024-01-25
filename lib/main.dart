import 'package:audio_service/audio_service.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodee/auth_widget_tree.dart';
import 'package:moodee/models/song_model.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moodee/screens/mood_tracker_screen2.dart';
import 'package:moodee/screens/therapy/test_player_screen.dart';
import 'package:moodee/src/audio_handler.dart';
import 'package:provider/provider.dart';
import 'package:moodee/screens/splash_screen.dart';
import 'firebase_options.dart';

List<CameraDescription>? cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AudioHandler audioHandler = await AudioService.init(
      builder: () => MyAudiohandler(), config: const AudioServiceConfig());
  runApp(MyApp(audioHandler: audioHandler));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.audioHandler});

  final AudioHandler audioHandler;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
      ],
      child: MaterialApp(
        // home: AuthWidgetTree(),
        home: TestPlayerScreen(song: Song.songs[0],),
      ),
    );
  }
}
