import 'package:moodee/models/media_item_model.dart';

class MusicItem implements CustomMediaItem {
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
  final String audioURL;

  MusicItem({
    required this.therapyType,
    required this.image,
    required this.title,
    required this.singerOrAuthor,
    required this.duration,
    required this.instructions,
    required this.sessionDurationDisplay,
    required this.audioURL,
  });
}

class MeditationItem implements CustomMediaItem {
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
  final String audioURL;

  MeditationItem({
    required this.therapyType,
    required this.image,
    required this.title,
    required this.singerOrAuthor,
    required this.duration,
    required this.instructions,
    required this.sessionDurationDisplay,
    required this.audioURL,
  });
}

class StoryItem implements CustomMediaItem {
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
  final String audioURL;

  StoryItem({
    required this.therapyType,
    required this.image,
    required this.title,
    required this.singerOrAuthor,
    required this.duration,
    required this.instructions,
    required this.sessionDurationDisplay,
    required this.audioURL,
  });
}
