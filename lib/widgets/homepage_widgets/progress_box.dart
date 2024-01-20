import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class ProgressBox extends StatelessWidget {
  const ProgressBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 240,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          AppShadow.innerShadow3,
          AppShadow.innerShadow4,
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Progress",
                    style: AppFonts.normalRegularText,
                  ),
                  Text(
                    "moodee Journey",
                    style: AppFonts.smallLightText,
                  ),
                ],
              ),
              Container(
                height: 35,
                width: 50,
                decoration: BoxDecoration(
                    color: const Color(0xFFE5E7F2),
                    borderRadius: BorderRadius.circular(30)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("0%")],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 180,
            height: 5,
            decoration: BoxDecoration(
                color: const Color(0xFFE5E7F2),
                borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    );
  }
}
