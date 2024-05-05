import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodee/models/forum.dart';

class ForumProvider with ChangeNotifier {
  List<ForumPost> forumPosts = []; // List to store forum posts

  Future<void> fetchUserData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        // Get the reference to the forum collection
        CollectionReference userForumCollection =
            FirebaseFirestore.instance.collection('new_forum');

        // Query the documents within the collection
        QuerySnapshot userPostsSnapshot = await userForumCollection.get();

        forumPosts.clear(); // Empty the list for fresh data

        // Extract data from the documents
        for (var doc in userPostsSnapshot.docs) {
          ForumPost forumPost = ForumPost(
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
          forumPosts.add(forumPost);
        }

        print('All forum post data fetched');
        print(forumPosts[0].userName);
        print(forumPosts[0].caption);
        notifyListeners(); // Notify the UI to update
      }
    } catch (e) {
      print(e);
    }
  }
}
