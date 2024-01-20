import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/models/therapists_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';

import 'package:moodee/screens/therapist/therapist_details.dart';

class TherapistCard extends StatelessWidget {
  TherapistCard({
    super.key,
    required this.therapistList,
    required this.index,
    required this.margin,
  });

  List<Therapist> therapistList;
  final int index;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    // bool isEvenIndex = index % 2 == 0;
    // bool isOddIndex = !isEvenIndex;

    // EdgeInsets cardMargin = EdgeInsets.only(
    //   left: isEvenIndex ? 15.0 : 0.0,
    //   right: isOddIndex ? 15.0 : 0.0,
    // );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TherapistDetailsScreen(
              index: index,
              therapistList: therapistList,
            ),
          ),
        );
      },
      child: Container(
        margin: margin,
        child: Stack(
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TherapistDetailsScreen(
                                  index: index,
                                  therapistList: therapistList,
                                ),
                              ),
                            );
                          },
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
                      therapistList[index].imageCard,
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
                    left: 10,
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
                            ),
                            Text(
                              Text(therapistList[index].title).data!,
                              style: AppFonts.smallLightText,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "lib/assets/icons/Rating.png",
                                  width: 12,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  therapistList[index].rating.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
