import 'package:flutter/material.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/animation_screen.dart';
import 'package:moodee/screens/mood_tracker/mood_tracker_screen.dart';
import 'package:moodee/widgets/back_button_top.dart';
import 'package:moodee/widgets/button.dart';

class QuestionsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const QuestionsScreen({Key? key, required this.questions}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;
  // to track whether it's the first question
  bool isFirstQuestion = true;
  int progress = 1;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentQuestion =
        widget.questions[currentQuestionIndex];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                "lib/assets/images/meshGrad1.png",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: BackButtonTop(
                            onBackButtonPressed: () => Navigator.pop(context)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 80,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "lib/assets/images/questionnaire/moodee_logo.png",
                        width: MediaQuery.of(context).size.width - 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Text(
                      "Over the last 2 weeks, how often have you been bothered by the following problem?",
                      style: AppFonts.normalRegularTextHeight,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 0.5,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            backgroundColor:
                                const Color(0xff252525).withOpacity(0.1),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.btnColorPrimary,
                            ),
                            // backgroundColor: Colors.transparent,
                            value: progress / 9,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            currentQuestion['img'],
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 15),
                    child: Column(
                      children: [
                        Text(
                          currentQuestion['Question'],
                          style: TextStyle(
                            fontFamily: "LeagueSpartan",
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: AppColor.fontColorPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            if (currentQuestion['button1'] != null)
                              DefaultButton(
                                text: Text(currentQuestion['button1']).data!,
                                backgroundColor: AppColor.btnColorSecondary,
                                height: 40,
                                width: double.infinity,
                                fontStyle: AppFonts.normalRegularText,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                press: () {
                                  _handleButtonPress(
                                      currentQuestion['button1']);
                                },
                              ),
                            const SizedBox(height: 15),
                            if (currentQuestion['button2'] != null)
                              DefaultButton(
                                text: Text(currentQuestion['button2']).data!,
                                backgroundColor: AppColor.btnColorSecondary,
                                height: 40,
                                width: double.infinity,
                                fontStyle: AppFonts.normalRegularText,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                press: () {
                                  _handleButtonPress(
                                      currentQuestion['button2']);
                                },
                              ),
                            const SizedBox(height: 15),
                            if (currentQuestion['button3'] != null)
                              DefaultButton(
                                text: Text(currentQuestion['button3']).data!,
                                backgroundColor: AppColor.btnColorSecondary,
                                height: 40,
                                width: double.infinity,
                                fontStyle: AppFonts.normalRegularText,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                press: () {
                                  _handleButtonPress(
                                      currentQuestion['button3']);
                                },
                              ),
                            const SizedBox(height: 15),
                            if (currentQuestion['button4'] != null)
                              DefaultButton(
                                text: Text(currentQuestion['button4']).data!,
                                backgroundColor: AppColor.btnColorSecondary,
                                height: 40,
                                width: double.infinity,
                                fontStyle: AppFonts.normalRegularText,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                press: () {
                                  _handleButtonPress(
                                      currentQuestion['button4']);
                                },
                              ),
                            const SizedBox(height: 15),
                            if (currentQuestion['button5'] != null &&
                                !isFirstQuestion)
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  DefaultButton(
                                    text:
                                        Text(currentQuestion['button5']).data!,
                                    backgroundColor: AppColor.btnColorSecondary,
                                    height: 40,
                                    width: double.infinity,
                                    fontStyle: AppFonts.normalRegularText,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    press: () {
                                      _handleButtonPress(
                                          currentQuestion['button5']);
                                    },
                                  ),
                                ],
                              ),
                            // Button 5 with image for the first question only
                            if (currentQuestion['button5'] != null &&
                                isFirstQuestion)
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  DefaultButton(
                                    text:
                                        Text(currentQuestion['button5']).data!,
                                    backgroundColor: AppColor.btnColorSecondary,
                                    height: 40,
                                    width: double.infinity,
                                    fontStyle: AppFonts.normalRegularText,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    press: () {
                                      // _handleButtonPress(
                                      //   currentQuestion['button5'],
                                      // );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const MoodTrackerScreen();
                                        },
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 140),
                                    child: Image.asset(
                                      "lib/assets/icons/scanner.png",
                                      width: 25,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonPress(String buttonText) {
    setState(() {
      isFirstQuestion = false;
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
        progress++;
      } else {
        navigateNextPage(context, const AnimationScreen());
      }
    });
  }
}
