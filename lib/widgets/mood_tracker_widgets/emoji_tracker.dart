import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moodee/data/mood_tracker.dart';
import 'package:moodee/models/mood_types_model.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';

class EmojiTracker extends StatefulWidget {
  final Function(MoodTypeModel) togglePopUp;

  const EmojiTracker({Key? key, required this.togglePopUp}) : super(key: key);

  @override
  State<EmojiTracker> createState() => _EmojiTrackerState();
}

class _EmojiTrackerState extends State<EmojiTracker> {
  //double _currentSliderValue = 5;
  @override

  //  void initState() {
  //   super.initState();
  //   downloadImage();
  // }

  // Future<void> downloadImage() async {
  //   try {
  //     // Reference to the image in Firebase Storage
  //     Reference ref = FirebaseStorage.instance.ref().child('images/my_image.jpg');

  //     // Get the download URL for the image
  //     String downloadURL = await ref.getDownloadURL();

  //     setState(() {
  //       imageUrl = downloadURL;
  //     });
  //   } catch (e) {
  //     print('Error downloading image: $e');
  //   }
  // }

  Widget build(BuildContext context) {
    List<MoodTypeModel> moodList = moodTypeList;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: GridView.builder(
          itemCount: moodList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Change this to the number of columns you want
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
            ),
          itemBuilder: (BuildContext context, int index) {
            return ElevatedButton(
              onPressed: () {
                widget.togglePopUp(moodList[index]);
              }, 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder( // Optional: Customize button shape
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
                child: Column(
                  children: [
                    Image.asset(moodList[index].image,),
                    const Spacer(),
                    Text(
                      moodList[index].type,
                      style: AppFonts.extraSmallLightText,
                      ),
                    const SizedBox(height: 15,)
                  ],
                ),
            );
          },
        ),
      ),
    );
  }
}