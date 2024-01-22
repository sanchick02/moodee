import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/therapists.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/screens/events/event_screen.dart';
import 'package:moodee/screens/therapist/therapist_screen.dart';
import 'package:moodee/screens/therapy/therapy_screen.dart';
import 'package:moodee/widgets/event_widgets/event_card.dart';
import 'package:moodee/widgets/homepage_widgets/mood_tracker_button.dart';
import 'package:moodee/widgets/homepage_widgets/progress_box.dart';
import 'package:moodee/widgets/homepage_widgets/see_all_button_homepage.dart';
import 'package:moodee/nav_bar.dart';
import 'package:moodee/widgets/therapist_widgets/therapist_card.dart';
import 'package:moodee/widgets/therapy_widgets/therapy_card.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';
import 'package:moodee/data/events.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          navbarNavigation(context, 0, index);
        },
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TopBarLogoNotif(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Good Day, Sam!",
                          style: AppFonts.largeMediumText,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MoodTrackerButton(),
                        ProgressBox(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    // Carousel
                    height: 180,
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "lib/assets/images/Carousel.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Events Nearby",
                          style: AppFonts.largeMediumText,
                        ),
                        SeeAllButtonHomepage(
                          press: () {
                            navigateNextPage(
                                context, EventScreen()); // not working
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              eventList.length,
                              (index) => EventCard(
                                eventList: eventList,
                                index: index,
                                margin: EdgeInsets.only(
                                  left: 15,
                                  right: index == eventList.length - 1 ? 15 : 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book a Therapist",
                          style: AppFonts.largeMediumText,
                        ),
                        SeeAllButtonHomepage(
                          press: () {
                            navigateNextPage(
                                context, TherapistScreen()); // not working
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        therapistList.length,
                        (index) => TherapistCard(
                          therapistList: therapistList,
                          index: index,
                          margin: EdgeInsets.only(
                            left: 15,
                            right: index == eventList.length - 1 ? 15 : 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Featured Therapy",
                          style: AppFonts.largeMediumText,
                        ),
                        SeeAllButtonHomepage(
                          press: () {
                            navigateNextPage(
                              context,
                              TherapyScreen(
                                mediaItem: meditationList[0],
                              ),
                            ); // not working
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TherapyCard(
                          meditationList[0],
                          mediaItem: meditationList[0],
                          margin: const EdgeInsets.only(left: 15),
                        ),
                        TherapyCard(
                          meditationList[1],
                          mediaItem: meditationList[1],
                          margin: const EdgeInsets.only(left: 15),
                        ),
                        TherapyCard(
                          musicList[0],
                          mediaItem: musicList[0],
                          margin: const EdgeInsets.only(left: 15),
                        ),
                        TherapyCard(
                          musicList[1],
                          mediaItem: musicList[1],
                          margin: const EdgeInsets.only(left: 15),
                        ),
                        TherapyCard(
                          storyList[0],
                          mediaItem: storyList[0],
                          margin: const EdgeInsets.only(left: 15),
                        ),
                        TherapyCard(
                          storyList[1],
                          mediaItem: storyList[1],
                          margin: const EdgeInsets.only(left: 15, right: 15),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
