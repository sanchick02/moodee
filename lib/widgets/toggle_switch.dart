import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';

class ToggleSwitch extends StatefulWidget {
  final Function(bool) onToggle;

  const ToggleSwitch({
    Key? key,
    required this.onToggle,
  }) : super(key: key);

  @override
  ToggleSwitchState createState() => ToggleSwitchState();
}

class ToggleSwitchState extends State<ToggleSwitch> {
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
            widget.onToggle(value);
          });
        },
        thumbColor: MaterialStateProperty.all(Colors.white),
        activeTrackColor: AppColor.switchColor,
        inactiveTrackColor: AppColor.switchOffColor,
        trackOutlineColor: MaterialStateProperty.all(
          Colors.black.withOpacity(0),
        ),
      ),
    );
  }
}
