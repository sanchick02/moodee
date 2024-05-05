import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/music_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/providers/events_provider.dart';
import 'package:moodee/providers/therapist_provider.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:moodee/screens/events/event_screen.dart';
import 'package:moodee/screens/therapist/therapist_call_screen.dart';
import 'package:moodee/screens/therapist/therapist_chat_screen.dart';
import 'package:moodee/screens/therapist/therapist_details.dart';
import 'package:moodee/screens/therapist/therapist_screen.dart';
import 'package:moodee/screens/therapy/therapy_screen.dart';
import 'package:moodee/strings.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/event_widgets/event_card.dart';
import 'package:moodee/widgets/homepage_widgets/mood_tracker_button.dart';
import 'package:moodee/widgets/homepage_widgets/progress_box.dart';
import 'package:moodee/widgets/therapist_widgets/therapist_card.dart';
import 'package:moodee/widgets/therapy_widgets/therapy_card.dart';
import 'package:moodee/widgets/topbar_logo_notif.dart';
import 'package:provider/provider.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/spotify.dart' as spot;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomeScreen<T extends MediaItem> extends StatefulWidget {
  HomeScreen({Key? key, required this.mediaItem, required this.mediaList})
      : super(key: key);

  T mediaItem;
  final List<T> mediaList;

  @override
  State<HomeScreen> createState() => _HomeScreenState<T>();
}

class _HomeScreenState<T extends MediaItem> extends State<HomeScreen<T>> {
  int carouselCurrentIndex = 0;

  List<String> carouselImageUrls = [
    "lib/assets/images/1.png",
    "lib/assets/images/2.png",
    "lib/assets/images/3.png",
    "lib/assets/images/4.png",
  ]; // List to store image URLs

   final List<MoodTracker> moodData = [
    MoodTracker(
      question: '', 
      image: '',
      type: '', 
      answer: '', 
      date: DateTime.now().toString(), 
      moodIntensity: 0, 
      moodTrackerStreak: '', 
      timePeriod: '', 
      userId: '')
  ];

