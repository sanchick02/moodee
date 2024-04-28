import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';

class PopUpButton extends StatelessWidget {
  final VoidCallback onPressed; // Function to execute when button is pressed
  final Color backgroundColor; // Background color of the button
  final Color borderColor;
  final String label;
  final TextStyle style; // Border color of the button (optional)

  const PopUpButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor, // Default background color
    required this.borderColor,
    required this.label,
    required this.style, // Optional border color
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide( // Define border properties
            color: borderColor, // Set border color
            width: 1.0,       // Set border width in pixels
          ), // Set your desired background color
        ),
        onPressed: () {}, 
        child: Text(
          label,
          style: style,
        ),
      ),
    );
  }
}
