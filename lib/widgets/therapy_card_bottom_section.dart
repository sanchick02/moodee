import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/fonts.dart';

class TherapyCardBottomSection<T extends MediaItem> extends StatefulWidget {
  TherapyCardBottomSection({
    super.key,
    // required this.call2Action,
    required this.iconButtonImg,
    required this.mediaItem,
    required this.mediaList,
  });

  // final String call2Action;
  final Image iconButtonImg;
  T mediaItem;
  final List<T> mediaList;

  @override
  State<TherapyCardBottomSection<T>> createState() =>
      _TherapyCardBottomSectionState<T>();
}

class _TherapyCardBottomSectionState<T extends MediaItem>
    extends State<TherapyCardBottomSection<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
        left: 20,
      ),
      child: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.mediaItem is MusicItem) ...[
                Text(
                  "Play Music",
                  style: AppFonts.smallLightText,
                ),
              ] else if (widget.mediaItem is MeditationItem) ...[
                Text(
                  "Start Session",
                  style: AppFonts.smallLightText,
                ),
              ] else if (widget.mediaItem is StoryItem) ...[
                Text(
                  "Play Story",
                  style: AppFonts.smallLightText,
                )
              ],
              IconButton(
                onPressed: () => navigateToPlayer(context, widget.mediaItem),
                icon: widget.iconButtonImg,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
