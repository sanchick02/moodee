import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';

class ToggleSwitch extends StatefulWidget {
  final bool isMember;
  final Function(bool) onToggle;

  const ToggleSwitch({
    Key? key,
    required this.isMember,
    required this.onToggle,
  }) : super(key: key);

  @override
  ToggleSwitchState createState() => ToggleSwitchState();
}

class ToggleSwitchState extends State<ToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.isMember,
      onChanged: widget.onToggle,
      thumbColor: MaterialStateProperty.all(Colors.white),
      activeTrackColor: AppColor.switchColor,
      inactiveTrackColor: AppColor.switchOffColor,
      trackOutlineColor: MaterialStateProperty.all(
        Colors.black.withOpacity(0),
      ),
    );
  }
}


