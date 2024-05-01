// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/screens/questions/questionnaire_screen.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/auth_widgets/formfield.dart';
import 'package:moodee/widgets/auth_widgets/gender_toggle.dart';

final _firebase = FirebaseAuth.instance;

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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void _signUp() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    final genderMale = isSelected[0];
    String gender = '';
    String dateOfBirth = selectedDate.toLocal().toString().split(' ')[0];
    String age = (DateTime.now().year - selectedDate.year).toString();

    // close keyboard
    FocusScope.of(context).unfocus();

    if (genderMale == true) {
      gender = 'male';
    } else {
      gender = 'female';
    }
    try {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set(
        {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'gender': gender,
          'date_joined': DateTime.now(),
          'last_login': DateTime.now(),
          'profileImageURL': '',
          'date_of_birth': dateOfBirth,
          'age': age,
          'therapist_id': '',
          'is_therapist': false,
          'reserved_event_id': '',
          'wishlist_event_id': '',
          'mood_report_id': '',
          'mood_category_id': '',
          'community_id': '',
        },
      ).then(
        (value) => navigateNextPage(context, const QuestionnaireScreen()),
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        //...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? ' Authentication Failed'),
        ),
      );
    }
  }

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
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomFormField(
              controller: _firstNameController,
              label: "First Name",
              keyboardType: TextInputType.name,
              obscureText: false,
              width: (MediaQuery.of(context).size.width / 2) - 40,
            ),
            const Spacer(),
            CustomFormField(
              controller: _lastNameController,
              label: "Last Name",
              keyboardType: TextInputType.name,
              obscureText: false,
              width: (MediaQuery.of(context).size.width / 2) - 40,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date of Birth",
                    style: AppFonts.normalRegularText,
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 40,
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
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.zero),
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
                ],
              ),
            )
          ],
        ),
        CustomFormField(
          controller: _emailController,
          label: "Email",
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          width: double.infinity,
        ),
        CustomFormField(
          controller: _passwordController,
          label: "Password",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          width: double.infinity,
        ),
        CustomFormField(
          controller: _confirmPasswordController,
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
            _signUp();
          },
        ),
      ],
    );
  }
}
