import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/models/therapists_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/screens/therapist/popup_therapist.dart';

class TherapistCard extends StatelessWidget {
  TherapistCard({
    super.key,
    required this.therapistList,
    required this.index,
  });

  List<Therapist> therapistList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 230,
          width: 180,
          decoration: BoxDecoration(
            color: AppColor.btnColorSecondary,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              AppShadow.innerShadow3,
              AppShadow.innerShadow4,
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 5,
              left: 20,
            ),
            child: Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("View More"),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const PopUpTherapist(); // Your custom popup content
                          },
                        );
                      }, // open pop up
                      icon: Image.asset(
                        "lib/assets/icons/arrow_next_gray_small.png",
                        width: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: AppStyles.borderRadiusTop,
                boxShadow: [
                  AppShadow.innerShadow3,
                  AppShadow.innerShadow4,
                ],
              ),
              child: ClipRRect(
                borderRadius: AppStyles.borderRadiusTop,
                child: Image.asset(
                  therapistList[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 180,
              width: 180,
              padding: const EdgeInsets.only(
                top: 50,
                right: 15,
                left: 15,
                bottom: 15,
              ),
              decoration: const BoxDecoration(
                borderRadius: AppStyles.borderRadiusTop,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 130,
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Text(therapistList[index].name).data!,
                          style: AppFonts.normalRegularText,
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    Text(therapistList[index].title).data!,
                    style: AppFonts.smallLightText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AvailabilityButton extends StatefulWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onPressed;

  const AvailabilityButton({super.key, 
    required this.time,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  _AvailabilityButtonState createState() => _AvailabilityButtonState();
}

class _AvailabilityButtonState extends State<AvailabilityButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 20,
      child: TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(
            widget.isSelected
                ? AppColor.backgroundColor
                : AppColor.btnColorSecondary,
          ),
        ),
        child: Text(
          widget.time,
          style: AppFonts.extraSmallLightText,
        ),
      ),
    );
  }
}

class AvailabilityRows extends StatefulWidget {
  const AvailabilityRows({super.key});

  @override
  _AvailabilityRowsState createState() => _AvailabilityRowsState();
}

class _AvailabilityRowsState extends State<AvailabilityRows> {
  String selectedTime = ""; // Track the selected time for each row

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRow("Jan 01", ["09:00", "10:00", "11:00", "12:00"]),
        const SizedBox(height: 5),
        buildRow("Jan 02", ["13:00", "14:00", "15:00", "16:00"]),
        const SizedBox(height: 5),
        buildRow("Jan 03", ["17:00", "18:00", "19:00", "20:00"]),
      ],
    );
  }

  Widget buildRow(String date, List<String> times) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 40,
          child: Text(
            date,
            style: AppFonts.extraSmallLightText,
          ),
        ), // Display the date at the beginning of the row
        ...List.generate(
          times.length,
          (colIndex) => AvailabilityButton(
            time: times[colIndex],
            isSelected: selectedTime == times[colIndex],
            onPressed: () => onButtonPressed(times[colIndex]),
          ),
        ),
      ],
    );
  }

  void onButtonPressed(String time) {
    setState(() {
      selectedTime = time;
    });
  }
}
