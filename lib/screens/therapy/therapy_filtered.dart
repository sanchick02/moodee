import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/widgets/therapy_widgets/therapy_card.dart';

class TherapyFiltered extends StatefulWidget {
  const TherapyFiltered({
    super.key,
    required this.mediaItem,
    required this.index,
  });

  final MediaItem mediaItem;
  final int index;

  @override
  State<TherapyFiltered> createState() => _TherapyFilteredState();
}

class _TherapyFilteredState extends State<TherapyFiltered> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late List<MediaItem> mediaList;
    if (widget.mediaItem is MusicItem) {
      mediaList = musicList;
    } else if (widget.mediaItem is MeditationItem) {
      mediaList = meditationList;
    } else if (widget.mediaItem is StoryItem) {
      mediaList = storyList;
    }
    final rowWidgets = <Widget>[];
    for (int i = 0; i < mediaList.length; i += 2) {
      final card1 = i < mediaList.length
          ? TherapyCard(
              mediaList[i],
              mediaItem: mediaList[i],
              margin: const EdgeInsets.only(left: 15),
              image: mediaList[i].image,
              title: mediaList[i].title,
              singerOrAuthor: mediaList[i].singerOrAuthor,
            )
          : Container();
      final card2 = (i + 1) < mediaList.length
          ? TherapyCard(
              mediaList[i + 1],
              mediaItem: mediaList[i + 1],
              margin: const EdgeInsets.only(right: 15),
              image: mediaList[i + 1].image,
              title: mediaList[i + 1].title,
              singerOrAuthor: mediaList[i + 1].singerOrAuthor,
            )
          : Container();

      final row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [card1, card2],
      );

      rowWidgets.addAll([row, const SizedBox(height: 15)]);
    }

    return Column(
      children: rowWidgets,
    );
  }
}
