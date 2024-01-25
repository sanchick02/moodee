import 'package:flutter/material.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/song_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/widgets/therapy_widgets/progress_indicator.dart';
import 'package:moodee/widgets/rounded_button.dart';

class TestPlayerWidget<T extends CustomMediaItem> extends StatefulWidget {
  TestPlayerWidget({
    Key? key,
    required this.mediaItem,
    required this.mediaList,
  }) : super(key: key);

  T mediaItem;
  final List<T> mediaList;

  @override
  State<TestPlayerWidget<T>> createState() => _TestPlayerWidgetState<T>();
}

class _TestPlayerWidgetState<T extends CustomMediaItem> extends State<TestPlayerWidget<T>> {
  int currentTherapyIndex = 0;
  bool isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: AppStyles.edgeInsetsLR,
          child: Column(
            children: [
              ClipOval(
                child: Image.network(
                  Song.songs[0].imageUrl,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 50),
              Text(widget.mediaItem.instructions),
              Text(
                Song.songs[0].title,
                style: AppFonts.largeMediumText,
              ),
              const SizedBox(height: 5),
              Text(
                Song.songs[0].artist,
                style: AppFonts.smallLightText,
              ),
              const SizedBox(height: 30),
              const MusicPlayerProgressIndicator(
                duration: 4,
              ),
            ],
          ),
        ),
        Padding(
          padding: AppStyles.edgeInsetsLRT,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton(
                image: Image.asset(
                  "lib/assets/icons/player_prev_icon.png",
                  width: 30,
                ),
                color: AppColor.btnColorSecondary,
                press: () {
                  _handleButtonPrev();
                },
              ),
              const SizedBox(width: 15),
              RoundedButton(
                image: Image.asset(
                  isButtonClicked
                      ? "lib/assets/icons/player_pause_icon.png"
                      : "lib/assets/icons/player_play_icon.png",
                  width: 20,
                ),
                color: AppColor.fontColorPrimary,
                press: () {
                  setState(() {
                    isButtonClicked = !isButtonClicked;
                  });
                },
              ),
              const SizedBox(width: 15),
              RoundedButton(
                image: Image.asset(
                  "lib/assets/icons/player_next_icon.png",
                  width: 30,
                ),
                color: AppColor.btnColorSecondary,
                press: () {
                  _handleButtonNext();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }


  void _handleButtonNext() {
    setState(() {
      currentTherapyIndex++;

      if (widget.mediaItem is MusicItem) {
        List<MusicItem> musicList = widget.mediaList as List<MusicItem>;
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
        MeditationItem nextItem = meditationList[currentTherapyIndex];
        widget.mediaItem = nextItem as T;
      } else if (widget.mediaItem is StoryItem) {
        List<StoryItem> storyList = widget.mediaList as List<StoryItem>;
        if (currentTherapyIndex >= storyList.length) {
          currentTherapyIndex = 0;
        }
        StoryItem nextItem = storyList[currentTherapyIndex];
        widget.mediaItem = nextItem as T;
      }
    });
  }

  void _handleButtonPrev() {
    setState(() {
      currentTherapyIndex--;

      if (widget.mediaItem is MusicItem) {
        List<MusicItem> musicList = widget.mediaList as List<MusicItem>;
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
        MeditationItem prevItem = meditationList[currentTherapyIndex];
        widget.mediaItem = prevItem as T;
      } else if (widget.mediaItem is StoryItem) {
        List<StoryItem> storyList = widget.mediaList as List<StoryItem>;
        if (currentTherapyIndex < 0) {
          currentTherapyIndex = storyList.length - 1;
        }
        StoryItem prevItem = storyList[currentTherapyIndex];
        widget.mediaItem = prevItem as T;
      }
    });
  }
}
