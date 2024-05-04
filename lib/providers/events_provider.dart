import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodee/models/events_model.dart';

class EventsProvider with ChangeNotifier {
  List<Event> eventsList = [];

  Future<void> fetchEventsData() async {
    try {
      // Fetch data from the database
      await FirebaseFirestore.instance
          .collection('events')
          .get()
          .then((snapshot) {
        eventsList.clear(); // Empty the list for fresh data
        for (var doc in snapshot.docs) {
          Event event = Event(
            id: doc.id,
            name: doc.data()['name'],
            description: doc.data()['description'],
            location: doc.data()['location'],
            date: doc.data()['date'],
            day: doc.data()['day'],
            time: doc.data()['time'],
            image: doc.data()['image'],
            month: doc.data()['month'],
            eventHighlights:
                (doc.data()['eventHighlights'] as List).cast<String>(),
            eventImages: (doc.data()['eventImages'] as List).cast<String>(),
            moodCategory: doc.data()['moodCategory'],
          );
          eventsList.add(event);
        }
        print('All events data fetched');
        print(eventsList[0].name);
        print(eventsList[0].description);
        print(eventsList[0].location);
        notifyListeners(); // Notify the UI to update
      });
    } catch (e) {
      print(e);
    }
  }
}
