import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodee/models/user_model.dart';

User? get user => FirebaseAuth.instance.currentUser!;

class UserProvider with ChangeNotifier {
  UserModel? userProviderData = UserModel(
      uid: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      gender: '',
      imageURL: '',
      dob: '',
      age: '',
      isTherapist: false,
      therapist_id: '',
      therapist_datetime: '');

  Future<void> fetchUserData() async {
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then(
          (snapshot) {
            userProviderData!.uid = snapshot.id;
            userProviderData!.firstName = snapshot.data()!['first_name'];
            userProviderData!.lastName = snapshot.data()!['last_name'];
            userProviderData!.email = snapshot.data()!['email'];
            userProviderData!.gender = snapshot.data()!['gender'];
            userProviderData!.imageURL = snapshot.data()!['profileImageURL'];
            userProviderData!.dob = snapshot.data()!['date_of_birth'];
            userProviderData!.age = snapshot.data()!['age'];
            userProviderData!.isTherapist = snapshot.data()!['is_therapist'];
            userProviderData!.therapist_id = snapshot.data()!['therapist_id'];
            userProviderData!.therapist_datetime =
                snapshot.data()!['therapist_datetime'];
            print('User data fetched');

            print(userProviderData!.uid);
            print(userProviderData!.firstName);
            print(userProviderData!.lastName);
            print(userProviderData!.email);
          },
        );
      } catch (e) {
        print(e);
      }
    } else {
      print('User is null');
    }
  }
}
