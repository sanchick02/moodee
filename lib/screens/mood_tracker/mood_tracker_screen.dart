import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:moodee/main.dart';
import 'package:moodee/models/mood_types_model.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/mood_tracker_widgets/camera_tracker.dart';
import 'package:moodee/widgets/mood_tracker_widgets/circular_progress_indicator.dart';
import 'package:moodee/widgets/mood_tracker_widgets/emoji_tracker.dart';
import 'package:moodee/widgets/mood_tracker_widgets/pop_up_container.dart';
import 'package:provider/provider.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  State<MoodTrackerScreen> createState() {
    return _MoodTrackerScreenState();
  }
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
//   CameraImage? cameraImage;
//   CameraController? cameraController;
//   String output = '';
//   String emojiAsset = '';
//   File? _capturedImage;
//   bool isCaptured = false;
//   bool isLoading = false;
   bool moodTrackerMode = true;
//   late Completer<void> _cameraReadyCompleter;

//   void loadCamera() async {
//     _cameraReadyCompleter = Completer<void>();

//     cameraController = CameraController(cameras![1], ResolutionPreset.medium);

//     await cameraController!.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }

//       _cameraReadyCompleter.complete();

//       setState(() {
//         cameraController!.startImageStream((image) {
//           cameraImage = image;
//           runModel();
//         });
//       });
//     });
//   }

