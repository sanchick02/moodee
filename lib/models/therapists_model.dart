import 'package:moodee/models/testimonial_model.dart';

class Therapist {
  String id;
  String name;
  String image;
  String title;
  String rating;
  String imageCard;
  String experience;
  String workplace;
  String aboutThisTherapist;
  List<Map<String, dynamic>> areaOfExpertise;
  List<String> availability;
  List<Testimonial> testimonial;

  Therapist({
    required this.id,
    required this.name,
    required this.image,
    required this.title,
    required this.rating,
    required this.imageCard,
    required this.experience,
    required this.workplace,
    required this.availability,
    required this.areaOfExpertise,
    required this.aboutThisTherapist,
    required this.testimonial,
  });
}
