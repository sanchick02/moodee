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
      age: '');

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

//https://firebasestorage.googleapis.com/v0/b/moodee-acc66.appspot.com/o/user_profile_image%2Fr7C227JXDKaSU2FtuKX0tv9QGs42.jpg?alt=media&token=5c7dc9f0-f8b2-4ac4-ad39-b94e40516155

// gs://moodee-acc66.appspot.com/therapist/Alicia/therapist6bg.png
