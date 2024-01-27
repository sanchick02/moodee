import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodee/models/forum.dart';

class ForumProvider with ChangeNotifier {
  List<ForumPost> forumPosts = [];
  final user = FirebaseAuth.instance.currentUser;

  Future<void> fetchUserData() async {
    if (user != null) {
      try {
        QuerySnapshot userPostsSnapshot = await FirebaseFirestore.instance
            .collection('forums')
            .doc(user!.uid)
            .collection('users_posts')
            .get();

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
          );
        }).toList();

        forumPosts = fetchedPosts;
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
