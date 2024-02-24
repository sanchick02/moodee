import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // final String uid;

  final CollectionReference remindersCollection =
      FirebaseFirestore.instance.collection('reminders');

  // DatabaseService(this.uid);

  Future<String> updateUserData(DateTime selectedDay, String title) async {
    DateTime selectedDate =
        DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    Timestamp timestamp = Timestamp.fromDate(selectedDate);
    DocumentReference docRef =
        await remindersCollection.add({'date': timestamp, 'title': title});
    return docRef.id;
  }

  Future<Map<DateTime?, List<String>>> fetchReminders() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('reminders').get();

      Map<DateTime?, List<String>> remindersMap = {};

      for (var doc in querySnapshot.docs) {
        DateTime? date = (doc['date'] as Timestamp).toDate();

        // Extract the title from the document
        String title = doc['title'] as String;

        // Check if the date already exists in the map
        if (remindersMap.containsKey(date)) {
          // If it exists, add the title to the existing list
          remindersMap[date]!.add(title);
        } else {
          // If it doesn't exist, create a new list with the title
          remindersMap[date] = [title];
        }
      }

      return remindersMap;
    } catch (e) {
      print("Error fetching reminders: $e");
      return {};
    }
  }
}
