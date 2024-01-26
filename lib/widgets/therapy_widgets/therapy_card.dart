import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/widgets/therapy_widgets/therapy_card_bottom_section.dart';

class TherapyCard extends StatelessWidget {
  const TherapyCard(
    MediaItem selectedList, {
    super.key,
    required this.mediaItem,
    required this.margin,
  });

  final MediaItem mediaItem;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    late List<MediaItem> mediaList;
    if (mediaItem is MusicItem) {
      mediaList = musicList;
    } else if (mediaItem is MeditationItem) {
      mediaList = meditationList;
    } else if (mediaItem is StoryItem) {
      mediaList = storyList;
    }

    // final int itemIndex = mediaList.indexOf(mediaItem);
    // final bool isLastItem = itemIndex == mediaList.length - 1;

    return GestureDetector(
      onTap: () {
        navigateToPlayer(context, mediaItem);
      },
      child: Container(
        margin: margin,
        child: Stack(
          children: [
            Container(
              height: 230,
              width: 170,
              decoration: BoxDecoration(
                color: AppColor.btnColorSecondary,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  AppShadow.innerShadow3,
                  AppShadow.innerShadow4,
                ],
              ),
              child: TherapyCardBottomSection(
                iconButtonImg: Image.asset(
                  "lib/assets/icons/play_music.png",
                  width: 25,
                ),
                mediaItem: mediaItem,
                mediaList: mediaList,
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 180,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: AppStyles.borderRadiusTop,
                    boxShadow: [
                      AppShadow.innerShadow3,
                      AppShadow.innerShadow4,
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: AppStyles.borderRadiusTop,
                    child: Image.asset(
                      mediaItem.image,
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(0.9),
                    ),
                  ),
                ),
                Container(
                  height: 180,
                  width: 170,
                  padding: const EdgeInsets.only(
                    top: 50,
                    right: 15,
                    left: 15,
                    bottom: 15,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.4),
                    borderRadius: AppStyles.borderRadiusTop,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Text(mediaItem.title).data!,
                              style: AppFonts.normalRegularText,
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        Text(mediaItem.singerOrAuthor).data! +
                            Text(mediaItem.sessionDurationDisplay).data!,
                        style: AppFonts.smallLightText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
