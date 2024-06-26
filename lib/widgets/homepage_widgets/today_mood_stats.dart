import 'package:moodee/models/mood_tracker.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/providers/mood_tracker_provider.dart';
import 'package:moodee/screens/mood_tracker/mood_report_screen.dart';
import 'package:moodee/screens/mood_tracker/mood_tracker_screen.dart';
import 'package:moodee/widgets/button.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';

class TodayMoodStat extends StatelessWidget {
  const TodayMoodStat({super.key, required this.name});
  final String name;

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<MoodTrackerProvider>(context, listen: false);
    final todayMoodData = _provider.moodData
        .where((mood) => isToday(DateTime.parse(mood.date)))
        .toList();
    final morningData = todayMoodData
        .where(
          (mood) =>
              DateTime.parse(mood.date).isAfter(_provider.morningStart) &&
              DateTime.parse(mood.date).isBefore(_provider.morningEnd),
        )
        .toList();
    final afternoonData = todayMoodData
        .where(
          (mood) =>
              DateTime.parse(mood.date).isAfter(_provider.afternoonStart) &&
              DateTime.parse(mood.date).isBefore(_provider.afteroonEnd),
        )
        .toList();
    final eveningData = todayMoodData
        .where(
          (mood) =>
              DateTime.parse(mood.date).isAfter(_provider.eveningStart) &&
              DateTime.parse(mood.date).isBefore(_provider.eveningEnd),
        )
        .toList();
    final nightData = todayMoodData
        .where(
          (mood) =>
              DateTime.parse(mood.date).isAfter(_provider.nightStart) &&
              DateTime.parse(mood.date).isBefore(_provider.nightEnd),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Today's Mood Stats",
                style: AppFonts.largeMediumText,
              ),
              const Spacer(),
              DefaultButton(
                text: 'View Mood Report',
                press: () {
                  navigateNextPage(context, MoodReportScreen(name: name));
                },
                backgroundColor: AppColor.btnColorPrimary,
                height: 35,
                fontStyle: AppFonts.extraSmallLightTextWhite,
                width: 130,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              checkTimeOfDay(morningData, _provider, _provider.morningStart,
                      _provider.morningEnd)
                  ? MoodStats(
                      backgroundColor: const Color(0xffFCFFD6),
                      data: morningData,
                      timeImage:
                          "lib/assets/images/claudias-part_branch/afternoon.png",
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              checkTimeOfDay(afternoonData, _provider, _provider.afternoonStart,
                      _provider.afteroonEnd)
                  ? MoodStats(
                      backgroundColor: const Color(0xffDBFFD5),
                      data: afternoonData,
                      timeImage:
                          "lib/assets/images/claudias-part_branch/morning.png")
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              checkTimeOfDay(eveningData, _provider, _provider.eveningStart,
                      _provider.eveningEnd)
                  ? MoodStats(
                      backgroundColor: const Color(0xffFFEAD9),
                      data: eveningData,
                      timeImage:
                          "lib/assets/images/claudias-part_branch/afternoon.png")
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              checkTimeOfDay(nightData, _provider, _provider.nightStart,
                      _provider.nightEnd)
                  ? MoodStats(
                      backgroundColor: const Color(0xffD5EBFF),
                      data: nightData,
                      timeImage:
                          "lib/assets/images/claudias-part_branch/night.png")
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          )
        ],
      ),
    );
  }

  bool checkTimeOfDay(List<MoodTracker> timeData, MoodTrackerProvider _provider,
          DateTime isAfter, DateTime isBefore) =>
      timeData.isNotEmpty ||
      (DateTime.now().isAfter(isAfter) && DateTime.now().isBefore(isBefore));
}

class MoodStats extends StatelessWidget {
  final Color backgroundColor;
  final List<MoodTracker> data;
  final String timeImage;

  const MoodStats(
      {required this.backgroundColor,
      required this.data,
      required this.timeImage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 135,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor,
              boxShadow: [AppShadow.innerShadow3]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                timeImage,
                height: 40,
              ),
              Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: data.isNotEmpty
                      ? Image.asset(
                          data[0].image,
                          height: 50,
                        )
                      : IconButton(
                          onPressed: () {
                            navigateNextPage(
                                context, const MoodTrackerScreen());
                          },
                          icon: const Icon(Icons.add_circle_outline_rounded))),
              Text(
                data.isNotEmpty ? data[0].type : 'Add',
                style: AppFonts.extraSmallLightText,
              )
            ],
          ),
        ),
      ),
    );
  }
}
