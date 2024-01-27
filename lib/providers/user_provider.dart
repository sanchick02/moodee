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
  );

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
