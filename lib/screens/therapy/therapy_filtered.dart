import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/widgets/therapy_widgets/therapy_card.dart';

class TherapyFiltered extends StatelessWidget {
  const TherapyFiltered({
    super.key,
    required this.mediaItem,
    required this.index,
  });

  final CustomMediaItem mediaItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    late List<CustomMediaItem> mediaList;
    if (mediaItem is MusicItem) {
      mediaList = musicList;
    } else if (mediaItem is MeditationItem) {
      mediaList = meditationList;
    } else if (mediaItem is StoryItem) {
      mediaList = storyList;
    }
    final rowWidgets = <Widget>[];
    for (int i = 0; i < mediaList.length; i += 2) {
      final card1 = i < mediaList.length
          ? TherapyCard(
              mediaList[i],
              mediaItem: mediaList[i],
              margin: const EdgeInsets.only(left: 15),
            )
          : Container();
      final card2 = (i + 1) < mediaList.length
          ? TherapyCard(
              mediaList[i + 1],
              mediaItem: mediaList[i + 1],
              margin: const EdgeInsets.only(
                right: 15,
              ),
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
