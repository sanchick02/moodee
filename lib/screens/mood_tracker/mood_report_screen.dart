import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moodee/data/mood_tracker.dart';
import 'package:moodee/models/mood_tracker.dart';
import 'package:moodee/models/mood_types_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/providers/mood_tracker_provider.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/mood_tracker_widgets/pop_up_mood_report.dart';
import 'package:provider/provider.dart';

class MoodReportScreen extends StatefulWidget {
  const MoodReportScreen({super.key});

  @override
  State<MoodReportScreen> createState() => _MoodReportScreenState();
}

class _MoodReportScreenState extends State<MoodReportScreen> {
  bool quarterOne = true;
  int year = 2024;

  bool showPopup = false;

  void togglePopUp() {
    setState(() {
      showPopup = !showPopup;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MoodTrackerProvider>(context, listen: false).fetchMoodData();
    var _provider = Provider.of<MoodTrackerProvider>(context, listen: false);
    final moodData = _provider.moodData;

    List<List<MoodTracker>> generateMonthlyMoodData(
        List<MoodTracker> moodData) {
      List<List<MoodTracker>> monthlyMoodData = List.generate(12, (_) => []);
      for (var mood in moodData) {
        int month = DateTime.parse(mood.date).month;
        monthlyMoodData[month - 1].add(
            mood); // Subtracting 1 because months are 1-indexed in DateTime
      }
      return monthlyMoodData;
    }

    final monthlyMoodData = generateMonthlyMoodData(moodData);

    // Function to determine the most frequent mood type in a given month
    String mostFrequentMood(List<MoodTracker> monthMoodData) {
      Map<String, int> moodCount = {};
      monthMoodData.forEach((mood) {
        moodCount[mood.type] = (moodCount[mood.type] ?? 0) + 1;
      });
      var sortedMoodCounts = moodCount.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      return sortedMoodCounts.isNotEmpty
          ? sortedMoodCounts.first.key
          : 'Unknown';
    }

    int selectedMonth = 4;

    List<MoodTypeModel> moodList = moodTypeList;
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final julyOnwards = months.sublist(6);

    int startValue = quarterOne ? 0 : 6;
    int endValue = quarterOne ? 6 : 12;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/assets/images/meshGrad1.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
              child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  "Mood Report",
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
              Text(
                'Hey Sam,',
                style: AppFonts.heading3,
              ),
              Text(
                'Here\'s how you\'ve been doing.',
                style: AppFonts.smallLightText,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  height: 400,
                  width: 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: moodList.length,
                      itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            height: (400 / 9),
                              
                            child: Image.asset(
                              moodList[index].image,
                              height: (400 / 9) ,
                              
                              fit: BoxFit.contain,
                            ),
                        );
                      }),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 15),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 400,
                              width: MediaQuery.of(context).size.width - 65,
                            ),
                            Image.asset(
                                'lib/assets/images/mood_report_grid.png'),
                            for (var i = startValue; i < endValue; i++)
                              Positioned(
                                top: _calculatePositionY(
                                    mostFrequentMood(monthlyMoodData[i]),
                                    context),
                                left: _calculatePositionX(i + 1, context),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedMonth = i;
                                      showPopup = !showPopup;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius:
                                        monthlyMoodData[i].length.toDouble(),
                                    backgroundColor: AppColor.btnColorPrimary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                          child: ListView.builder(
                              itemCount: 6,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 70) /
                                          6,
                                  child: Text(
                                    quarterOne
                                        ? months[index]
                                        : julyOnwards[index],
                                    textAlign: TextAlign.center,
                                    style: AppFonts.extraSmallLightText,
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                )
              ]),
              const SizedBox(height: 25),
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          quarterOne = !quarterOne;
                        });
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        quarterOne
                            ? 'First Half of 2024'
                            : 'Second Half of 2024',
                        style: AppFonts.normalRegularText,
                      ),
                      const SizedBox(
                        width: 250,
                        child: Divider(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Transform.flip(
                    flipX: true,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            quarterOne = !quarterOne;
                          });
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
                Text(
                  textAlign: TextAlign.center,
                  'The bigger the circle, the more mood you have tracked in that particular month. Click on the dots to see more.',
                  style: AppFonts.smallLightText,
                ),
                const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultButton(
                    text: 'Download Report',
                    press: () {},
                    backgroundColor: AppColor.btnColorPrimary,
                    height: 40,
                    fontStyle: AppFonts.normalRegularTextWhite,
                    width: double.infinity,
                    padding: const EdgeInsets.only()),
              )
            ],
          )),
          PopUpMoodReport(
            showPopup: showPopup,
            monthData: monthlyMoodData[selectedMonth],
            onClose: togglePopUp,
          )
          
        ],
      ),
    );
  }
}

// Calculate Y-axis position based on mood type
double _calculatePositionY(String moodType, context) {
  // Implement your logic to map mood types to Y-axis positions
  switch (moodType) {
    case 'Happy':
      return (400 / 18);
    case 'Loved':
      return ((400 / 9) * 1) + (400 / 18); // Middle of the grid
    case 'Excited':
      return ((400 / 9) * 2) + (400 / 18);
    case 'Emotionless':
      return ((400 / 9) * 3) + (400 / 18);
    case 'Sad':
      return ((400 / 9) * 4) + (400 / 18);
    case 'Tired':
      return ((400 / 9) * 5) + (400 / 18);
    case 'Disgusted':
      return ((400 / 9) * 6) + (400 / 18);
    case 'Anxious':
      return ((400 / 9) * 7) + (400 / 18);
    case 'Angry':
      return ((400 / 9) * 8) + (400 / 18);
    default:
      return 0.0;
  }
}

// Calculate X-axis position based on month index
double _calculatePositionX(int monthIndex, context) {
  // Adjust the spacing based on your preference
  return monthIndex * ((MediaQuery.of(context).size.width - 70) / 6) +
      ((MediaQuery.of(context).size.width - 70) / 12);
}
