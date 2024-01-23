import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:moodee/navigation.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/home_screen.dart';
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

  void _signUp() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    final genderMale = isSelected[0];
    String gender = '';

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
        },
      ).then(
        (value) => navigateNextPage(
          context,
          const Navigation(),
        ),
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
              validator: (p0) {
                if (p0!.isEmpty) {
                  return "Please enter your first name";
                }
                return null;
              },
              label: "First Name",
              keyboardType: TextInputType.name,
              obscureText: false,
              width: 165,
            ),
            CustomFormField(
              controller: _lastNameController,
              label: "Last Name",
              keyboardType: TextInputType.name,
              obscureText: false,
              width: 165,
            ),
          ],
        ),
        Row(
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
                      return GenderToggle(
                        onPressed: (index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < isSelected.length;
                                buttonIndex++) {
                              isSelected[buttonIndex] = (buttonIndex == index);
                            }
                          });
                        },
                        isSelected: isSelected,
                      );
                    },
                  ), // ToggleButtons(
                ],
              ),
            ),
          ],
        ),
        CustomFormField(
          controller: _emailController,
          validator: (p0) {
            if (p0!.isEmpty) {
              return "Please enter your email";
            }
            return null;
          },
          label: "Email",
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          width: double.infinity,
        ),
        CustomFormField(
          controller: _passwordController,
          validator: (p0) {
            if (p0!.isEmpty) {
              return "Please enter your password";
            }
            return null;
          },
          label: "Password",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          width: double.infinity,
        ),
        CustomFormField(
          controller: _confirmPasswordController,
          validator: (p0) {
            if (p0!.isEmpty || p0 != _passwordController.text) {
              return "Please confirm your password";
            }
            return null;
          },
          label: "Confirm Password",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          width: double.infinity,
        ),
        const SizedBox(height: 100),
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
