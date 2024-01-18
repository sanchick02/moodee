import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';

class AvailabilityButton extends StatefulWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onPressed;

  const AvailabilityButton({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  _AvailabilityButtonState createState() => _AvailabilityButtonState();
}

class _AvailabilityButtonState extends State<AvailabilityButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 20,
      child: TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(
            widget.isSelected
                ? AppColor.backgroundColor
                : AppColor.btnColorSecondary,
          ),
        ),
        child: Text(
          widget.time,
          style: AppFonts.extraSmallLightText,
        ),
      ),
    );
  }
}
