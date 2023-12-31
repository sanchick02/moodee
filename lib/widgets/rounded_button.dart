import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.image,
    required this.color,
    required this.press,
  });

  final Image image;
  final Color color;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          minimumSize: const Size(60, 60),
          backgroundColor: color,
        ),
        child: image,
      ),
    );
  }
}
