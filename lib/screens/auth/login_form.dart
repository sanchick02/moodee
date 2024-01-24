import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodee/auth_widget_tree.dart';
import 'package:moodee/navigation.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/auth_widgets/formfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // close keyboard
    FocusScope.of(context).unfocus();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) => navigateNextPage(
              context,
              const AuthWidgetTree(),
            ),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                "Forgot Password",
                style: AppFonts.smallLightText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        DefaultButton(
          text: "Login Now",
          backgroundColor: AppColor.btnColorPrimary,
          height: 50,
          width: double.infinity,
          fontStyle: AppFonts.normalRegularTextWhite,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          press: () {
            _login();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                "OR",
                style: AppFonts.smallLightText,
              ),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: () {},
          style: ButtonStyle(
            side: MaterialStatePropertyAll(
              BorderSide(
                width: 1,
                color: AppColor.fontColorPrimary,
              ),
            ),
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 50),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 3, right: 5),
                child: Image.asset(
                  "lib/assets/icons/google_icon.png",
                  width: 35,
                ),
              ),
              Text(
                "Sign in with Google",
                style: AppFonts.normalRegularText,
              )
            ],
          ),
        ),
      ],
    );
  }
}
