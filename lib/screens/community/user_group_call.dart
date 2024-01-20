import 'package:flutter/material.dart';
import 'package:moodee/data/group_call_users.dart';
import 'package:moodee/presets/fonts.dart';

class UserGroupCall extends StatelessWidget {
  const UserGroupCall({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 90,
          height: 90,
          child: Image.asset(
            groupCallUsersList[index].image,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          groupCallUsersList[index].name,
          style: AppFonts.smallLightText,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
