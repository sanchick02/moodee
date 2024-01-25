import 'package:audio_service/audio_service.dart';
import 'package:moodee/models/forum_channels_model.dart';
import 'package:moodee/models/media_item_model.dart';

class Song {
  final String id;
  final String therapyType;
  final String artist;
  final String title;
  final String imageUrl;
  final String? songPath;
  final String? songUrl;

  Song({
    this.id = '',
    required this.artist,
    required this.title,
    required this.imageUrl,
    this.songUrl,
    this.songPath,
    required this.therapyType,
  }) : assert(songUrl != null || songPath != null);

  factory Song.fromMediaItem(MediaItem mediaItem) {
    String? songPath, songUrl;
    if ((mediaItem.extras!['url'] as String).startsWith('asset:///')) {
      songPath =
          mediaItem.extras!['url'].toString().replaceFirst('asset:///', '');
    } else {
      songUrl = mediaItem.extras?['url'];
    }

    return Song(
      // id:
      artist: mediaItem.artist.toString(),
      title: mediaItem.title,
      imageUrl: mediaItem.artUri.toString(),
      songPath: songPath,
      songUrl: songUrl, therapyType: 'Music',
    );
  }

  MediaItem toMediaItem() => MediaItem(
          id: id,
          title: title,
          artist: artist,
          artUri: Uri.parse(imageUrl),
          extras: <String, dynamic>{
            'url': songPath != null ? 'asset:///$songPath' : songUrl,
          });

  static List<Song> songs = [
    Song(
      therapyType: "Music",
      imageUrl: "lib/assets/images/music1.jpg",
      title: "Magic",
      artist: "Coldplay",
      id: '1',
      songUrl: "lib/assets/audio/magic",
    ),
    Song(
      therapyType: "Music",
      imageUrl: "lib/assets/images/music2.jpg",
      title: "Magic",
      artist: "Coldplay",
      id: '1',
      songUrl: "lib/assets/audio/magic",
    ),
    // Song(
    //   therapyType: "Music",
    //   imageUrl: "lib/assets/images/music3.jpg",
    //   title: "Magic",
    //   artist: "Coldplay",
    //   id: '1',
    //   songUrl: "lib/assets/audio/magic",
    // ),
    // Song(
    //   therapyType: "Music",
    //   imageUrl: "lib/assets/images/music4.jpg",
    //   title: "Magic",
    //   artist: "Coldplay",
    //   id: '1',
    //   songUrl: "lib/assets/audio/magic",
    // ),
    // Song(
    //   therapyType: "Music",
    //   imageUrl: "lib/assets/images/music5.jpg",
    //   title: "Magic",
    //   artist: "Coldplay",
    //   id: '1',
    //   songUrl: "lib/assets/audio/magic",
    // ),
    // Song(
    //   therapyType: "Music",
    //   imageUrl: "lib/assets/images/music6.jpg",
    //   title: "Magic",
    //   artist: "Coldplay",
    //   id: '1',
    //   songUrl: "lib/assets/audio/magic",
    // ),
    // Song(
    //   therapyType: "Music",
    //   imageUrl: "lib/assets/images/music7.jpg",
    //   title: "Magic",
    //   artist: "Coldplay",
    //   id: '1',
    //   songUrl: "lib/assets/audio/magic",
    // ),
    // Song(
    //   therapyType: "Music",
    //   imageUrl: "lib/assets/images/music8.jpg",
    //   title: "Magic",
    //   artist: "Coldplay",
    //   id: '1',
    //   songUrl: "lib/assets/audio/magic",
    // ),
  ];
}
