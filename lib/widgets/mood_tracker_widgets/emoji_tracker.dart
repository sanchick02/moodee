import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moodee/data/mood_tracker.dart';
import 'package:moodee/models/mood_types_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/widgets/button.dart';
import 'package:provider/provider.dart';

class EmojiTracker extends StatefulWidget {

  final Function(MoodTypeModel, double moodIntensity) togglePopUp;

  const EmojiTracker({Key? key, required this.togglePopUp}) : super(key: key);

  @override
  State<EmojiTracker> createState() => _EmojiTrackerState();
}

class _EmojiTrackerState extends State<EmojiTracker> {
    int? _selectedItemIndex;
    double _currentSliderValue = 5;

  @override

  Widget build(BuildContext context) {

    List<MoodTypeModel> moodList = moodTypeList;

    return Column(
      children: [
        SizedBox(
          height: 375,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: GridView.builder(
              itemCount: moodList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, 
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
              itemBuilder: (BuildContext context, int index) {
                final isSelected = index == _selectedItemIndex;
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                        if (index == _selectedItemIndex) {
                          _selectedItemIndex = null;
                        } else {
                          _selectedItemIndex = index;
                        }
                      }
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: isSelected ? AppColor.btnColorPrimary : Colors.white,
                    elevation: 0,
                   
                  ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(moodList[index].image,),
                        
                        Text(
                          moodList[index].type,
                          style: isSelected ? AppFonts.smallestLightTextWhite : AppFonts.smallestLightText,
                          ),
                        
                      ],
                    ),
                );
              },
            ),
          ),
        ),
        
        Slider(
          inactiveColor: Colors.white,
          activeColor: AppColor.btnColorPrimary,
          value: _currentSliderValue,
          max: 10,
          divisions: 10,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20),
          child: Row(
            children: [
              Text(
                '0',
                style: AppFonts.normalRegularText,
              ),
              Spacer(),
              Text(
                'Intensity of your mood',
                style: AppFonts.normalRegularText,
              ),
              Spacer(),
              Text(
                '10',
                style: AppFonts.normalRegularText,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left :10.0, right: 10, top: 20),
          child: DefaultButton(
            text: 'Done', 
            press: () {
              if (_selectedItemIndex!=null) {
                widget.togglePopUp(moodList[_selectedItemIndex!], _currentSliderValue);
              }
            }, 
            backgroundColor: AppColor.btnColorPrimary, 
            height: 40, 
            fontStyle: AppFonts.normalRegularTextWhite, 
            width: MediaQuery.of(context).size.width - 40, 
            padding: const EdgeInsets.only()),
        ),
      ],
    );
  }
}