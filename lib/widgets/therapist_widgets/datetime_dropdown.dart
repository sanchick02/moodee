import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/divider_line.dart';

class DateTimeDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onValueChanged;

  const DateTimeDropdown({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton2<String>(
          // Adult dropdown
          underline: const DividerLine(),
          iconStyleData: IconStyleData(
            icon: Image.asset(
              "lib/assets/icons/arrowdown.png",
              width: 13,
            ),
          ),
          isExpanded: true,
          hint: Text(
            'Select Date and Time',
            style: AppFonts.smallLightText,
            textAlign: TextAlign.center,
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: AppFonts.smallLightText,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: onValueChanged,
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2,
            ),
            height: 60,
            width: MediaQuery.of(context).size.width - 60,
          ),
          menuItemStyleData: const MenuItemStyleData(height: 35),
        ),
      ],
    );
  }
}
