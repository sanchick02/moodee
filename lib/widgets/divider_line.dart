import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.8,
      color: AppColor.fontColorPrimary,
    );
  }
}
