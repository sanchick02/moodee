import 'dart:ui';
import 'package:moodee/models/mood_types_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/widgets/mood_tracker_widgets/pop_up_button.dart';

class popUpContainer extends StatelessWidget {
  const popUpContainer({
    super.key,
    required this.showPopup,
    required this.moodData,
  });

  final bool showPopup;
  final MoodTypeModel moodData;

  @override
  Widget build(BuildContext context) {
    final TextEditingController userInputController;
    return Visibility(
      visible: showPopup,
      child: Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Material(
          color: Colors.white, // Adjust transparency
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Center(
              // Your custom top widget here (e.g., Textfield, Dialog)
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                  boxShadow: [
                    AppShadow.innerShadow1,
                    AppShadow.innerShadow3,
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Tell Us More!',
                        style: AppFonts.largeMediumText,
                      ),
                      Text(
                        'Share your day with us, we are here for you.',
                        style: AppFonts.extraSmallLightText,
                      ),
                      const Spacer(),
                      Text(
                        moodData.question[0],
                        style: AppFonts.normalRegularText,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Container(
                        //alignment: Alignment.center,
                        height: 90,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: [
                              AppShadow.innerShadow4,
                            ],
                          ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Share your thoughts here...',
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          PopUpButton(
                          label: 'Submit', 
                          onPressed: () {},
                          backgroundColor: AppColor.btnColorPrimary,
                          borderColor: AppColor.btnColorPrimary,
                          style: AppFonts.extraSmallLightTextWhite,
                          ),
                          SizedBox(width: 15,),
                          PopUpButton(
                            onPressed: () {}, 
                            backgroundColor: Colors.white, 
                            borderColor: Colors.black, 
                            label: 'Skip Question',
                            style: AppFonts.extraSmallRegularText,
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}