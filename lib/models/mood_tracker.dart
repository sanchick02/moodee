class MoodTracker {
  final String? question;
  final String? answer;
  final String type;
  final String userId;
  final String date;
  final String timePeriod;
  final double moodIntensity;
  final String? moodTrackerStreak;
  final String image;

  MoodTracker({
    required this.question,
    required this.type,
    required this.answer,
    required this.date,
    required this.moodIntensity,
    required this.moodTrackerStreak,
    required this.timePeriod,
    required this.userId,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'type': type,
      'answer': answer,
      'date': date,
      'moodIntensity': moodIntensity,
      'moodTrackerStreak': moodTrackerStreak,
      'timePeriod': timePeriod,
      'userId': userId,
      'image': image,
    };
  }
}