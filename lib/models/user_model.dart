import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String uid;
  String firstName;
  String lastName;
  String userName;
  String email;
  String gender;

  UserModel(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.gender});
}
