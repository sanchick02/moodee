import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
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

    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: ((MediaQuery.of(context).size.width / 2) - 40) / 2,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.btnColorPrimary
                : AppColor.btnColorSecondary,
            borderRadius: borderRadius,
            boxShadow: [
              AppShadow.innerShadow3,
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            child: Text(
              textAlign: TextAlign.center,
              label,
              style: isSelected
                  ? AppFonts.smallLightTextWhite
                  : AppFonts.smallLightText,
            ),
          ),
        ),
      ],
    );
  }
}
