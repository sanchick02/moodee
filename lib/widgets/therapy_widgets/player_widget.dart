import 'package:flutter/material.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/widgets/rounded_button.dart';
import 'package:lottie/lottie.dart';

class PlayerWidget<T extends MediaItem> extends StatefulWidget {
  PlayerWidget({
    Key? key,
    required this.mediaItem,
    required this.mediaList,
  }) : super(key: key);

  T mediaItem;
  final List<T> mediaList;

  @override
  State<PlayerWidget<T>> createState() => _PlayerWidgetState<T>();
}

class _PlayerWidgetState<T extends MediaItem> extends State<PlayerWidget<T>>
    with SingleTickerProviderStateMixin {
  int currentTherapyIndex = 0;
  bool isButtonClicked = false;
  bool _isDisposed = false;

  late AnimationController _controller;
  late Animation<double> _progress;

  final ValueNotifier<double> _player = ValueNotifier<double>(0);
  bool _isDark = false;

  controllerListener() {
    if (_controller.status == AnimationStatus.forward ||
        _controller.status == AnimationStatus.completed) {
      increasePlayer();
    }
  }

  increasePlayer() async {
    if (!_isDisposed) {
      if (_controller.status == AnimationStatus.forward ||
          _controller.status == AnimationStatus.completed) {
        if ((_player.value + .0005) > 1) {
          _player.value = 1;
          if (!_isDisposed) {
            _controller.reverse();
          }
        } else {
          _player.value += .00005;
        }

        await Future.delayed(
          const Duration(milliseconds: 100),
        );
        if (_player.value < 1) {
          increasePlayer();
        }
      }
    }
  }

  @override
  void dispose() {
    // Dispose of your resources here.
    _controller.dispose();
    _player.dispose();
    _isDisposed = true;

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progress = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.addListener(() {
      controllerListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: AppStyles.edgeInsetsLR,
          child: Column(
            children: [
              SizedBox.square(
                dimension: MediaQuery.sizeOf(context).width - 40,
                child: Stack(
                  children: [
                    Positioned.fill(
                      left: 30,
                      top: 30,
                      bottom: 30,
                      right: 30,
                      child: ValueListenableBuilder(
                          valueListenable: _player,
                          builder: (context, value, _) {
                            return CircularProgressIndicator(
                              color: AppColor.btnColorPrimary,
                              value: value,
                              strokeCap: StrokeCap.round,
                              strokeWidth: 10,
                              backgroundColor: AppColor.backgroundColor,
                            );
                          }),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Container(
                          height: 200,
                          width: 200,
                          color: AppColor.backgroundColor,
                          child: _buildMediaContent(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Text(widget.mediaItem.instructions),
              Text(
                widget.mediaItem.title,
                style: AppFonts.largeMediumText,
              ),
              const SizedBox(height: 5),
              Text(
                widget.mediaItem.singerOrAuthor,
                style: AppFonts.smallLightText,
              ),
              const SizedBox(height: 30),

              ValueListenableBuilder(
                valueListenable: _player,
                builder: (context, value, _) {
                  return Slider(
                    thumbColor: AppColor.btnColorPrimary,
                    activeColor: AppColor.btnColorPrimary,
                    inactiveColor: AppColor.btnColorPrimary.withOpacity(.4),
                    secondaryActiveColor:
                        AppColor.btnColorPrimary.withOpacity(.4),
                    value: value,
                    onChanged: (_) {
                      _controller.reverse();
                      _player.value = _;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: AppStyles.edgeInsetsLR,
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
                press: () {
                  if (_controller.status == AnimationStatus.completed) {
                    _controller.reverse();
                    setState(() {
                      isButtonClicked = !isButtonClicked;
                    });
                  } else {
                    _controller.forward();
                    setState(() {
                      isButtonClicked = !isButtonClicked;
                    });
                  }
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

      _controller.reset();
      _player.value = 0.0;

      isButtonClicked = false;
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

      _controller.reset();
      _player.value = 0.0;

      isButtonClicked = false;
    });
  }

  Widget _buildMediaContent() {
    if (widget.mediaItem is MusicItem) {
      // If it's a MusicItem, display an image
      return Image.asset(
        (widget.mediaItem as MusicItem).image,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else if (widget.mediaItem is MeditationItem) {
      // If it's a MeditationItem, display Lottie animation
      return Padding(
        padding: const EdgeInsets.only(top: 120, left: 5),
        child: Transform.scale(
          scale: 4,
          child: Lottie.asset('lib/assets/lottie/yoga.json'),
        ),
      );
    } else if (widget.mediaItem is StoryItem) {
      return Image.asset(
        (widget.mediaItem as StoryItem).image,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Container();
    }
  }
}
