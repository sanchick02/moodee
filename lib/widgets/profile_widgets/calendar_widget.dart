// import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
// import 'package:moodee/models/calendar_events_model.dart';
// import 'package:moodee/presets/colors.dart';
// import 'package:moodee/presets/shadow.dart';
// import 'package:moodee/presets/styles.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CustomCalendar extends StatefulWidget {
//   const CustomCalendar({
//     super.key,
//   });

//   @override
//   State<CustomCalendar> createState() => _CustomCalendarState();
// }

// class _CustomCalendarState extends State<CustomCalendar> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   // To store the events created
//   Map<DateTime, List<CalendarEvents>> calendarEventList = {};

//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _focusedDay;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void _onDaySelected(DateTime day, DateTime focusedDay) {
//     setState(() {
//       _focusedDay = focusedDay;
//       _selectedDay = day; // Update _selectedDay when a day is selected
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 350,
//           decoration: BoxDecoration(
//             color: AppColor.fontColorSecondary,
//             borderRadius: AppStyles.borderRadiusAll,
//             boxShadow: [
//               AppShadow.innerShadow3,
//               AppShadow.innerShadow4,
//             ],
//           ),
//           child: Column(
//             children: [
//               TableCalendar(
//                 selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
//                 focusedDay: _focusedDay,
//                 firstDay: DateTime.utc(2024, 01, 01),
//                 lastDay: DateTime.utc(2025, 12, 31),
//                 rowHeight: 43,
//                 headerStyle: const HeaderStyle(
//                   formatButtonVisible: false,
//                   titleCentered: true,
//                 ),
//                 availableGestures: AvailableGestures.all,
//                 onDaySelected: _onDaySelected,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }