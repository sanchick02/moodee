import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/auth/login_form.dart';
import 'package:moodee/screens/auth/signup_form.dart';
import 'package:moodee/widgets/divider_line.dart';
import 'package:moodee/widgets/toggle_switch.dart';
import 'package:moodee/widgets/topbar.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isMember = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(
              title: isMember ? "LOGIN" : "SIGN UP",
              padding: isMember
                  ? const EdgeInsets.only(right: 114)
                  : const EdgeInsets.only(right: 94.5),
              onBackButtonPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Already have an account?",
                        style: AppFonts.normalRegularText,
                      ),
                      const Expanded(child: SizedBox()),
                      switchForm(context),
                    ],
                  ),
                  const DividerLine(),
                  Column(
                    children: [
                      isMember ? const LoginForm() : const SignUpForm(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ToggleSwitch switchForm(BuildContext context) {
    return ToggleSwitch(
      isMember: isMember,
      onToggle: (value) {
        setState(() {
          isMember = value;
        });
      },
    );
  }
}
