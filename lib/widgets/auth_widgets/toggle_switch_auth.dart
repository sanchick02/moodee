import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';

class ToggleSwitchAuth extends StatefulWidget {
  final bool isMember;
  final Function(bool) onToggle;

  const ToggleSwitchAuth({
    Key? key,
    required this.isMember,
    required this.onToggle,
  }) : super(key: key);

  @override
  ToggleSwitchAuthState createState() => ToggleSwitchAuthState();
}

class ToggleSwitchAuthState extends State<ToggleSwitchAuth> {
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
