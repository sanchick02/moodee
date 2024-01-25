import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moodee/models/forum.dart';

final formatted = DateFormat.yMd();

class NewForum extends StatefulWidget {
  const NewForum({
    super.key,
    required this.onAddExpense,
    required this.onPickedImage,
  });

  final void Function(ForumPost forumPost) onAddExpense;
  final void Function(File pickedImage) onPickedImage;

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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewForum(
          onAddExpense: ,
          onPickedImage: (File pickedImage) {
            _pickedImageFile = pickedImage;
            setState(() {
              _pickedImageFile = pickedImage;
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _captionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
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
    widget.onAddExpense(ForumPost(
      id: '',
      caption: _captionController.text,
      time: _currentDateTime.toString(),
      likes: 0,
      userImage: '',
      name: '',
      postImage: '',
    ));
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

    widget.onPickedImage(_pickedImageFile!);
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
