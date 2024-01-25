import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moodee/models/forum.dart';

class ForumItem extends StatelessWidget {
  ForumItem({super.key, required this.forumPost, this.postImage});

  final ForumPost forumPost;
  final File? postImage; // Add this line for the image file

  // File? _selectedImage;

  

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Text(
          //   forumPost.caption,
          //   style: Theme.of(context).textTheme.titleLarge,
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          Row(
            children: [
              // Text('\$${forumPost.title}'),
              // const Spacer(),
              Text(
                forumPost.caption,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),

          // const SizedBox(
          //   height: 4,
          // ),
          // Row(
          //   children: [
          //     Text(
          //       forumPost.subject,
          //       style: Theme.of(context).textTheme.bodyText1,
          //     ),
          //     const Spacer(),
          //     Text(
          //       forumPost.likes.toString(),
          //       style: Theme.of(context).textTheme.bodyText1,
          //     ),
          //   ],
          // ),
        ]),
      ),
    );
  }

  
}


              // Text(

          