import 'package:moodee/models/therapist_availability_model.dart';

class Therapist {
  final String name;
  final String image;
  final String title;
  final String rating;
  final String imageCard;
  final List<String> achievements;
  final List<TherapistAvailability> availability;

  Therapist({
    required this.name,
    required this.image,
    required this.title,
    required this.rating,
    required this.imageCard,
    required this.achievements,
    required this.availability,
  });
}
