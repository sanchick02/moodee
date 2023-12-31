import 'package:flutter/material.dart';
import 'package:moodee/presets/colors.dart';

typedef ToggleAnimationCallback = void Function();

class MusicPlayerProgressIndicator extends StatefulWidget {
  const MusicPlayerProgressIndicator({
    super.key,
    required this.duration,
  });
  final int duration;

  @override
  State<MusicPlayerProgressIndicator> createState() =>
      _MusicPlayerProgressIndicatorState();
}

class _MusicPlayerProgressIndicatorState
    extends State<MusicPlayerProgressIndicator> with TickerProviderStateMixin {
  late AnimationController controller;
  bool isPlaying = true;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
      backgroundColor: AppColor.fontColorSecondary,
      valueColor: AlwaysStoppedAnimation<Color>(AppColor.fontColorPrimary),
    );
  }
}
