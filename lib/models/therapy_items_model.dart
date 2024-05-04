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
  final String trackId;

  MusicItem({
    required this.therapyType,
    required this.image,
    required this.title,
    required this.singerOrAuthor,
    required this.trackId,
  });
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
  final String trackId;

  MeditationItem({
    required this.therapyType,
    required this.image,
    required this.title,
    required this.singerOrAuthor,
    required this.trackId,
  });
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
  final String trackId;

  StoryItem({
    required this.therapyType,
    required this.image,
    required this.title,
    required this.singerOrAuthor,
    required this.trackId,
  });
}