  @override
  void initState() {
    Provider.of<MoodTrackerProvider>(context, listen: false)
        .fetchMoodData()
        .then((_) {
      setState(() {
        moodData;
        // Sorting logic based on the time attribute
        // _registeredExpenses.sort((a, b) => b.time.compareTo(a.time));
      });
    });


  final player = AudioPlayer();
  late Music music;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<TherapistProvider>(context, listen: false).fetchTherapistData();
    Provider.of<EventsProvider>(context, listen: false).fetchEventsData();
    super.initState();

    // Find the corresponding item in the lists based on the trackId
    late MediaItem? item;
    if (widget.mediaItem is MeditationItem) {
      item = meditationList.firstWhere(
        (element) => element.trackId == widget.mediaItem.trackId,
        orElse: () => meditationList[0],
      );
    } else if (widget.mediaItem is MusicItem) {
      item = musicList.firstWhere(
        (element) => element.trackId == widget.mediaItem.trackId,
        orElse: () => musicList[0],
      );
    } else if (widget.mediaItem is StoryItem) {
      item = storyList.firstWhere(
        (element) => element.trackId == widget.mediaItem.trackId,
        orElse: () => storyList[0],
      );
    }

    // Update the music variable if the item is found
    if (item != null) {
      if (item is MeditationItem) {
        music = Music(
          trackId: item.trackId,
          // Add other properties like songName, songImage, etc. here
        );
      } else if (item is MusicItem) {
        music = Music(
          trackId: item.trackId,
          // Add other properties like songName, songImage, etc. here
        );
      } else if (item is StoryItem) {
        music = Music(
          trackId: item.trackId,
          // Add other properties like songName, songImage, etc. here
        );
      }

      final credentials = spot.SpotifyApiCredentials(
          CustomStrings.clientId, CustomStrings.clientSecret);
      final spotify = spot.SpotifyApi(credentials);

      // Fetch additional details from Spotify
      spotify.tracks.get(music.trackId).then((track) async {
        String? tempSongName = track.name;
        if (tempSongName != null) {
          music.songName = tempSongName;
          music.artistName = track.artists?.first.name ?? "";
          String? image = track.album?.images?.first.url;
          if (image != null) {
            music.songImage = image;
            final tempSongColor = await getImagePalette(NetworkImage(image));
            if (tempSongColor != null) {
              music.songColor = tempSongColor;
            }
          }
          music.artistImage = track.artists?.first.images?.first.url;
          final yt = YoutubeExplode();
          final video = (await yt.search
                  .search("$tempSongName ${music.artistName ?? ""}"))
              .first;
          final videoId = video.id.value;
          music.duration = video.duration;
        }
      });
    }
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    var provider2 = Provider.of<TherapistProvider>(
      context,
      listen: false,
    );

    var provider3 = Provider.of<EventsProvider>(
      context,
      listen: false,
    );

    if (provider.userProviderData == '') {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.userProviderData!.therapist_id == '') {}

    String usersTherapist = provider.userProviderData!.therapist_id;
    final int index = provider2.therapistsList
        .indexWhere((element) => element.id == usersTherapist);

    String name = provider.userProviderData!.firstName.toString();

    Widget hasDoctor = GestureDetector(
      onTap: () {
        navigateNextPage(
            context,
            TherapistDetailsScreen(
                index: index, therapistList: provider2.therapistsList));
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Meet Your Therapist",
                      style: AppFonts.largeMediumText,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: AppStyles.borderRadiusAll,
                  boxShadow: [AppShadow.innerShadow3],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "lib/assets/images/meshGrad1.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.userProviderData!.isTherapist == true
                                ? provider2.therapistsList
                                    .firstWhere((element) =>
                                        element.id == usersTherapist)
                                    .name
                                : "Therapist",
                            style: AppFonts.normalRegularTextHeight,
                          ),
                          Text(
                            "Therapist",
                            style: AppFonts.smallLightText,
                          ),
                          Text(
                            provider.userProviderData!.isTherapist == true
                                ? "@ ${provider2.therapistsList.firstWhere((element) => element.id == usersTherapist).workplace}"
                                : "Workplace",
                            style: AppFonts.extraSmallLightText,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    navigateNextPage(
                                        context, const TherapistChatScreen());
                                  },
                                  style: const ButtonStyle(
                                    elevation: MaterialStatePropertyAll(0),
                                  ),
                                  child: Image.asset(
                                    "lib/assets/images/claudias-part_branch/msg.png",
                                    width: 20,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    navigateNextPage(context, const CallPage());
                                  },
                                  style: const ButtonStyle(
                                    elevation: MaterialStatePropertyAll(0),
                                  ),
                                  child: Image.asset(
                                    "lib/assets/images/claudias-part_branch/call.png",
                                    width: 20,
                                  )),
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
          Image.asset(
            provider.userProviderData!.isTherapist == true
                ? provider2.therapistsList
                    .firstWhere((element) => element.id == usersTherapist)
                    .image
                : "lib/assets/images/therapist1.png",
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.7,
          ),
        ],
      ),
    );

    Widget noDoctor = Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Book a Therapist",
            style: AppFonts.largeMediumText,
          ),
          DefaultButton(
            text: "See All",
            press: () {
              navigateNextPage(context, const TherapistScreen()); // not working
            },
            backgroundColor: AppColor.btnColorPrimary,
            height: 35,
            fontStyle: AppFonts.extraSmallLightTextWhite,
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ],
      ),
    );
    const SizedBox(height: 30);

    Widget noDoctor2 = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          provider2.therapistsList.length,
          (index) => TherapistCard(
            therapistList: provider2.therapistsList,
            index: index,
            margin: EdgeInsets.only(
              left: 15,
              right: index == (provider2.therapistsList.length - 1) ? 15 : 0,
            ),
          ),
        ),
      ),
    );

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Good Day, $name!",
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
                  const TodayMoodStat(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Mood Stats",
                          style: AppFonts.largeMediumText,
                        ),
                        DefaultButton(
                          text: "View Mood Report",
                          press: () {},
                          backgroundColor: AppColor.btnColorPrimary,
                          height: 35,
                          fontStyle: AppFonts.extraSmallLightTextWhite,
                          width: 130,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width / 4 - 15),
                          height: MediaQuery.of(context).size.width * 0.35,
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xffFCFFD6),
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [AppShadow.innerShadow3],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/assets/images/claudias-part_branch/afternoon.png",
                                width: MediaQuery.of(context).size.width * 0.13,
                              ),
                              const Spacer(),
                              Image.asset(
                                "lib/assets/images/claudias-part_branch/emoji1.png",
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              const Spacer(),
                              Text(
                                "Happy",
                                style: AppFonts.smallLightText,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width / 4 - 15),
                          height: MediaQuery.of(context).size.width * 0.35,
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xffDBFFD5),
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [AppShadow.innerShadow3],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/assets/images/claudias-part_branch/morning.png",
                                width: MediaQuery.of(context).size.width * 0.13,
                              ),
                              const Spacer(),
                              Image.asset(
                                "lib/assets/images/claudias-part_branch/emoji8.png",
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              const Spacer(),
                              Text(
                                "Anxious",
                                style: AppFonts.smallLightText,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width / 4 - 15),
                          height: MediaQuery.of(context).size.width * 0.35,
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFEAD9),
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [AppShadow.innerShadow3],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/assets/images/claudias-part_branch/afternoon.png",
                                width: MediaQuery.of(context).size.width * 0.13,
                              ),
                              const Spacer(),
                              Image.asset(
                                "lib/assets/images/claudias-part_branch/emoji1.png",
                                width: MediaQuery.of(context).size.width * 0.10,
                              ),
                              const Spacer(),
                              Text(
                                "Happy",
                                style: AppFonts.smallLightText,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width / 4 - 15),
                          height: MediaQuery.of(context).size.width * 0.35,
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xffD5EBFF),
                            borderRadius: AppStyles.borderRadiusAll,
                            boxShadow: [AppShadow.innerShadow3],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/assets/images/claudias-part_branch/night.png",
                                width: MediaQuery.of(context).size.width * 0.13,
                              ),
                              const Spacer(),
                              Image.asset(
                                "lib/assets/images/claudias-part_branch/plus.png",
                                width: MediaQuery.of(context).size.width * 0.08,
                              ),
                              const Spacer(),
                              Text(
                                "Add",
                                style: AppFonts.smallLightText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (provider.userProviderData!.isTherapist == true)
                    hasDoctor
                  else
                    noDoctor,
                  if (provider.userProviderData!.isTherapist == false)
                    noDoctor2,
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Events Nearby",
                          style: AppFonts.largeMediumText,
                        ),
                        DefaultButton(
                          text: "See All",
                          press: () {
                            navigateNextPage(
                                context, const EventScreen()); // not working
                          },
                          backgroundColor: AppColor.btnColorPrimary,
                          height: 35,
                          fontStyle: AppFonts.extraSmallLightTextWhite,
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
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
                              provider3.eventsList.length,
                              (index) => EventCard(
                                eventList: provider3.eventsList,
                                index: index,
                                margin: EdgeInsets.only(
                                  left: 15,
                                  right:
                                      index == provider3.eventsList.length - 1
                                          ? 15
                                          : 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Featured Therapy",
                          style: AppFonts.largeMediumText,
                        ),
                        DefaultButton(
                          text: "See All",
                          press: () {
                            navigateNextPage(
                              context,
                              TherapyScreen(
                                mediaItem: meditationList[0],
                              ),
                            ); // not working
                          },
                          backgroundColor: AppColor.btnColorPrimary,
                          height: 35,
                          fontStyle: AppFonts.extraSmallLightTextWhite,
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
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
                          image: meditationList[0].image,
                          title: meditationList[0].title,
                          singerOrAuthor: meditationList[0].singerOrAuthor,
                        ),
                        TherapyCard(
                          meditationList[1],
                          mediaItem: meditationList[1],
                          margin: const EdgeInsets.only(left: 15),
                          image: meditationList[1].image,
                          title: meditationList[1].title,
                          singerOrAuthor: meditationList[1].singerOrAuthor,
                        ),
                        TherapyCard(
                          musicList[0],
                          mediaItem: musicList[0],
                          margin: const EdgeInsets.only(left: 15),
                          image: musicList[0].image,
                          title: musicList[0].title,
                          singerOrAuthor: musicList[0].singerOrAuthor,
                        ),
                        TherapyCard(
                          musicList[1],
                          mediaItem: musicList[1],
                          margin: const EdgeInsets.only(left: 15),
                          image: musicList[1].image,
                          title: musicList[1].title,
                          singerOrAuthor: musicList[1].singerOrAuthor,
                        ),
                        TherapyCard(
                          storyList[0],
                          mediaItem: storyList[0],
                          margin: const EdgeInsets.only(left: 15),
                          image: storyList[0].image,
                          title: storyList[0].title,
                          singerOrAuthor: storyList[0].singerOrAuthor,
                        ),
                        TherapyCard(
                          storyList[1],
                          mediaItem: storyList[1],
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          image: storyList[1].image,
                          title: storyList[1].title,
                          singerOrAuthor: storyList[1].singerOrAuthor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    // Carousel
                    height: MediaQuery.of(context).size.width * 0.45,
                    width: MediaQuery.of(context).size.width - 30,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CarouselSlider(
                        items: carouselImageUrls.map((imageUrl) {
                          return Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ]);
                        }).toList(),
                        options: CarouselOptions(
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlay: true,
                          height: MediaQuery.of(context).size.width * 0.45,
                          aspectRatio: 2.0,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              carouselCurrentIndex = index;
                            });
                          },
                        ),
                      ),
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
