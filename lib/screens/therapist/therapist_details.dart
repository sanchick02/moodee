import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/models/therapists_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/therapist/filter_button.dart';
import 'package:moodee/widgets/outlined_button.dart';
import 'package:moodee/widgets/therapist_widgets/datetime_dropdown.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/therapist_widgets/review_card.dart';

class TherapistDetailsScreen extends StatefulWidget {
  const TherapistDetailsScreen({
    Key? key,
    required this.index,
    required this.therapistList,
  }) : super(key: key);

  final List<Therapist> therapistList;
  final int index;

  @override
  State<TherapistDetailsScreen> createState() => _TherapistDetailsScreenState();
}

class _TherapistDetailsScreenState extends State<TherapistDetailsScreen> {
  String selectedCategory = "Therapist's Information";
  bool isSelected = false;

  final List<String> items = [
    "10 May 2024, 9AM",
    "10 May 2024, 11AM",
    "10 May 2024, 1PM",
    "11 May 2024, 9AM",
    "11 May 2024, 11AM",
    "11 May 2024, 1PM",
  ];

  String? selectedValue;

  Color _getColorByIndex(int index) {
    List<Color> colors = [
      const Color(0xffFCFFD8),
      const Color(0xffFFEEF2),
      const Color(0xffD4EFFF),
      const Color(0xffE3E7FF),
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.745,
                  child: Stack(
                    children: [
                      Image.asset(
                        "lib/assets/images/meshGrad1.png",
                        height: MediaQuery.of(context).size.width * 0.7,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.7,
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  Text(
                                    "Dr. ${widget.therapistList[widget.index].name}",
                                    style: AppFonts.heading3Height,
                                  ),
                                  Text(
                                    Text(widget
                                            .therapistList[widget.index].title)
                                        .data!,
                                    style: AppFonts.normalRegularText,
                                  ),
                                  Text(
                                    "@ ${widget.therapistList[widget.index].workplace}",
                                    style: AppFonts.extraSmallLightText,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "lib/assets/icons/Rating.png",
                                        width: 12,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        widget
                                            .therapistList[widget.index].rating
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Experience: ${widget.therapistList[widget.index].experience}",
                                    style: AppFonts.extraSmallLightText,
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            alignment: Alignment.bottomCenter,
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.4,
                                maxHeight:
                                    MediaQuery.of(context).size.width * 0.61),
                            child: Image.asset(
                              widget.therapistList[widget.index].image,
                            ),
                          ),
                        ],
                      ),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        title: Text(
                          "Therapist Booking",
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DefaultButton(
                    press: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: AppColor.fontColorSecondary,
                            scrollable: true,
                            title: Text(
                              'Therapist Consultation Reminder',
                              style: AppFonts.largeMediumText,
                              textAlign: TextAlign.center,
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Reminder has been set for you.',
                                  style: AppFonts.smallLightText,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'You will get notified before the consultation.',
                                  style: AppFonts.smallLightText,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            actions: [
                              DefaultButton(
                                backgroundColor: AppColor.btnColorPrimary,
                                text: "Okay",
                                height: 30,
                                fontStyle: AppFonts.smallLightTextWhite,
                                width: double.infinity,
                                padding: EdgeInsets.zero,
                                press: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    text: "Make an Appointment",
                    backgroundColor: AppColor.btnColorPrimary,
                    height: 40,
                    fontStyle: AppFonts.normalRegularTextWhite,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: filterButtonTherapist(
                            "Therapist's Information", isSelected = true,
                            (category) {
                          setState(() {
                            selectedCategory = category;
                          });
                        }, selectedCategory),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: filterButtonTherapist(
                            "Testimonials", isSelected = false, (category) {
                          setState(() {
                            selectedCategory = category;
                          });
                        }, selectedCategory),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            if (selectedCategory == "Therapist's Information") ...[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Consultation Availability",
                          style: AppFonts.normalRegularText,
                        ),
                        Container(
                          width: double.infinity,
                          height: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: AppColor.fontColorPrimary.withOpacity(0.05),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: DateTimeDropdown(
                            items: items,
                            selectedValue: selectedValue,
                            onValueChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Areas of Expertise",
                          style: AppFonts.normalRegularText,
                        ),
                        const SizedBox(height: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget
                                .therapistList[widget.index].areaOfExpertise
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              var area = entry.value;

                              // Extract image and text from the current area of expertise
                              String image = area['image'];
                              String text = area['text'];

                              // Define a color for the container based on its index
                              Color color = _getColorByIndex(index);

                              return Container(
                                width: (MediaQuery.of(context).size.width / 3) -
                                    40,
                                height:
                                    (MediaQuery.of(context).size.height * 0.12),
                                margin: EdgeInsets.only(
                                  left: index == 0 ? 0 : 10,
                                ),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [AppShadow.innerShadow3],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      image,
                                      width: 25,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  3) -
                                              70,
                                      child: Text(
                                        text,
                                        style: AppFonts.extraSmallLightText,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About This Therapist",
                          style: AppFonts.normalRegularText,
                        ),
                        Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(minHeight: 50),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColor.fontColorPrimary.withOpacity(0.05),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            widget
                                .therapistList[widget.index].aboutThisTherapist,
                            style: AppFonts.extraSmallLightText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: OutlinedDefaultButton(
                      press: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColor.fontColorSecondary,
                              scrollable: true,
                              title: Text(
                                'Are You Sure?',
                                style: AppFonts.largeMediumText,
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                children: [
                                  Text(
                                    'Click confirm to cancel this therapist. ',
                                    style: AppFonts.smallLightText,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'You may choose another therapist from the list again on your homepage or the therapist list. ',
                                    style: AppFonts.smallLightText,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actions: [
                                Row(
                                  children: [
                                    DefaultButton(
                                      backgroundColor: AppColor.btnColorPrimary,
                                      text: "Confirm Cancel",
                                      height: 30,
                                      fontStyle: AppFonts.smallLightTextWhite,
                                      width: MediaQuery.of(context).size.width *
                                          0.33,
                                      padding: EdgeInsets.zero,
                                      press: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const Spacer(),
                                    OutlinedDefaultButton(
                                      text: "No",
                                      height: 30,
                                      fontStyle: AppFonts.smallLightText,
                                      width: MediaQuery.of(context).size.width *
                                          0.33,
                                      padding: EdgeInsets.zero,
                                      press: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                      text: "Cancel This Therapist",
                      height: 40,
                      fontStyle: AppFonts.normalRegularText,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ] else if (selectedCategory == "Testimonials") ...[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Testimonials and Reviews",
                          style: AppFonts.normalRegularText,
                        ),
                        const ReviewCard(
                          name: "Angelina Hall",
                          image: "lib/assets/images/user1.png",
                          time: "3 months ago",
                          rating: 5.0,
                          caption:
                              """Embarking on the therapeutic journey with Sheryl has been nothing short of life-changing. Their unwavering dedication to my well-being, coupled with a profound understanding of human psychology, has provided me with invaluable insights and tools to navigate life's challenges with newfound strength and clarity.

From the very first session, I felt seen, heard, and understood in ways I never thought possible. Sheryl's empathetic approach and genuine commitment to my growth have created a safe and nurturing space where I can explore my deepest thoughts and emotions without fear of judgment.

Through their expert guidance, I've gained a deeper understanding of myself, developed healthier coping mechanisms, and forged a path towards healing and self-acceptance.""",
                        ),
                        const ReviewCard(
                          name: "Angelina Hall",
                          image: "lib/assets/images/user1.png",
                          time: "3 months ago",
                          rating: 5.0,
                          caption:
                              """Embarking on the therapeutic journey with Sheryl has been nothing short of life-changing. Their unwavering dedication to my well-being, coupled with a profound understanding of human psychology, has provided me with invaluable insights and tools to navigate life's challenges with newfound strength and clarity.

From the very first session, I felt seen, heard, and understood in ways I never thought possible. Sheryl's empathetic approach and genuine commitment to my growth have created a safe and nurturing space where I can explore my deepest thoughts and emotions without fear of judgment.

Through their expert guidance, I've gained a deeper understanding of myself, developed healthier coping mechanisms, and forged a path towards healing and self-acceptance.""",
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
