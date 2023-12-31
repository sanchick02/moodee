import 'package:flutter/material.dart';
import 'package:moodee/screens/events/popup_event.dart';

class Test2Screen extends StatefulWidget {
  const Test2Screen({super.key});

  @override
  State<Test2Screen> createState() => _Test2ScreenState();
}

class _Test2ScreenState extends State<Test2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                child: const Text("Event 1"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PopUpEvent(); // Your custom popup content
                    },
                  );
                }, // open pop up
              ),
              ElevatedButton(
                child: const Text("Event 2"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PopUpEvent(); // Your custom popup content
                    },
                  );
                }, // open pop up
              ),
              ElevatedButton(
                child: const Text("Event 3"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PopUpEvent(); // Your custom popup content
                    },
                  );
                }, // open pop up
              ),
              ElevatedButton(
                child: const Text("Event 4"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PopUpEvent(); // Your custom popup content
                    },
                  );
                }, // open pop up
              ),
            ],
          ),
        ),
      ),
    );
  }
}
