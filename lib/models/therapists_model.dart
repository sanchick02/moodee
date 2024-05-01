import 'package:moodee/models/testimonial_model.dart';

class Therapist {
  final String name;
  final String image;
  final String title;
  final String rating;
  final String imageCard;
  final String experience;
  final String workplace;
  final String aboutThisTherapist;
  final List<Map<String, dynamic>> areaOfExpertise;
  final List<String> availability;
  final List<Testimonial> testimonial;

  Therapist({
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
