import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moodee/models/forum.dart';
import 'package:moodee/providers/forum_post_provider.dart';
import 'package:provider/provider.dart';

class ForumItem extends StatelessWidget {
  final ForumPost forumPost;

  const ForumItem({Key? key, required this.forumPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                forumPost.caption,
                style: TextStyle(
                  fontSize: 18, // Increased font size
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'UID: ${forumPost.uid}',
                  style: TextStyle(fontSize: 16), // Adjusted font size
                ),
                const SizedBox(width: 8), // Increased spacing
              ],
            ),
            Text(
              'PID: ${forumPost.pid}',
              style: TextStyle(fontSize: 16), // Adjusted font size
            ),
            const SizedBox(width: 8), // Increased spacing
            Text(
              'Time: ${forumPost.time}',
              style: TextStyle(fontSize: 16), // Adjusted font size
            ),
            const SizedBox(width: 8), // Increased spacing
            Text(
              'Likes: ${forumPost.likes}',
              style: TextStyle(fontSize: 16), // Adjusted font size
            ),
          ],
        ),
      ),
    );
  }
}
