import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodee/models/forum.dart';

class ForumProvider with ChangeNotifier {
  List<ForumPost> forumPosts = [];

  Future<void> fetchUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        // Get the reference to your collection
        CollectionReference userForumCollection =
            FirebaseFirestore.instance.collection('new_forum');

        // Query the documents within the collection
        QuerySnapshot userPostsSnapshot = await userForumCollection.get();

        // Extract data from the documents
        List<ForumPost> fetchedPosts = userPostsSnapshot.docs.map((doc) {
          return ForumPost(
            uid: doc['uid'],
            pid: doc['pid'],
            userImage: doc['userImage'],
            userName: doc['userName'],
            time: doc['time'],
            caption: doc['caption'],
            postImage: doc['postImage'],
            likes: doc['likes'],
            mood: doc['mood'],
          );
        }).toList();

        // Update the list of forum posts
        forumPosts = fetchedPosts;

        // Notify listeners about the change in data
        notifyListeners();
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
