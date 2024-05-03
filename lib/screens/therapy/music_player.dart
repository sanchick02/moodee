import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:moodee/constants/strings.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/music_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/presets/colors.dart';
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
  final player = AudioPlayer();
  late Music music;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final credentials = spot.SpotifyApiCredentials(
        CustomStrings.clientId, CustomStrings.clientSecret);
    final spotify = spot.SpotifyApi(credentials);
    music = Music(trackId: widget.mediaItem.trackId);
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
        final video =
            (await yt.search.search("$tempSongName ${music.artistName ?? ""}"))
                .first;
        final videoId = video.id.value;
        music.duration = video.duration;
        setState(() {});
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.last.url;
        player.play(UrlSource(audioUrl.toString()));
      }
    });
    super.initState();
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    int currentTherapyIndex = 0;
    bool isButtonClicked = false;
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
                padding: const EdgeInsets.only(left: 22.5, right: 22.5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              music.songName ?? '',
                              style: textTheme.titleLarge
                                  ?.copyWith(color: Colors.black87),
                            ),
                            Text(
                              music.artistName ?? '-',
                              style: textTheme.titleMedium
                                  ?.copyWith(color: Colors.black45),
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

                      press: () {
                        setState(() {
                          currentTherapyIndex--;

                          if (widget.mediaItem is MusicItem) {
                            List<MusicItem> musicList =
                                widget.mediaList as List<MusicItem>;
                            if (currentTherapyIndex < 0) {
                              currentTherapyIndex = musicList.length - 1;
                            }
                            MusicItem prevItem = musicList[currentTherapyIndex];
                            widget.mediaItem = prevItem as T;
                          } else if (widget.mediaItem is MeditationItem) {
                            List<MeditationItem> meditationList =
                                widget.mediaList as List<MeditationItem>;
                            if (currentTherapyIndex < 0) {
                              currentTherapyIndex = meditationList.length - 1;
                            }
                            MeditationItem prevItem =
                                meditationList[currentTherapyIndex];
                            widget.mediaItem = prevItem as T;
                          } else if (widget.mediaItem is StoryItem) {
                            List<StoryItem> storyList =
                                widget.mediaList as List<StoryItem>;
                            if (currentTherapyIndex < 0) {
                              currentTherapyIndex = storyList.length - 1;
                            }
                            StoryItem prevItem = storyList[currentTherapyIndex];
                            widget.mediaItem = prevItem as T;
                          }

                          //isButtonClicked = false;
                          currentTherapyIndex = 0;
                        });
                        ;
                      },
                      // ),
                    ),
                    const SizedBox(width: 30),
                    RoundedButton(
                      color: AppColor.fontColorPrimary,
                      image: Image.asset(
                        isButtonClicked
                            ? "lib/assets/icons/player_play_icon.png"
                            : "lib/assets/icons/player_pause_icon.png",
                        width: 20,
                      ),
                      press: () async {
                        if (player.state == PlayerState.playing) {
                          await player.pause();
                        } else {
                          await player.resume();
                        }
                        setState(() {
                          //isButtonClicked = !isButtonClicked;
                        });
                      },
                    ),
                    const SizedBox(width: 30),
                    RoundedButton(
                      image: Image.asset(
                        "lib/assets/icons/player_next_icon.png",
                        width: 30,
                      ),
                      color: AppColor.btnColorSecondary,
                      press: () {
                        setState(() {
                          currentTherapyIndex++;

                          if (widget.mediaItem is MusicItem) {
                            List<MusicItem> musicList =
                                widget.mediaList as List<MusicItem>;
                            if (currentTherapyIndex >= musicList.length) {
                              currentTherapyIndex = 0;
                            }
                            MusicItem nextItem = musicList[currentTherapyIndex];
                            widget.mediaItem = nextItem as T;
                          } else if (widget.mediaItem is MeditationItem) {
                            List<MeditationItem> meditationList =
                                widget.mediaList as List<MeditationItem>;
                            if (currentTherapyIndex >= meditationList.length) {
                              currentTherapyIndex = 0;
                            }
                            MeditationItem nextItem =
                                meditationList[currentTherapyIndex];
                            widget.mediaItem = nextItem as T;
                          } else if (widget.mediaItem is StoryItem) {
                            List<StoryItem> storyList =
                                widget.mediaList as List<StoryItem>;
                            if (currentTherapyIndex >= storyList.length) {
                              currentTherapyIndex = 0;
                            }
                            StoryItem nextItem = storyList[currentTherapyIndex];
                            widget.mediaItem = nextItem as T;
                          }

                          //isButtonClicked = false;
                          currentTherapyIndex = 0;
                        });
                        ;
                      },
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