//   void runModel() async {
//     try {
//       if (cameraImage != null) {
//         var predictions = await Tflite.runModelOnFrame(
//             bytesList: cameraImage!.planes.map((plane) {
//               return plane.bytes;
//             }).toList(),
//             imageHeight: cameraImage!.height,
//             imageWidth: cameraImage!.width,
//             imageMean: 127.5,
//             imageStd: 127.5,
//             rotation: 90,
//             numResults: 2,
//             threshold: 0.1,
//             asynch: true);
//         for (var element in predictions!) {
//           setState(() {
//             output = element['label'];
//             output = output.replaceAll(RegExp(r'[0-9]'), '');
//           });
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void loadModel() async {
//     await Tflite.loadModel(
//         model: 'lib/assets/tflite_new/model.tflite',
//         labels: 'lib/assets/tflite_new/labels.txt');

//     print('Model loaded');
//   }

//   void logMood() async {
//     final currentUser = FirebaseAuth.instance.currentUser!;
//     String emoji = '';
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       await _cameraReadyCompleter.future; // Wait for camera to be ready

//       // Stop the camera stream
//       cameraController!.stopImageStream();
//       // stop the model

//       // Capture image immediately
//       final image = await cameraController!.takePicture();

//       // ignore: unnecessary_null_comparison
//       if (image == null) {
//         return;
//       } else {
//         print('image captured');
//       }

//       // convert image to file
//       _capturedImage = File(image.path);
//       String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//       String filename = '$timestamp.jpg';

//       // upload image to firebase storage
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('moods')
//           .child(currentUser.uid)
//           .child(filename);

//       await ref.putFile(_capturedImage!);

//       // get image url
//       final imageUrl = await ref.getDownloadURL();

//       // if (output == '0 happy') {
//       //   output = 'happy';
//       //   emoji = '😁';
//       //   emojiAsset = 'lib/assets/images/emojiHappy.png';
//       // } else if (output == '2 angry') {
//       //   output = 'angry';
//       //   emoji = '😡';
//       //   emojiAsset = 'lib/assets/images/angry.png';
//       // } else if (output == '1 sad') {
//       //   output = 'sad';
//       //   emoji = '😢';
//       //   emojiAsset = 'lib/assets/images/sad.png';
//       // } else if (output == '4 neutral') {
//       //   output = 'neutral';
//       //   emoji = '😐';
//       // }

// // Assuming currentUser.uid is the user's unique identifier
//       final userMoodsCollection = FirebaseFirestore.instance
//           .collection('moods')
//           .doc(currentUser.uid)
//           .collection('userMoods');

//       await userMoodsCollection.add({
//         'mood': output,
//         'emoji': emoji,
//         'imageUrl': imageUrl,
//         'time': DateTime.now(),
//       });
//     } catch (e) {
//       print(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//         isCaptured = true;
//       });
//     }

//     setState(() {
//       isCaptured = true;
//     });
//   }

//   void rescan() {
//     setState(() {
//       isCaptured = false;
//       output = ''; // Reset output
//     });
//     loadCamera(); // Restart the camera for rescanning
//   }

//   @override
//   void initState() {
//     loadCamera();
//     loadModel();
//     super.initState();

//     // make sure model is loaded before camera
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     cameraController!.dispose();
//     // Tflite.close();
//   }

  bool showPopup = false;
  MoodTypeModel? moodData; 
  double moodIntensity = 5; 

  void togglePopUp(MoodTypeModel data, double sliderValue) {
    setState(() {
      showPopup = !showPopup;
      moodData = data;
      moodIntensity = moodIntensity;
    });
  }

  void toggleMode() {
    setState(() {
      moodTrackerMode = !moodTrackerMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/assets/images/meshGrad1.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    "Mood Tracker",
                    style: AppFonts.normalRegularText,
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      "lib/assets/icons/arrow_back_gray_small.png",
                      width: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                        Column(
                          children: [
                            Text(
                              "Track Your Mood",
                              style: AppFonts.heading3,
                            ),
                            Text(
                              moodTrackerMode ? "Pick one that best describes your mood right now" : "Look into the camera and hold still",
                              style: AppFonts.smallLightText,
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                moodTrackerMode
                  ? AbsorbPointer(      // To disable the background screen
                    absorbing: showPopup,
                    child: EmojiTracker(togglePopUp: togglePopUp,))
                  : const CameraTracker(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Text(
                        'OR',
                        style: AppFonts.smallLightText,
                      ),
                      const SizedBox(height: 10,),
                      DefaultButton(
                        text: moodTrackerMode ? 'Scan my face' : 'Describe with emojis', 
                        press: () {
                          //toggleMode();
                        }, 
                        backgroundColor: Colors.transparent, 
                        height: 40, 
                        fontStyle: AppFonts.largeMediumText, 
                        width: double.infinity, 
                        padding: const EdgeInsets.only()),
                    ],
                  ),
                )
              ],
            ),
          ),
          PopUpMoodTracker(showPopup: showPopup, moodIntensity: moodIntensity, moodData: moodData ??  MoodTypeModel(
                                                                        image: 'lib/assets/images/mood_tracker/happy_emoji.png', 
                                                                        question: ['What are three things that made you smile today?', 
                                                                        'What accomplishment are you most proud of recently?',
                                                                        'Who is someone you''re grateful to have in your life, and why?'], 
                                                                        type: 'Happy')),
        ],
      ),
    );
  }

  // Column cameraCapturedFalse(BuildContext context) {
  //   return Column(
  //                     children: [
  //                       const SizedBox(height: 40),
  //                       Column(
  //                         children: [
  //                           Text(
  //                             "Track Your Mood",
  //                             style: AppFonts.heading3,
  //                           ),
  //                           Text(
  //                             "Look into the camera and hold still",
  //                             style: AppFonts.smallLightText,
  //                           ),
  //                           const SizedBox(height: 30),
  //                         ],
  //                       ),
  //                       Stack(
  //                         children: [
  //                           ClipOval(
  //                             child: SizedBox(
  //                               height:
  //                                   MediaQuery.of(context).size.height * 0.3,
  //                               width:
  //                                   MediaQuery.of(context).size.height * 0.3,
  //                               child: !cameraController!.value.isInitialized
  //                                   ? Container()
  //                                   : AspectRatio(
  //                                       aspectRatio: cameraController!
  //                                           .value.aspectRatio,
  //                                       child:
  //                                           CameraPreview(cameraController!),
  //                                     ),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height:
  //                                 MediaQuery.of(context).size.height * 0.3,
  //                             width: MediaQuery.of(context).size.height * 0.3,
  //                             child: isLoading
  //                                 ? CustomCircularProgressIndicator(
  //                                     color: AppColor.btnColorPrimary,
  //                                   )
  //                                 : CustomCircularProgressIndicator(
  //                                     color: Colors.transparent),
  //                           ),
  //                         ],
  //                       ),
  //                       Column(
  //                         children: [
  //                           const SizedBox(height: 60),
  //                           Text(
  //                             "Your Mood Right Now",
  //                             style: AppFonts.largeMediumText,
  //                           ),
  //                           const SizedBox(height: 5),
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.symmetric(horizontal: 60),
  //                             child: Container(
  //                               color: AppColor.fontColorPrimary,
  //                               width: double.infinity,
  //                               height: 0.8,
  //                             ),
  //                           ),
  //                           const SizedBox(height: 10),
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.symmetric(horizontal: 60),
  //                             child: SizedBox(
  //                               width: double.infinity,
  //                               child: Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceAround,
  //                                 children: [
  //                                   // output == '0 happy'
  //                                   //     ? Image.asset(
  //                                   //         'lib/assets/images/emojiHappy.png',
  //                                   //         width: 120,
  //                                   //       )
  //                                   //     : output == '1 sad'
  //                                   //         ? Image.asset(
  //                                   //             'lib/assets/images/Sad.png',
  //                                   //             width: 120,
  //                                   //           )
  //                                   //         : output == ' 2 angry'
  //                                   //             ? Image.asset(
  //                                   //                 'lib/assets/images/emojiHappy.png',
  //                                   //                 width: 120,
  //                                   //               )
  //                                   //             : Container(),
  //                                   // SizedBox(width: 10),
  //                                   Text(
  //                                     output,
  //                                     style: AppFonts.heading3Height,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                       const SizedBox(height: 15),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 60),
  //                         child: DefaultButton(
  //                           press: isLoading ? null : logMood,
  //                           text: "Log My Mood",
  //                           backgroundColor: AppColor.btnColorPrimary,
  //                           height: 40,
  //                           fontStyle: AppFonts.normalRegularTextWhite,
  //                           width: double.infinity,
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 12,
  //                             vertical: 8,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  // }

  // Column cameraCapturedTrue(BuildContext context) {
  //   return Column(
  //                     children: [
  //                       const SizedBox(height: 40),
  //                       Column(
  //                         children: [
  //                           Text(
  //                             "Track Your Mood",
  //                             style: AppFonts.heading3,
  //                           ),
  //                           Text(
  //                             "Look into the camera and hold still",
  //                             style: AppFonts.smallLightText,
  //                           ),
  //                           const SizedBox(height: 30),
  //                         ],
  //                       ),
  //                       ClipOval(
  //                         child: SizedBox(
  //                           child: Image.file(
  //                             _capturedImage!,
  //                             height:
  //                                 MediaQuery.of(context).size.height * 0.3,
  //                             width: MediaQuery.of(context).size.height * 0.3,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                       Column(
  //                         children: [
  //                           const SizedBox(height: 60),
  //                           Text(
  //                             "Your Mood Right Now",
  //                             style: AppFonts.largeMediumText,
  //                           ),
  //                           const SizedBox(height: 5),
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.symmetric(horizontal: 60),
  //                             child: Container(
  //                               color: AppColor.fontColorPrimary,
  //                               width: double.infinity,
  //                               height: 0.8,
  //                             ),
  //                           ),
  //                           const SizedBox(height: 10),
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.symmetric(horizontal: 60),
  //                             child: SizedBox(
  //                               width: double.infinity,
  //                               child: Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceAround,
  //                                 children: [
  //                                   // output == '0 happy'
  //                                   //     ? Image.asset(
  //                                   //         'lib/assets/images/emojiHappy.png',
  //                                   //         width: 120,
  //                                   //       )
  //                                   //     : output == '1 sad'
  //                                   //         ? Image.asset(
  //                                   //             'lib/assets/images/Sad.png',
  //                                   //             width: 120,
  //                                   //           )
  //                                   //         : output == ' 2 angry'
  //                                   //             ? Image.asset(
  //                                   //                 'lib/assets/images/emojiHappy.png',
  //                                   //                 width: 120,
  //                                   //               )
  //                                   //             : Container(),
  //                                   // SizedBox(width: 10),
  //                                   Text(
  //                                     output,
  //                                     style: AppFonts.heading3Height,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       const SizedBox(
  //                         height: 15,
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 60),
  //                         child: DefaultButton(
  //                           press: rescan,
  //                           text: "Rescan My Face",
  //                           backgroundColor: AppColor.btnColorPrimary,
  //                           height: 40,
  //                           fontStyle: AppFonts.normalRegularTextWhite,
  //                           width: double.infinity,
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 12,
  //                             vertical: 8,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  // }
}
