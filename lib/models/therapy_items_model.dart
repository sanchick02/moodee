import 'package:moodee/models/media_item_model.dart';

class MusicItem implements MediaItem {
  @override
  final String therapyType;
  @override
  final String image;
  @override
  final String title;
  @override
  final String singerOrAuthor;
  @override
  final int duration;
  @override
  final String instructions;
  @override
  final String sessionDurationDisplay;

  MusicItem(
      {required this.therapyType,
      required this.image,
      required this.title,
      required this.singerOrAuthor,
      required this.duration,
      required this.instructions,
      required this.sessionDurationDisplay});
}

class MeditationItem implements MediaItem {
  @override
  final String therapyType;
  @override
  final String image;
  @override
  final String title;
  @override
  final String singerOrAuthor;
  @override
  final int duration;
  @override
  final String instructions;
  @override
  final String sessionDurationDisplay;

  MeditationItem(
      {required this.therapyType,
      required this.image,
      required this.title,
      required this.singerOrAuthor,
      required this.duration,
      required this.instructions,
      required this.sessionDurationDisplay});
}

class StoryItem implements MediaItem {
  @override
  final String therapyType;
  @override
  final String image;
  @override
  final String title;
  @override
  final String singerOrAuthor;
  @override
  final int duration;
  @override
  final String instructions;
  @override
  final String sessionDurationDisplay;

  StoryItem(
      {required this.therapyType,
      required this.image,
      required this.title,
      required this.singerOrAuthor,
      required this.duration,
      required this.instructions,
      required this.sessionDurationDisplay});
}
