import 'package:flutter/material.dart';
import 'package:moodee/models/testimonial_model.dart';
import 'package:moodee/models/therapists_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TherapistProvider with ChangeNotifier {
  List<Therapist> therapistsList = []; // List to store therapists

  Future<void> fetchTherapistData() async {
    try {
      await FirebaseFirestore.instance
          .collection('therapists')
          .get()
          .then((snapshot) {
        therapistsList.clear(); // Empty the list for fresh data
        for (var doc in snapshot.docs) {
          Therapist therapist = Therapist(
            id: doc.id,
            name: doc.data()['name'],
            image: doc.data()['image'],
            title: doc.data()['title'],
            rating: doc.data()['rating'],
            imageCard: doc.data()['imageCard'],
            experience: doc.data()['experience'],
            workplace: doc.data()['workplace'],
            availability: doc.data()['availability']?.cast<String>() ?? [],
            areaOfExpertise: (doc.data()['areaOfExpertise'] as List)
                .map((item) => item as Map<String, dynamic>)
                .toList(),
            aboutThisTherapist: doc.data()['aboutThisTherapist'],
            testimonial: (doc.data()['testimonial'] as List)
                .map((item) => Testimonial(
                    uid: item['id'],
                    testimonialText: item['testimonials'],
                    rating: item['rating']))
                .toList(),
          );
          therapistsList.add(therapist);
        }
        print('All therapist data fetched');
        print(therapistsList[0].name);
        print(therapistsList[0].image);
        print(therapistsList[0].areaOfExpertise);
        notifyListeners(); // Notify the UI to update
      });
    } catch (e) {
      print(e);
    }
  }
}
