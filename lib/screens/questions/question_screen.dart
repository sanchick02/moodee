import 'package:flutter/material.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/homepage/Home_Page.dart';
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

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentQuestion =
        widget.questions[currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/assets/images/meshGrad1.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    currentQuestion['img'],
                    width: 350,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: Column(
                  children: [
                    Text(
                      currentQuestion['Question'],
                      style: AppFonts.heading3,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        if (currentQuestion['button1'] != null)
                          DefaultButton(
                            text: Text(currentQuestion['button1']).data!,
                            backgroundColor: AppColor.btnColorSecondary,
                            height: 40,
                            fontStyle: AppFonts.normalRegularText,
                            press: () {
                              _handleButtonPress(currentQuestion['button1']);
                            },
                          ),
                        const SizedBox(height: 15),
                        if (currentQuestion['button2'] != null)
                          DefaultButton(
                            text: Text(currentQuestion['button2']).data!,
                            backgroundColor: AppColor.btnColorSecondary,
                            height: 40,
                            fontStyle: AppFonts.normalRegularText,
                            press: () {
                              _handleButtonPress(currentQuestion['button2']);
                            },
                          ),
                        const SizedBox(height: 15),
                        if (currentQuestion['button3'] != null)
                          DefaultButton(
                            text: Text(currentQuestion['button3']).data!,
                            backgroundColor: AppColor.btnColorSecondary,
                            height: 40,
                            fontStyle: AppFonts.normalRegularText,
                            press: () {
                              _handleButtonPress(currentQuestion['button3']);
                            },
                          ),
                        const SizedBox(height: 15),
                        if (currentQuestion['button4'] != null)
                          DefaultButton(
                            text: Text(currentQuestion['button4']).data!,
                            backgroundColor: AppColor.btnColorSecondary,
                            height: 40,
                            fontStyle: AppFonts.normalRegularText,
                            press: () {
                              _handleButtonPress(currentQuestion['button4']);
                            },
                          ),
                        const SizedBox(height: 15),
                        if (currentQuestion['button5'] != null &&
                            !isFirstQuestion)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              DefaultButton(
                                text: Text(currentQuestion['button5']).data!,
                                backgroundColor: AppColor.btnColorSecondary,
                                height: 40,
                                fontStyle: AppFonts.normalRegularText,
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
                                text: Text(currentQuestion['button5']).data!,
                                backgroundColor: AppColor.btnColorSecondary,
                                height: 40,
                                fontStyle: AppFonts.normalRegularText,
                                press: () {
                                  _handleButtonPress(
                                      currentQuestion['button5']);
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
    );
  }

  void _handleButtonPress(String buttonText) {
    setState(() {
      currentQuestionIndex++;
      isFirstQuestion = false;
      if (currentQuestionIndex >= widget.questions.length) {
        navigateNextPage(context, const HomeScreen());
      }
    });
  }
}
