import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moodee/models/forum.dart';
import 'package:moodee/navigation.dart';
import 'package:moodee/page_navigator.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';
import 'package:moodee/providers/forum_post_provider.dart';
import 'package:moodee/screens/community/community_screen.dart';
import 'package:moodee/widgets/button.dart';
import 'package:moodee/widgets/unordered_list.dart';
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
  String _selectedMood = ''; // Variable to hold selected mood

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
                Navigator.of(ctx).pop();
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
        FirebaseFirestore.instance.collection('new_forum').doc(postId);

    await userForumCollection.set({
      'uid': currentUser.uid,
      'pid': postId,
      'caption': _captionController.text,
      'time': _currentDateTime.toString(),
      'likes': 0,
      'userImage': userData.data()!['profileImageURL'],
      'userName': userData.data()!['first_name'],
      'postImage': imageUrl,
      'mood': _selectedMood, // Pass selected mood to Firebase
      'timestamp': timestamp,
    });
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
          likes: 0,
          mood: _selectedMood));
    });

    // pop
    Navigator.of(context)
        .pop(); // Close the modal bottom sheet after submitting the post
  }

  void _pickedImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) {
      return;
    }
    print("Picked image path: ${pickedImage.path}");
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  void initState() {
    Provider.of<ForumProvider>(context, listen: false)
        .fetchUserData()
        .then((_) {
      setState(() {
        // _registeredExpenses;
        // _registeredExpenses.sort((a, b) => b.time.compareTo(a.time));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Express How You Feel",
            style: AppFonts.normalRegularText,
          ),
          const SizedBox(
            height: 5,
          ),
          UnorderedList(const [
            "Share experiences and support, avoiding hate speech or negativity.",
            "Communicate respectfully, refraining from any form of disrespect or inflammatory language.",
            "Foster a supportive environment by showing empathy and kindness towards others' mental health journeys.",
          ]),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: AppColor.btnColorSecondary,
              borderRadius: AppStyles.borderRadiusAll,
              boxShadow: [AppShadow.innerShadow3],
            ),
            child: TextField(
              cursorColor: AppColor.fontColorPrimary,
              controller: _captionController,
              maxLength: 500,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Write your post caption...',
                hintStyle: AppFonts.smallLightText,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Describe Your Current Mood",
            style: AppFonts.normalRegularText,
          ),
          const SizedBox(
            height: 5,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildMoodButton(
                  image: "lib/assets/images/claudias-part_branch/emoji1.png",
                  mood: "Happy",
                ),
                _buildMoodButton(
                  image: "lib/assets/images/claudias-part_branch/emoji2.png",
                  mood: "Loved",
                ),
                _buildMoodButton(
                  image: "lib/assets/images/claudias-part_branch/emoji3.png",
                  mood: "Excited",
                ),
                _buildMoodButton(
                  image: "lib/assets/images/claudias-part_branch/emoji4.png",
                  mood: "Emotionless",
                ),
                _buildMoodButton(
                  image: "lib/assets/images/claudias-part_branch/emoji5.png",
                  mood: "Sad",
                ),
                _buildMoodButton(
                  image: "lib/assets/images/claudias-part_branch/emoji6.png",
                  mood: "Tired",
                ),
                _buildMoodButton(
                  image: "lib/assets/images/claudias-part_branch/emoji7.png",
                  mood: "Disgusted",
                ),
                _buildMoodButton(
                  image: "lib/assets/images/claudias-part_branch/emoji8.png",
                  mood: "Anxious",
                ),
                _buildMoodButton(
                  image: "lib/assets/images/claudias-part_branch/emoji9.png",
                  mood: "Angry",
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Upload a Photo",
            style: AppFonts.normalRegularText,
          ),
// Inside the GestureDetector for picking image
          GestureDetector(
            onTap: () => _pickedImage(),
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: AppColor.btnColorSecondary,
                boxShadow: [AppShadow.innerShadow3],
                borderRadius: AppStyles.borderRadiusAll,
              ),
              child: _pickedImageFile != null
                  ? ClipRRect(
                      borderRadius: AppStyles.borderRadiusAll,
                      child: Image.file(
                        _pickedImageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Click To Upload a Photo",
                          style: TextStyle(
                            fontFamily: "LeagueSpartan",
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: AppColor.fontColorPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          "lib/assets/images/claudias-part_branch/image.png",
                          width: 65,
                        ),
                      ],
                    ),
            ),
          ),

          const SizedBox(
            height: 20,
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodButton({required String image, required String mood}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = mood; // Set the selected mood
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _selectedMood == mood
                ? Colors.blue // Change color if selected
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Image.asset(
          image,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
