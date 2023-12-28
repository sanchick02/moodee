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
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "lib/assets/images/65.png",
                  height: 30,
                  width: 30,
                ),
                Spacer(),
                Text("Home")
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/images/68.png",
                  height: 27,
                  width: 27,
                ),
                Spacer(),
                Text("Chat")
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/images/bot.png",
                  height: 30,
                  width: 30,
                ),
                Text("Bazoot")
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/images/66.png",
                  height: 30,
                  width: 30,
                ),
                Text("Forum")
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/images/67.png",
                  height: 30,
                  width: 30,
                ),
                Text("Profile")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
