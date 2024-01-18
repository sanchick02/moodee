import 'package:flutter/material.dart';

class BackButtonTop extends StatelessWidget {
  const BackButtonTop({
    super.key,
    required this.onBackButtonPressed,
  });

  final VoidCallback onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        "lib/assets/icons/arrow_back_gray_small.png",
        width: 50,
      ),
      onPressed: onBackButtonPressed,
    );
  }
}