import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/models/calendar_events_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/widgets/auth_widgets/formfield.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/profile_widgets/calendar_widget.dart';
import 'package:moodee/widgets/profile_widgets/reminder_title_field.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});
  Map<DateTime, List<CalendarEvents>> calendarEventList = {};
  TextEditingController _eventController = TextEditingController();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "My Calendar",
                      style: AppFonts.normalRegularText,
                    ),
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        "lib/assets/icons/arrow_back_gray_small.png",
                        width: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 700,
                  ),
                  Container(
                    width: double.infinity,
                    height: 600,
                    color: AppColor.fontColorSecondary,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 80, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomCalendar(),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        DefaultButton(
                          text: "Add Reminder",
                          press: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  scrollable: true,
                                  insetPadding: EdgeInsets.zero,
                                  content: Column(
                                    children: [
                                      Text(
                                        "Reminder Title",
                                        style: AppFonts.largeMediumText,
                                      ),
                                      const ReminderTitleField(),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      DefaultButton(
                                        text: "Save Reminder",
                                        press: () {
                                          Navigator.of(context).pop();
                                        },
                                        backgroundColor:
                                            AppColor.btnColorPrimary,
                                        height: 40,
                                        fontStyle:
                                            AppFonts.normalRegularTextWhite,
                                        width: double.infinity,
                                        padding: EdgeInsets.zero,
                                      ),
                                    ],
                                  ),
                                  backgroundColor: AppColor.fontColorSecondary,
                                );
                              },
                            );
                          },
                          backgroundColor: AppColor.btnColorPrimary,
                          height: 40,
                          fontStyle: AppFonts.normalRegularTextWhite,
                          width: double.infinity,
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: 15),
                          decoration: BoxDecoration(
                            color: AppColor.fontColorSecondary,
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [
                              AppShadow.innerShadow3,
                              AppShadow.innerShadow4,
                            ],
                          ),
                          child: Text(
                            "Reminder Title",
                            style: AppFonts.smallLightText,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: 15),
                          decoration: BoxDecoration(
                            color: AppColor.fontColorSecondary,
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [
                              AppShadow.innerShadow3,
                              AppShadow.innerShadow4,
                            ],
                          ),
                          child: Text(
                            "Reminder Title",
                            style: AppFonts.smallLightText,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: 15),
                          decoration: BoxDecoration(
                            color: AppColor.fontColorSecondary,
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [
                              AppShadow.innerShadow3,
                              AppShadow.innerShadow4,
                            ],
                          ),
                          child: Text(
                            "Reminder Title",
                            style: AppFonts.smallLightText,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
