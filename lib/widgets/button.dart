import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/shadow.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton({
    super.key,
    required this.text,
    required this.press,
    required this.backgroundColor,
    required this.height,
    required this.fontStyle,
    required this.width,
    required this.padding,
  });

  final Color backgroundColor;
  final TextStyle fontStyle;
  final double height;
  final String text;
  final double width;
  final void Function()? press; // shorthand for void Function()
  final EdgeInsets padding;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              boxShadow: [
                AppShadow.innerShadow3,
              ],
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Positioned.fill(
            child: TextButton(
              onPressed: widget.press,
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(widget.padding),
                backgroundColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              child: Text(
                widget.text,
                style: widget.fontStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
