import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/button.dart';

Widget filterButton(String category, bool isSelected,
    Function(String) onPressed, String selectedCategory) {
  isSelected = category == selectedCategory;

  return DefaultButton(
    text: category,
    press: () {
      onPressed(category);
    },
    backgroundColor:
        isSelected ? AppColor.btnColorPrimary : AppColor.btnColorSecondary,
    height: 35,
    fontStyle:
        isSelected ? AppFonts.smallLightTextWhite : AppFonts.smallLightText,
    width: 50,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}

Widget seeAllButton(String category, Function(String) onPressed,
    String selectedCategory, Function(String) onSeeAll) {
  return DefaultButton(
    text: "See All",
    press: () {
      onPressed(category);
      onSeeAll(category);
    },
    backgroundColor: AppColor.btnColorPrimary,
    height: 35,
    fontStyle: AppFonts.smallLightTextWhite,
    width: 100,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}
