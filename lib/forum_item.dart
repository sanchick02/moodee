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
    // Construct the URL for the image from the image path
    String imageUrl = ''; // You should replace this with the actual URL

    // If the image path is not null or empty, construct the URL
    if (forumPost.postImage != null && forumPost.postImage.isNotEmpty) {
      // Assuming your storage bucket URL is 'https://your_storage_bucket_url.com'
      imageUrl = '${forumPost.postImage}';
    }

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
                style: const TextStyle(
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
            const SizedBox(height: 8), // Increased spacing
            // Display the image if there is one
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                width: double.infinity, // Make the image take the full width
                height: 200, // Adjust the height as needed
                fit: BoxFit.cover, // Cover the space with the image
              ),
          ],
        ),
      ),
    );
  }
}
