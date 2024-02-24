import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moodee/models/forum.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/providers/forum_post_provider.dart';
import 'package:moodee/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

final formatted = DateFormat.yMd();
final currentUser = FirebaseAuth.instance.currentUser!;
const random = Uuid();

class NewForum extends StatefulWidget {
  const NewForum({
    super.key,
    required this.onAddExpense,
  });

  final void Function(ForumPost forumPost) onAddExpense;

  @override
  State<NewForum> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewForum> {
  final _captionController = TextEditingController();
  final _amountController = TextEditingController();
  final _currentDateTime = DateTime.now();
  File? _pickedImageFile;

  @override
  void dispose() {
    _captionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() async {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    // ignore: unnecessary_null_comparison
    if (_captionController.text.trim().isEmpty || amountIsInvalid == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure a valid title,subject, and topic was entered"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    // randomly generate post id
    String postId = random.v1();
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    // convert image to file
    final _capturedImage = File(_pickedImageFile!.path);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String filename = '$timestamp.jpg';

    // upload image to firebase storage
    final ref = FirebaseStorage.instance
        .ref()
        .child('forum_posts')
        .child(currentUser.uid)
        .child(filename);

    await ref.putFile(_capturedImage);

    // get image url
    final imageUrl = await ref.getDownloadURL();

    final userForumCollection =
        FirebaseFirestore.instance.collection('forums10').doc(postId);

    await userForumCollection.set({
      'uid': currentUser.uid,
      'pid': postId,
      'caption': _captionController.text,
      'time': _currentDateTime.toString(),
      'likes': 0,
      'userImage': userData.data()!['profileImageURL'],
      'userName': userData.data()!['first_name'],
      'postImage': imageUrl,
      'timestamp': timestamp,
    });
    Navigator.pop(context);
    setState(() {
      _pickedImageFile = null;
      _captionController.clear();
      _amountController.clear();
      // update new forum post
      widget.onAddExpense(ForumPost(
          uid: currentUser.uid,
          pid: postId,
          userImage: '',
          userName: userData.data()!['first_name'],
          time: _currentDateTime.toString(),
          caption: _captionController.text,
          postImage: imageUrl,
          likes: 0));
    });
  }

  void _pickedImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  void initState() {
    Provider.of<ForumProvider>(context, listen: false)
        .fetchUserData()
        .then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Column(
        children: [
          TextField(
            cursorColor: AppColor.fontColorPrimary,
            controller: _captionController,
            maxLength: 500,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text(
                'Write your post caption...',
                style: AppFonts.smallLightText,
              ),
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          // CircleAvatar(
          //   radius: 40,
          //   backgroundColor: Colors.grey,
          //   foregroundImage:
          //       _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
          // ),
          GestureDetector(
            onTap: () => _pickedImage(),
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: AppStyles.borderRadiusAll,
                image: _pickedImageFile != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(_pickedImageFile!),
                      )
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Click Here to Add Image",
                    style: AppFonts.normalRegularText,
                  ),
                  Text(
                    "(Image preview will be shown here)",
                    style: AppFonts.smallLightText,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: DefaultButton(
                  text: "Publish Post on Forum",
                  press: _submitExpenseData,
                  backgroundColor: AppColor.btnColorPrimary,
                  height: 40,
                  fontStyle: AppFonts.smallLightTextWhite,
                  width: 200,
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 2,
                child: DefaultButton(
                  text: "Cancel",
                  press: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: AppColor.btnColorSecondary,
                  height: 40,
                  fontStyle: AppFonts.smallLightText,
                  width: 100,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
