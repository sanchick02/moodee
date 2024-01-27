import 'dart:ui';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:moodee/auth_widget_tree.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/auth/auth_screen.dart';
import 'package:rive/rive.dart' as rive;

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => navigateNextPage(context, const AuthWidgetTree()),
        child: Stack(
          children: [
            Image.asset(
              "lib/assets/images/meshGrad1.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            const rive.RiveAnimation.asset(
              "lib/assets/rive/geometric_shapes.riv",
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 30.0,
                  sigmaY: 30.0), // Adjust the sigma values as needed
              child: const rive.RiveAnimation.asset(
                "lib/assets/rive/text_anim.riv",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
