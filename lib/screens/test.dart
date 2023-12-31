import 'package:flutter/material.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/data/therapy_lists.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  child: const Text("Meditation 1"),
                  onPressed: () =>
                      navigateToPlayer(context, meditationList[0])),
              ElevatedButton(
                  child: const Text("Meditation 2"),
                  onPressed: () =>
                      navigateToPlayer(context, meditationList[1])),
              ElevatedButton(
                  child: const Text("Meditation 3"),
                  onPressed: () =>
                      navigateToPlayer(context, meditationList[2])),
              ElevatedButton(
                  child: const Text("Meditation 4"),
                  onPressed: () =>
                      navigateToPlayer(context, meditationList[3])),
              ElevatedButton(
                  child: const Text("Meditation 5"),
                  onPressed: () =>
                      navigateToPlayer(context, meditationList[4])),
              ElevatedButton(
                  child: const Text("Meditation 6"),
                  onPressed: () =>
                      navigateToPlayer(context, meditationList[5])),
              ElevatedButton(
                  child: const Text("Meditation 7"),
                  onPressed: () =>
                      navigateToPlayer(context, meditationList[6])),
              ElevatedButton(
                  child: const Text("Meditation 8"),
                  onPressed: () =>
                      navigateToPlayer(context, meditationList[7])),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  child: const Text("Music 1"),
                  onPressed: () => navigateToPlayer(context, musicList[0])),
              ElevatedButton(
                  child: const Text("Music 2"),
                  onPressed: () => navigateToPlayer(context, musicList[1])),
              ElevatedButton(
                  child: const Text("Music 3"),
                  onPressed: () => navigateToPlayer(context, musicList[2])),
              ElevatedButton(
                  child: const Text("Music 4"),
                  onPressed: () => navigateToPlayer(context, musicList[3])),
              ElevatedButton(
                  child: const Text("Music 5"),
                  onPressed: () => navigateToPlayer(context, musicList[4])),
              ElevatedButton(
                  child: const Text("Music 6"),
                  onPressed: () => navigateToPlayer(context, musicList[5])),
              ElevatedButton(
                  child: const Text("Music 7"),
                  onPressed: () => navigateToPlayer(context, musicList[6])),
              ElevatedButton(
                  child: const Text("Music 8"),
                  onPressed: () => navigateToPlayer(context, musicList[7])),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                child: const Text("Story 1"),
                onPressed: () => navigateToPlayer(context, storyList[0]),
              ),
              ElevatedButton(
                child: const Text("Story 2"),
                onPressed: () => navigateToPlayer(context, storyList[1]),
              ),
              ElevatedButton(
                child: const Text("Story 3"),
                onPressed: () => navigateToPlayer(context, storyList[2]),
              ),
              ElevatedButton(
                child: const Text("Story 4"),
                onPressed: () => navigateToPlayer(context, storyList[3]),
              ),
              ElevatedButton(
                child: const Text("Story 5"),
                onPressed: () => navigateToPlayer(context, storyList[4]),
              ),
              ElevatedButton(
                child: const Text("Story 6"),
                onPressed: () => navigateToPlayer(context, storyList[5]),
              ),
              ElevatedButton(
                child: const Text("Story 7"),
                onPressed: () => navigateToPlayer(context, storyList[6]),
              ),
              ElevatedButton(
                child: const Text("Story 8"),
                onPressed: () => navigateToPlayer(context, storyList[7]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
