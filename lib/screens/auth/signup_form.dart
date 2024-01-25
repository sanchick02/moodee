import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:moodee/data/questions.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/questions/question_screen.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/auth_widgets/formfield.dart';
import 'package:moodee/widgets/auth_widgets/gender_toggle.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  List<bool> isSelected = [
    true,
    false,
  ];

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1946, 1),
        lastDate: DateTime(2024, 12));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomFormField(
                label: "First Name",
                keyboardType: TextInputType.name,
                obscureText: false,
                width: 165,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomFormField(
                label: "Last Name",
                keyboardType: TextInputType.name,
                obscureText: false,
                width: 165,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: AppFonts.normalRegularText,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.btnColorSecondary,
                                boxShadow: [
                                  AppShadow.innerShadow3,
                                ],
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            GenderToggle(
                              onPressed: (index) {
                                setState(() {
                                  for (int buttonIndex = 0;
                                      buttonIndex < isSelected.length;
                                      buttonIndex++) {
                                    isSelected[buttonIndex] =
                                        (buttonIndex == index);
                                  }
                                });
                              },
                              isSelected: isSelected,
                            ),
                          ],
                        );
                      },
                    ), // ToggleButtons(
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date of Birth",
                    style: AppFonts.normalRegularText,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.btnColorSecondary,
                            boxShadow: [
                              AppShadow.innerShadow3,
                            ],
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        Positioned.fill(
                          child: TextButton(
                            onPressed: () => _selectDate(context),
                            style: ButtonStyle(
                              padding:
                                  const MaterialStatePropertyAll(EdgeInsets.zero),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                            ),
                            child: Text(
                              selectedDate != null
                                  ? "${selectedDate.toLocal()}".split(' ')[0]
                                  : "Click to Select Date",
                              style: AppFonts.smallLightText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // DefaultButton(
                  //   press: () => _selectDate(context),
                  //   text: 'Click to Select Date',
                  //   backgroundColor: AppColor.btnColorSecondary,
                  //   height: 55,
                  //   width: double.infinity,
                  //   fontStyle: AppFonts.smallLightText,
                  //   padding: EdgeInsets.zero,
                  // ),
                ],
              ),
            ))
          ],
        ),
        const CustomFormField(
          label: "Email",
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          width: double.infinity,
        ),
        const CustomFormField(
          label: "Password",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          width: double.infinity,
        ),
        const CustomFormField(
          label: "Confirm Password",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          width: double.infinity,
        ),
        const SizedBox(height: 70),
        DefaultButton(
          text: "Sign Up Now",
          backgroundColor: AppColor.btnColorPrimary,
          height: 50,
          width: double.infinity,
          fontStyle: AppFonts.normalRegularTextWhite,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          press: () {
            setState(() {
              navigateNextPage(context, const AuthScreen());
            });
          },
        ),
      ],
    );
  }
}
