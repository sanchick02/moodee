import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moodee/models/forum.dart';
import 'package:moodee/providers/user_provider.dart';
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
  DateTime? _currentDateTime = DateTime.now();
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

    // widget.onAddExpense(ForumPost(
    //   uid: currentUser.uid,
    //   pid: postId,
    //   caption: _captionController.text,
    //   time: _currentDateTime.toString(),
    //   likes: 0,
    //   userImage: '',
    //   userName: userData.data()!['first_name'],
    //   name: '',
    //   postImage: _pickedImageFile!.path,
    // ));

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

    final userForumCollection = FirebaseFirestore.instance
        .collection('forums')
        .doc(currentUser.uid)
        .collection('users_posts');

    await userForumCollection.add({
      'uid': currentUser.uid,
      'pid': postId,
      'caption': _captionController.text,
      'time': _currentDateTime.toString(),
      'likes': 0,
      'userImage': '',
      'userName': userData.data()!['first_name'],
      'postImage': imageUrl,
      'timestamp': timestamp,
    });
    Navigator.pop(context);
  }

  void _pickedImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      // imageQuality: 50,
      // maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _captionController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Write your post caption'),
            ),
          ),
          Row(
            children: [
              ElevatedButton(onPressed: _pickedImage, child: Text("Add Image"))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Post on Forum'))
            ],
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
          ),
        ],
      ),
    );
  }
}
