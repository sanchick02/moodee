import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:moodee/main.dart';

class MoodTrakcerScreen2 extends StatefulWidget {
  const MoodTrakcerScreen2({Key? key}) : super(key: key);

  @override
  State<MoodTrakcerScreen2> createState() {
    return _MoodTrakcerScreen2State();
  }
}

class _MoodTrakcerScreen2State extends State<MoodTrakcerScreen2> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  File? _capturedImage;
  bool isCaptured = false;

  void loadCamera() async {
    cameraController = CameraController(cameras![1], ResolutionPreset.medium);
    await cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController!.startImageStream((image) => {
              cameraImage = image,
              runModel(),
            });
      });
    });
  }

  void runModel() async {
    try {
      if (cameraImage != null) {
        var predictions = await Tflite.runModelOnFrame(
            bytesList: cameraImage!.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: cameraImage!.height,
            imageWidth: cameraImage!.width,
            imageMean: 127.5,
            imageStd: 127.5,
            rotation: 90,
            numResults: 2,
            threshold: 0.1,
            asynch: true);
        for (var element in predictions!) {
          setState(() {
            output = element['label'];
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void loadModel() async {
    await Tflite.loadModel(
        model: 'lib/assets/tflite/model.tflite',
        labels: 'lib/assets/tflite/labels.txt');

    print('Model loaded');
  }

  void logMood() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String emoji = '';

    try {
      // capture image from cameracontroller
      final image = await cameraController!.takePicture();

      if (image == null) {
        return;
      } else {
        print('image captured');
      }

      // convert image to file
      _capturedImage = File(image.path);
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filename = '$timestamp.jpg';

      // upload image to firebase storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('moods')
          .child(currentUser.uid)
          .child(filename);

      await ref.putFile(_capturedImage!);

      // get image url
      final imageUrl = await ref.getDownloadURL();

      if (output == '0 happy') {
        output = 'happy';
        emoji = '😁';
      } else if (output == '2 angry') {
        output = 'angry';
        emoji = '😡';
      } else if (output == '1 sad') {
        output = 'sad';
        emoji = '😢';
      } else if (output == '4 neutral') {
        output = 'neutral';
        emoji = '😐';
      }

// Assuming currentUser.uid is the user's unique identifier
      final userMoodsCollection = FirebaseFirestore.instance
          .collection('moods')
          .doc(currentUser.uid)
          .collection('userMoods');

      await userMoodsCollection.add({
        'mood': output,
        'emoji': emoji,
        'imageUrl': imageUrl,
        'time': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      isCaptured = true;
    });
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    loadCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          ),
          Text(
            output,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: logMood,
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
              textStyle: const TextStyle(fontSize: 20),
              padding: const EdgeInsets.all(20),
            ),
            child: const Text('Log Mood'),
          )
        ],
      ),
    );
  }
}
