import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/outlined_button.dart';

Widget filterButtonTherapist(String category, bool isSelected,
    Function(String) onPressed, String selectedCategory) {
  isSelected = category == selectedCategory;

  return isSelected
      ? DefaultButton(
          text: category,
          press: () {
            onPressed(category);
          },
          backgroundColor: isSelected
              ? AppColor.btnColorPrimary
              : AppColor.btnColorSecondary,
          height: 35,
          fontStyle: isSelected
              ? AppFonts.extraSmallLightTextWhite
              : AppFonts.extraSmallLightText,
          width: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        )
      : OutlinedDefaultButton(
          text: category,
          press: () {
            onPressed(category);
          },
          height: 35,
          fontStyle: isSelected
              ? AppFonts.extraSmallLightTextWhite
              : AppFonts.extraSmallLightText,
          width: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        );
}
