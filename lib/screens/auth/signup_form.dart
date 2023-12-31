import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/screens/auth/auth.dart';
import 'package:moodee/screens/auth/login_form.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/formfield.dart';
import 'package:moodee/widgets/gender_toggle.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomFormField(
              label: "First Name",
              keyboardType: TextInputType.name,
              obscureText: false,
              width: 165,
            ),
            CustomFormField(
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
        const SizedBox(height: 100),
        DefaultButton(
          text: "Sign Up Now",
          backgroundColor: AppColor.btnColorPrimary,
          height: 50,
          width: double.infinity,
          fontStyle: AppFonts.normalRegularTextWhite,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          press: () {
            setState(() {
              navigateNextPage(context, AuthScreen());
            });
          },
        ),
      ],
    );
  }
}
