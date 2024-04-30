import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/questions.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/screens/questions/question_screen.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/divider_line.dart';
import 'package:moodee/widgets/unordered_list.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                  height: 80,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "lib/assets/images/questionnaire/moodee_logo.png",
                      width: MediaQuery.of(context).size.width - 60,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Column(
                    children: [
                      Text(
                        "Hey Sam,",
                        style: AppFonts.heading2,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "before using the app,",
                        style: TextStyle(
                          fontFamily: "LeagueSpartan",
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: AppColor.fontColorPrimary,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Help us get to know you better!",
                  style: AppFonts.largeMediumText,
                ),
                const SizedBox(height: 15),
                Container(
                  margin: AppStyles.edgeInsetsLR,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 100),
                  decoration: BoxDecoration(
                    color: AppColor.btnColorSecondary,
                    borderRadius: AppStyles.borderRadiusAll,
                    boxShadow: [AppShadow.innerShadow3],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Patient Health Questionnaire (PHQ)",
                        style: AppFonts.normalRegularText,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "9-question self-test instrument to screen for presence and severity of depression.",
                        style: AppFonts.extraSmallLightText,
                        textAlign: TextAlign.center,
                      ),
                      const DividerLine(),
                      const SizedBox(
                        height: 10,
                      ),
                      UnorderedList(const [
                        "The results of these tests can be used as a guide in identifying early symptoms and indicators for treatment needs.",
                        "Nevertheless, the results of these screening tests are non-diagnostic and require referral to a professional for further evaluation.",
                        "Please answer each question to the best of your ability and be truthful in your responses.",
                        "Your responses are confidential and will strictly be visible to you and your therapist only.",
                        "Take your time to reflect on each question before providing your response.",
                      ]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                DefaultButton(
                  press: () {
                    navigateNextPage(
                      context,
                      const QuestionsScreen(
                        questions: questionsList,
                      ),
                    );
                  },
                  text: "Start Answering",
                  backgroundColor: AppColor.btnColorPrimary,
                  height: 40,
                  fontStyle: AppFonts.normalRegularTextWhite,
                  width: MediaQuery.of(context).size.width - 40,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
