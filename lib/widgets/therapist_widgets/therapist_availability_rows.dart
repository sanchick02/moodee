import 'package:flutter/material.dart';
import 'package:moodee/models/therapist_availability_model.dart';
import 'package:moodee/models/therapists_model.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/therapist_widgets/therapist_availability_button.dart';

class AvailabilityRows extends StatefulWidget {
  const AvailabilityRows({Key? key, required this.availabilityList})
      : super(key: key);

  final List<TherapistAvailability> availabilityList;

  @override
  _AvailabilityRowsState createState() => _AvailabilityRowsState();
}
class _AvailabilityRowsState extends State<AvailabilityRows> {
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.availabilityList
          .map((availability) => buildRow(
                availability.date,
                availability.timings,
              ))
          .toList(),
    );
  }

  Widget buildRow(String date, List<String> timings) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40, // Adjust the width based on your layout
            child: Text(
              date,
              style: AppFonts.extraSmallLightText,
            ),
          ),
          ...List.generate(
            timings.length,
            (colIndex) => AvailabilityButton(
              time: timings[colIndex],
              isSelected: timings[colIndex] == selectedTime,
              onPressed: () => onButtonPressed(timings[colIndex]),
            ),
          ),
        ],
      ),
    );
  }

  void onButtonPressed(String time) {
    setState(() {
      selectedTime = selectedTime == time ? null : time;
    });
  }
}
