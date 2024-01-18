import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.text,
    required this.press,
    required this.backgroundColor,
    required this.height,
    required this.fontStyle,
    required this.width, required this.padding,
  });

  final Color backgroundColor;
  final TextStyle fontStyle;
  final double height;
  final String text;
  final double width;
  final VoidCallback press; // shorthand for void Function()
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: [
                AppShadow.innerShadow2,
              ],
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Positioned.fill(
            child: TextButton(
              onPressed: press,
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(padding),
                backgroundColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              child: Text(
                text,
                style: fontStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
