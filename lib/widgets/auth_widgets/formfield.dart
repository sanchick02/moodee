import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final double width;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomFormField({
    Key? key,
    required this.label,
    required this.keyboardType,
    required this.obscureText,
    required this.width,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppFonts.normalRegularText,
              ),
              SizedBox(
                width: width,
                height: 50,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.fontColorSecondary,
                        boxShadow: [
                          AppShadow.innerShadow3,
                        ],
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    TextFormField(
                      controller: controller,
                      validator: validator,
                      obscureText: obscureText,
                      keyboardType: keyboardType,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(999),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: AppFonts.smallRegularText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
