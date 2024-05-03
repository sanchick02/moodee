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
  @override
  final String trackId;

  MusicItem(
      {required this.therapyType,
      required this.image,
      required this.title,
      required this.singerOrAuthor,
      required this.duration,
      required this.instructions,
      required this.sessionDurationDisplay,
      required this.trackId});
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
  @override
  final String trackId;

  MeditationItem(
      {required this.therapyType,
      required this.image,
      required this.title,
      required this.singerOrAuthor,
      required this.duration,
      required this.instructions,
      required this.sessionDurationDisplay,
      required this.trackId});
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
  @override
  final String trackId;

  StoryItem(
      {required this.therapyType,
      required this.image,
      required this.title,
      required this.singerOrAuthor,
      required this.duration,
      required this.instructions,
      required this.sessionDurationDisplay,
      required this.trackId});
}
