import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/navigation.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/models/therapists_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/providers/therapist_provider.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/screens/therapist/filter_button.dart';
import 'package:moodee/widgets/outlined_button.dart';
import 'package:moodee/widgets/therapist_widgets/datetime_dropdown.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/therapist_widgets/review_card.dart';
import 'package:provider/provider.dart';

bool condition = false;

User? user = FirebaseAuth.instance.currentUser;

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
  bool dateSelected = false;
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

  void bookTherapist() async {
    if (dateSelected == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColor.fontColorSecondary,
            scrollable: true,
            title: Text(
              'Select a Date and Time',
              style: AppFonts.largeMediumText,
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                Text(
                  'Please select a date and time for your consultation.',
                  style: AppFonts.smallLightText,
                  textAlign: TextAlign.center,
                ),
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
      return;
    }

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
                press: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .update({
                    'therapist_id': widget.therapistList[widget.index].id,
                    'is_therapist': true,
                    'therapist_datetime': selectedValue,
                  }).then((value) =>
                          navigateNextPage(context, const Navigation()));
                },
              ),
            ],
          );
        });
  }

  void cancelTherapist() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColor.fontColorSecondary,
            scrollable: true,
            title: Text(
              'Therapist Consultation Cancellation',
              style: AppFonts.largeMediumText,
              textAlign: TextAlign.center,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Are you sure to cancel it?',
                  style: AppFonts.smallLightText,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'You can find a new therapist if you wish later.',
                  style: AppFonts.smallLightText,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            actions: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    DefaultButton(
                      backgroundColor: AppColor.btnColorPrimary,
                      text: "Okay",
                      height: 30,
                      fontStyle: AppFonts.smallLightTextWhite,
                      width: MediaQuery.of(context).size.width * 0.33,
                      padding: EdgeInsets.zero,
                      press: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .update({
                          'therapist_id': '',
                          'is_therapist': false,
                          'therapist_datetime': '',
                        }).then((value) =>
                                navigateNextPage(context, const Navigation()));
                      },
                    ),
                    const Spacer(),
                    OutlinedDefaultButton(
                      text: "No",
                      height: 30,
                      fontStyle: AppFonts.smallLightText,
                      width: MediaQuery.of(context).size.width * 0.33,
                      padding: EdgeInsets.zero,
                      press: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TherapistProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    Widget cancel = OutlinedDefaultButton(
      press: () {
        cancelTherapist();
      },
      text: "Cancel This Therapist",
      height: 40,
      fontStyle: AppFonts.normalRegularText,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
    );

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
                Visibility(
                  visible: userProvider.userProviderData!.isTherapist == false,
                  replacement: const SizedBox.shrink(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DefaultButton(
                      press: () {
                        bookTherapist();
                      },
                      text: "Make an Appointment",
                      backgroundColor: dateSelected
                          ? AppColor.btnColorPrimary
                          : AppColor.backgroundColor,
                      height: 40,
                      fontStyle: AppFonts.normalRegularTextWhite,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
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
                        Visibility(
                          visible: userProvider.userProviderData!.isTherapist ==
                              false,
                          replacement: Text(
                            "Your Consultation Session is on ${userProvider.userProviderData!.therapist_datetime}",
                            style: AppFonts.normalRegularText,
                          ),
                          child: Visibility(
                            visible:
                                userProvider.userProviderData!.isTherapist ==
                                    false,
                            child: Text(
                              "Consultation Availability",
                              style: AppFonts.normalRegularText,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: userProvider.userProviderData!.isTherapist ==
                              false,
                          child: Container(
                            width: double.infinity,
                            height: 70,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color:
                                  AppColor.fontColorPrimary.withOpacity(0.05),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: DateTimeDropdown(
                              items: provider
                                  .therapistsList[widget.index].availability,
                              selectedValue: selectedValue,
                              onValueChanged: (String? value) {
                                setState(() {
                                  selectedValue = value;
                                  dateSelected = true;
                                });
                              },
                            ),
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
                    child:
                        (!userProvider.userProviderData!.isTherapist == false)
                            ? cancel
                            : const SizedBox(),
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
                        for (var testimonial
                            in widget.therapistList[widget.index].testimonial)
                          ReviewCard(
                            name: testimonial.uid,
                            image: "lib/assets/images/user1.png",
                            time: "3 months ago",
                            rating: testimonial.rating,
                            caption: testimonial.testimonialText,
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
