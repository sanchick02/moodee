import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class OutlinedDefaultButton extends StatefulWidget {
  const OutlinedDefaultButton({
    Key? key,
    required this.text,
    required this.press,
    required this.height,
    required this.fontStyle,
    required this.width,
    required this.padding,
  }) : super(key: key);

  final TextStyle fontStyle;
  final double height;
  final String text;
  final double width;
  final void Function()? press; // shorthand for void Function()
  final EdgeInsets padding;

  @override
  State<OutlinedDefaultButton> createState() => _OutlinedDefaultButtonState();
}

class _OutlinedDefaultButtonState extends State<OutlinedDefaultButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.black),
            ),
          ),
          Positioned.fill(
            child: TextButton(
              onPressed: widget.press,
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(widget.padding),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                    side: const BorderSide(color: Colors.black),
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
