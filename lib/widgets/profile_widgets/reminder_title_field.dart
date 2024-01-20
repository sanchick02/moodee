
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class ReminderTitleField extends StatelessWidget {
  const ReminderTitleField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "",
          style: AppFonts.normalRegularText,
        ),
        SizedBox(
          width: 330,
          height: 50,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.fontColorSecondary,
                  boxShadow: [
                    AppShadow.innerShadow3,
                  ],
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: AppFonts.smallRegularText,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
