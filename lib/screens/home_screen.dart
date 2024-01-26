import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/therapists.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/nav_bar.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/screens/events/event_screen.dart';
import 'package:moodee/screens/therapist/therapist_screen.dart';
import 'package:moodee/screens/therapy/therapy_screen.dart';
import 'package:moodee/widgets/event_widgets/event_card.dart';
import 'package:moodee/widgets/homepage_widgets/mood_tracker_button.dart';
import 'package:moodee/widgets/homepage_widgets/progress_box.dart';
import 'package:moodee/widgets/homepage_widgets/see_all_button_homepage.dart';
import 'package:moodee/widgets/therapist_widgets/therapist_card.dart';
import 'package:moodee/widgets/therapy_widgets/therapy_card.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';
import 'package:moodee/data/events.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int carouselCurrentIndex = 0;

  List<String> carouselImageUrls = [
    "lib/assets/images/1.png",
    "lib/assets/images/2.png",
    "lib/assets/images/3.png",
    "lib/assets/images/4.png",
  ]; // List to store image URLs

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<UserProvider>(context, listen: false);

    if (_provider.userProviderData == '') {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    String name = _provider.userProviderData!.firstName.toString();
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
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
                          "Good Day, $name", // changed this
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
                        Expanded(flex: 1, child: MoodTrackerButton()),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(flex: 2, child: ProgressBox()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    // Carousel
                    height: 180,
                    width: 370,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CarouselSlider(
                          items: carouselImageUrls.map((imageUrl) {
                            return Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    AppShadow.innerShadow1,
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ]);
                          }).toList(),
                          options: CarouselOptions(
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlay: true,
                            height: 180,
                            aspectRatio: 2.0,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                carouselCurrentIndex = index;
                              });
                            },
                          ),
                        )),
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
                                context, const EventScreen()); // not working
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

// Future<List<String>> fetchImageUrls() async {
//   List<String> imageUrls = [];
//   try {
//     // Assuming you have images stored in Firebase Storage under a certain path
//     ListResult result =
//         await FirebaseStorage.instance.ref('carousel_images').listAll();

//     for (Reference ref in result.items) {
//       String imageUrl = await ref.getDownloadURL();
//       imageUrls.add(imageUrl);
//     }
//   } catch (e) {
//     print('Error fetching image URLs: $e');
//   }
//   return imageUrls;
// }
