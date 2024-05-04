import 'dart:ui';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';
import 'package:moodee/models/mood_tracker.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:collection/collection.dart';

class PopUpMoodReport extends StatefulWidget {
  PopUpMoodReport({
    super.key,
    required this.showPopup,
    required this.monthData,
    // required this.month,
    // required this.year
    });

  bool showPopup;
  List<MoodTracker> monthData;

  @override
  State<PopUpMoodReport> createState() => _PopUpMoodReportState();
}

class _PopUpMoodReportState extends State<PopUpMoodReport> {

  String month = '';
  String year = '';
  Map<String, double> moodCounts = {};

  @override
  void initState() {
    super.initState();
    if (widget.monthData.isNotEmpty) {
      widget.monthData.forEach((moodTracker) {
        moodCounts.update(moodTracker.type, (value) => value + 1, ifAbsent: () => 1);
      });
      month = DateFormat('MMMM').format(DateTime.parse(widget.monthData[0].date));
      year = DateFormat('yyyy').format(DateTime.parse(widget.monthData[0].date));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.showPopup,
      child: Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Material(
          color: Colors.white, // Adjust transparency
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Center(
              // Your custom top widget here (e.g., Textfield, Dialog)
              child: Stack(
                children : [
                    Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        AppShadow.innerShadow1,
                        AppShadow.innerShadow3,
                      ], 
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            month + ' ' + year,
                            style: AppFonts.largeMediumText,
                          ),
                          Text(
                            'All your moods at a glance',
                            style: AppFonts.smallLightText,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PieChart(
                              dataMap: moodCounts,
                              chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: false,
                              showChartValuesInPercentage: true,
                              decimalPlaces: 1,
                            ),
                              legendOptions: const LegendOptions(
                                legendShape: BoxShape.rectangle,
                              ),
                              ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          widget.showPopup = !widget.showPopup;
                        });
                      },
                    ))
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}