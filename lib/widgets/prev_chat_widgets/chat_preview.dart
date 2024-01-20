import 'package:flutter/material.dart';
import 'package:moodee/data/prev_chat.dart';
import 'package:moodee/presets/fonts.dart';

class ChatPreview extends StatelessWidget {
  const ChatPreview({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          // Add Tap gesture to navigate to the correct chat screen
          child: SizedBox(
            height: 80,
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset(
                    prevChatList[index].therapistImage,
                    height: 50,
                    width: 50,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prevChatList[index].therapistname,
                      style: AppFonts.normalRegularText,
                    ),
                    Text(
                      prevChatList[index].therapistTitle,
                      style: AppFonts.smallLightText,
                    ),
                    Text(
                      prevChatList[index].prevMessage,
                      style: AppFonts.extraSmallLightText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 350,
          height: 1,
          color: Colors.black.withOpacity(0.3),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
