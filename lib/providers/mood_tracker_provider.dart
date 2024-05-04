import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodee/models/mood_tracker.dart';

class MoodTrackerProvider with ChangeNotifier {

  final morningStart = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0); 
  final morningEnd = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12);

  final afternoonStart = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12); 
  final afteroonEnd = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 17);

  final eveningStart = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 17); // 6 AM
  final eveningEnd = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 21);

  final nightStart = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 21); // 6 AM
  final nightEnd = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 6);

  List<MoodTracker> moodData = [];

  Future<List<MoodTracker>> fetchMoodData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      try {
        // Get the reference to your collection
        CollectionReference moodCollectionReference =
        FirebaseFirestore.instance.collection('moods');

        DocumentReference userMoodDoc = moodCollectionReference.doc(user.uid);

        CollectionReference userMoodCollection = userMoodDoc.collection('user_moods');

        // Query the documents within the collection
        QuerySnapshot userMoodsSnapshot = await userMoodCollection.get();

        // Extract data from the documents
        if (moodData.isEmpty) {
        List<MoodTracker> fetchedMoodData = userMoodsSnapshot.docs.map((doc) {
          return MoodTracker(
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
        }).toList();
  
  // Update the list of mood data
        moodData = fetchedMoodData;
      }

        // Notify listeners about the change in data
        notifyListeners();
      } catch (e) {
        print(e.toString());
      }
    }
    return moodData;
  }
  
}
