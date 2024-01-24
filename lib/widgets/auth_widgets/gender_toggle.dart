import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class GenderToggle extends StatefulWidget {
  final ValueChanged<int>? onPressed;
  final List<bool> isSelected;

  const GenderToggle({
    Key? key,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  GenderToggleState createState() => GenderToggleState();
}

class GenderToggleState extends State<GenderToggle> {
  List<bool> isSelected = [
    true,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: widget.onPressed,
      isSelected: widget.isSelected,
      borderColor: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      children: [
        _buildToggleButton("Male", widget.isSelected[0]),
        _buildToggleButton("Female", widget.isSelected[1]),
      ],
    );
  }

  Widget _buildToggleButton(String label, bool isSelected) {
    BorderRadius borderRadius;

    if (widget.isSelected[0]) {
      borderRadius = isSelected
          ? const BorderRadius.only(
              topLeft: Radius.circular(999),
              bottomLeft: Radius.circular(999),
            )
          : const BorderRadius.only(
              topRight: Radius.circular(999),
              bottomRight: Radius.circular(999),
            );
    } else if (widget.isSelected[1]) {
      borderRadius = isSelected
          ? const BorderRadius.only(
              topRight: Radius.circular(999),
              bottomRight: Radius.circular(999),
            )
          : const BorderRadius.only(
              topLeft: Radius.circular(999),
              bottomLeft: Radius.circular(999),
            );
    } else {
      borderRadius = isSelected
          ? const BorderRadius.only(
              topLeft: Radius.circular(999),
              bottomLeft: Radius.circular(999),
            )
          : const BorderRadius.only(
              topRight: Radius.circular(999),
              bottomRight: Radius.circular(999),
            );
    }

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? AppColor.btnColorPrimary : Color(0xffF6F6F6),
        borderRadius: borderRadius,
        boxShadow: [AppShadow.innerShadow1], // not done yet
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Text(
          label,
          style: isSelected
              ? AppFonts.smallLightTextWhite
              : AppFonts.smallLightText,
        ),
      ),
    );
  }
}
