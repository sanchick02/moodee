import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/services/database.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/profile_widgets/reminder_title_field.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  TextEditingController _reminderController = TextEditingController();

  // To store the events created
  Map<DateTime?, List<String>> _remindersMap = {};
  List<String> reminders = [];

  DateTime _normalizeDateTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  Future<void> _fetchRemindersFromFirebase() async {
    try {
      Map<DateTime?, List<String>> remindersFromFirebase =
          await DatabaseService().fetchReminders();

      print("Selected Day: $_selectedDay");
      print("Reminders from Firebase: $remindersFromFirebase");

      setState(() {
        _remindersMap = remindersFromFirebase;
        reminders = _remindersMap[_selectedDay] ?? [];
        print("Updated reminders: $reminders");
      });
    } catch (e) {
      print("Error fetching reminders: $e");
      // Handle the error as needed
    }
  }

  @override
  void initState() {
    super.initState();

    // Fetch reminders from Firebase when the screen is initialized
    _fetchRemindersFromFirebase();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    DateTime normalizedDay = _normalizeDateTime(day);

    setState(() {
      _focusedDay = focusedDay;
      _selectedDay = normalizedDay;

      // Get reminders for the selected day or initialize an empty list
      reminders = _remindersMap[_selectedDay] ?? [];

      // Show or process reminders as needed
      print("Reminders for $_selectedDay: $reminders");
    });
  }

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
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            color: AppColor.fontColorSecondary,
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [
                              AppShadow.innerShadow3,
                              AppShadow.innerShadow4,
                            ],
                          ),
                          child: Column(
                            children: [
                              TableCalendar(
                                selectedDayPredicate: (day) =>
                                    isSameDay(day, _focusedDay),
                                focusedDay: _focusedDay,
                                firstDay: DateTime.utc(2024, 01, 01),
                                lastDay: DateTime.utc(2025, 12, 31),
                                rowHeight: 43,
                                headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                ),
                                availableGestures: AvailableGestures.all,
                                onDaySelected: _onDaySelected,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
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
                                      ReminderTitleField(
                                        controller: _reminderController,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      DefaultButton(
                                        text: "Save Reminder",
                                        press: () async {
                                          if (_reminderController
                                              .text.isNotEmpty) {
                                            // Use the _selectedDay from the state
                                            String docId =
                                                await DatabaseService()
                                                    .updateUserData(
                                              _selectedDay!,
                                              _reminderController.text,
                                            );

                                            // Clear the reminder text field
                                            _reminderController.clear();

                                            // Fetch reminders after saving a new one
                                            _fetchRemindersFromFirebase();
                                          } else {
                                            // Handle the case where the reminder title is empty
                                            print(
                                                "Reminder title is empty. Reminder not saved.");
                                          }
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
                        const SizedBox(
                          height: 5,
                        ),
                        for (String reminder in reminders)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            width: double.infinity,
                            constraints: const BoxConstraints(minHeight: 50),
                            decoration: BoxDecoration(
                              color: AppColor.fontColorSecondary,
                              borderRadius: AppStyles.borderRadiusAll,
                              boxShadow: [
                                AppShadow.innerShadow3,
                                AppShadow.innerShadow4,
                              ],
                            ),
                            child: Text(
                              reminder,
                              style: AppFonts.smallLightText,
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
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
