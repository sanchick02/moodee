import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodee/auth_widget_tree.dart';
import 'package:moodee/models/mood_tracker.dart';
import 'package:moodee/models/mood_types_model.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/mood_tracker_widgets/pop_up_button.dart';

class PopUpMoodTracker extends StatelessWidget {
  PopUpMoodTracker({
    super.key,
    required this.showPopup,
    required this.moodData,
    required this.moodIntensity,
  });

  TextEditingController userInputController = TextEditingController();

  final bool showPopup;
  final MoodTypeModel moodData;
  final double moodIntensity;
  

  void storeMood() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String answer = userInputController.text;
    final now = DateTime.now();
    String timePeriod;
    if (now.hour >= 5 && now.hour < 12) {
      timePeriod = 'Morning';
    } else if (now.hour >= 12 && now.hour < 17) {
      timePeriod = 'Afternoon';
    } else if (now.hour >= 17 && now.hour < 21) {
      timePeriod = 'Evening';
    } else {
      timePeriod = 'Night';
    }
    
    if (user != null) {
      MoodTracker myData = MoodTracker(
        image: moodData.image,
        moodTrackerStreak: null,
        type: moodData.type, 
        question: moodData.question[0], 
        date: DateTime.now().toString(),
        moodIntensity: moodIntensity,
        timePeriod: timePeriod,
        userId: user.uid,
        answer: answer,
        );
  // Get a Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Reference to a collection
  CollectionReference collectionReference = firestore.collection('moods');

  DocumentReference userDocRef = collectionReference.doc(user.uid);

  CollectionReference userMoodsCollection = userDocRef.collection('user_moods');
  // Add document with a unique ID
  await userMoodsCollection.add(myData.toMap())
      .then((value) => print("Data Added" + user.uid))
      .catchError((error) => print("Failed to add data: $error"));
}
  }

  @override
  Widget build(BuildContext context) {
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
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                      const Spacer(),
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
                        child: TextField(
                          controller: userInputController,
                          decoration: const InputDecoration(
                            hintText: 'Share your thoughts here...',
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          PopUpButton(
                          label: 'Submit', 
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context)
                              {
                                return AlertDialog(
                                  backgroundColor: AppColor.fontColorSecondary,
                                  scrollable: true,
                                  title: Text(
                                    'Confirmation',
                                    style: AppFonts.largeMediumText,
                                  ),
                                  content: const Text(
                                      'Mood Tracked Successfully'),
                                  actions: [
                                    DefaultButton(
                                      backgroundColor: AppColor.btnColorPrimary,
                                      text: "Okay",
                                      height: 30,
                                      fontStyle: AppFonts.smallLightTextWhite,
                                      width: double.infinity,
                                      padding: EdgeInsets.zero,
                                      press: () {
                                        storeMood();
                                        navigateNextPage(context, const AuthWidgetTree());
                                      },
                                    ),
                                  ],
                                );
                              }
                            );
                          },
                          backgroundColor: AppColor.btnColorPrimary,
                          borderColor: AppColor.btnColorPrimary,
                          style: AppFonts.extraSmallLightTextWhite,
                          ),
                          const SizedBox(width: 15,),
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