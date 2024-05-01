import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/screens/events/events_All.dart';
import 'package:moodee/screens/wishlist/wishlist_random.dart';
import 'package:moodee/widgets/screen_title.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopBarLogoNotif(),
              Row(
                children: [
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      "lib/assets/icons/arrow_back_gray_small.png",
                      width: 30,
                    ),
                  ),
                  const ScreenTitle(title: "Wishlist"),
                ],
              ),
              const SizedBox(height: 15),
              const RandomWishlist(),
            ],
          ),
        ),
      ),
    );
  }
}
