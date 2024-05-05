import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodee/models/mood_tracker.dart';

class MoodTrackerProvider with ChangeNotifier {
  final morningStart = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0);
  final morningEnd = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 12);

  final afternoonStart = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 12);
  final afteroonEnd = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 17);

  final eveningStart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 17); // 6 AM
  final eveningEnd = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 21);

  final nightStart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 21); // 6 AM
  final nightEnd = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 6);

  List<MoodTracker> moodData = [];

  Future<void> fetchMoodData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        // Get the reference to the mood collection
        CollectionReference moodCollectionReference =
            FirebaseFirestore.instance.collection('moods');

        DocumentReference userMoodDoc = moodCollectionReference.doc(user.uid);

        CollectionReference userMoodCollection =
            userMoodDoc.collection('user_moods');

        // Query the documents within the collection
        QuerySnapshot userMoodsSnapshot = await userMoodCollection.get();

        moodData.clear(); // Empty the list for fresh data

        // Extract data from the documents
        for (var doc in userMoodsSnapshot.docs) {
          MoodTracker moodTracker = MoodTracker(
            image: doc['image'],
            type: doc['type'],
            date: doc['date'],
            moodIntensity: doc['moodIntensity'],
            timePeriod: doc['timePeriod'],
            userId: doc['userId'],
            question: doc['question'],
            answer: doc['answer'],
            moodTrackerStreak: doc['moodTrackerStreak'],
          );
          moodData.add(moodTracker);
        }

        print('All mood data fetched');
        print(moodData[0].type);
        print(moodData[0].image);
        notifyListeners(); // Notify the UI to update
      }
    } catch (e) {
      print(e);
    }
  }
}
