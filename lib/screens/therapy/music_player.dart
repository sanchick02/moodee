import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:moodee/strings.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/music_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/widgets/back_button_top.dart';
import 'package:moodee/widgets/rounded_button.dart';
import 'package:moodee/widgets/therapy_widgets/player_logo_and_title.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/spotify.dart' as spot;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'package:moodee/widgets/therapy_widgets/art_work_image.dart';

class MusicPlayer<T extends MediaItem> extends StatefulWidget {
  T mediaItem;
  final List<T> mediaList;

  MusicPlayer({Key? key, required this.mediaItem, required this.mediaList})
      : super(key: key);

  @override
  State<MusicPlayer<T>> createState() => _MusicPlayerState<T>();
}

class _MusicPlayerState<T extends MediaItem> extends State<MusicPlayer<T>> {
  int currentTherapyIndex = 0;
  final player = AudioPlayer();
  late Music music;
  bool isButtonClicked = false;
  Map<String, List<MediaItem>> therapyLists = {};
  bool isNewSong = false;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initLists();
    _initPlayer();
  }

  void _initLists() {
    therapyLists = {
      'Music': widget.mediaList.cast<MusicItem>(), // Specific casts, safe now
      'Meditation': widget.mediaList.cast<MeditationItem>(),
      'Story': widget.mediaList.cast<StoryItem>(),
    };
  }

  void _onPreviousTrack() async {
    await player.stop();
    setState(() {
      String currentType = widget.mediaItem.therapyType;
      List<MediaItem>? currentList = therapyLists[currentType];

      if (currentList != null) {
        currentTherapyIndex--;
        if (currentTherapyIndex < 0) {
          currentTherapyIndex = currentList.length - 1; // Go to last track
        }

        _updatePlayer(currentList[currentTherapyIndex]);
      }
    });
  }

  void _onNextTrack() async {
    await player.stop();
    setState(() {
      String currentType = widget.mediaItem.therapyType;
      List<MediaItem>? currentList = therapyLists[currentType];

      if (currentList != null) {
        currentTherapyIndex++;
        if (currentTherapyIndex >= currentList.length) {
          currentTherapyIndex = 0; // Reset to first track
        }

        _updatePlayer(currentList[currentTherapyIndex]);
      }
    });
  }

  void _updatePlayer(MediaItem newItem) {
    setState(() {
      widget.mediaItem = newItem as T;
      _initPlayer();
      isNewSong = true;
    });
  }

  void _initPlayer() async {
    final credentials = spot.SpotifyApiCredentials(
        CustomStrings.clientId, CustomStrings.clientSecret);
    final spotify = spot.SpotifyApi(credentials);
    music = Music(trackId: widget.mediaItem.trackId);

    try {
      final track = await spotify.tracks.get(music.trackId);
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
        final searchResults =
            await yt.search.search("$tempSongName ${music.artistName ?? ""}");

        if (searchResults.isNotEmpty) {
          final video = searchResults.first;
          final videoId = video.id.value;
          music.duration = video.duration;
          var manifest = await yt.videos.streamsClient.getManifest(videoId);
          var audioUrl = manifest.audioOnly.last.url;
          player.play(UrlSource(audioUrl.toString()));
          // Reset the button state when starting a new song
          setState(() {
            isButtonClicked = false;
            isNewSong = false; // Reset the new song flag
          });
        } else {
          // Move to the next track
          _onNextTrack();
        }
      }
    } catch (e) {
      // Handle exceptions here
      _initPlayer();
      print("Error initializing player: $e");
    }
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "lib/assets/images/meshGrad1.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    BackButtonTop(
                      onBackButtonPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              PlayerLogoAndTitle(
                  title: Text(widget.mediaItem.therapyType).data!),
              const Row(
                mainAxisSize: MainAxisSize.min,
              ),
              SizedBox.square(
                dimension: MediaQuery.sizeOf(context).width - 40,
                child: Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: ArtWorkImage(image: music.songImage),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width - 40,
                              child: Text(
                                music.songName ?? '',
                                style: AppFonts.largeMediumText,
                              ),
                            ),
                            Text(
                              music.artistName ?? '-',
                              style: AppFonts.smallRegularText,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 22.0),
                child: StreamBuilder(
                    stream: player.onPositionChanged,
                    builder: (context, data) {
                      return ProgressBar(
                        progress: data.data ?? const Duration(seconds: 0),
                        total: music.duration ?? const Duration(minutes: 4),
                        bufferedBarColor: Colors.white38,
                        baseBarColor: Colors.white10,
                        thumbColor: Colors.white,
                        timeLabelTextStyle:
                            const TextStyle(color: Colors.white),
                        progressBarColor: Colors.white,
                        onSeek: (duration) {
                          player.seek(duration);
                        },
                      );
                    }),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: AppStyles.edgeInsetsLR,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      image: Image.asset(
                        "lib/assets/icons/player_prev_icon.png",
                        width: 30,
                      ),
                      color: AppColor.btnColorSecondary,
                      press: _onPreviousTrack,
                    ),
                    const SizedBox(width: 30),
                    RoundedButton(
                      press: () async {
                        if (player.state == PlayerState.playing) {
                          await player.pause();
                        } else {
                          await player.resume();
                        }
                        setState(() {
                          isButtonClicked = !isButtonClicked;
                        });
                      },
                      color: AppColor.fontColorPrimary,
                      image: (isButtonClicked ||
                              isNewSong) // Condition for play/pause icons
                          ? Image.asset(
                              "lib/assets/icons/player_pause_icon.png",
                              width: 20,
                            )
                          : Image.asset(
                              "lib/assets/icons/player_play_icon.png",
                              width: 20,
                            ),
                    ),
                    const SizedBox(width: 30),
                    RoundedButton(
                      image: Image.asset(
                        "lib/assets/icons/player_next_icon.png",
                        width: 30,
                      ),
                      color: AppColor.btnColorSecondary,
                      press: _onNextTrack,
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
