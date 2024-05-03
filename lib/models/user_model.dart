import 'dart:ffi';

class UserModel {
  String uid;
  String firstName;
  String lastName;
  String userName;
  String email;
  String gender;
  String imageURL;
  String dob;
  String age;
  bool isTherapist;
  String therapist_id;
  String therapist_datetime;

  UserModel(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.gender,
      required this.imageURL,
      required this.dob,
      required this.age,
      required this.isTherapist,
      required this.therapist_id,
      required this.therapist_datetime});
}
