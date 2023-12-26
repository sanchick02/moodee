import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            "lib/assets/icons/home.png",
            height: 30,
            width: 30,
          ),
          Image.asset(
            "lib/assets/icons/chat.png",
            height: 30,
            width: 30,
          ),
          Icon(Icons.abc),
          Image.asset(
            "lib/assets/icons/forum.png",
            height: 30,
            width: 30,
          ),
          Image.asset(
            "lib/assets/icons/profile.png",
            height: 30,
            width: 30,
          )
        ],
      ),
    );
  }
}
