import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:moodee/data/therapy_lists.dart';
import 'package:moodee/models/media_item_model.dart';
import 'package:moodee/models/music_model.dart';
import 'package:moodee/models/therapy_items_model.dart';
import 'package:moodee/widgets/therapy_widgets/therapy_card.dart';
import 'package:moodee/constants/strings.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/spotify.dart' as spot;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class TherapyFiltered extends StatefulWidget {
  const TherapyFiltered({
    super.key,
    required this.mediaItem,
    required this.index,
  });

  final MediaItem mediaItem;
  final int index;

  @override
  State<TherapyFiltered> createState() => _TherapyFilteredState();
}

class _TherapyFilteredState extends State<TherapyFiltered> {
  final player = AudioPlayer();
  late Music music;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  @override
  void initState() {
    super.initState();

    // Find the corresponding item in the lists based on the trackId
    late MediaItem? item;
    if (widget.mediaItem is MeditationItem) {
      item = meditationList.firstWhere(
        (element) => element.trackId == widget.mediaItem.trackId,
        orElse: () => meditationList[0],
      );
    } else if (widget.mediaItem is MusicItem) {
      item = musicList.firstWhere(
        (element) => element.trackId == widget.mediaItem.trackId,
        orElse: () => musicList[0],
      );
    } else if (widget.mediaItem is StoryItem) {
      item = storyList.firstWhere(
        (element) => element.trackId == widget.mediaItem.trackId,
        orElse: () => storyList[0],
      );
    }

    // Update the music variable if the item is found
    if (item != null) {
      if (item is MeditationItem) {
        music = Music(
          trackId: item.trackId,
          // Add other properties like songName, songImage, etc. here
        );
      } else if (item is MusicItem) {
        music = Music(
          trackId: item.trackId,
          // Add other properties like songName, songImage, etc. here
        );
      } else if (item is StoryItem) {
        music = Music(
          trackId: item.trackId,
          // Add other properties like songName, songImage, etc. here
        );
      }

      final credentials = spot.SpotifyApiCredentials(
          CustomStrings.clientId, CustomStrings.clientSecret);
      final spotify = spot.SpotifyApi(credentials);

      // Fetch additional details from Spotify
      spotify.tracks.get(music.trackId).then((track) async {
        String? tempSongName = track.name;
        if (tempSongName != null) {
          music.songName = tempSongName;
          music.artistName = track.artists?.first.name ?? "";
          String? image = track.album?.images?.first.url;
          if (image != null) {
            music.songImage = image;
            final tempSongColor = await getImagePalette(NetworkImage(image));
            if (tempSongColor != null) {
              music.songColor = tempSongColor;
            }
          }
          music.artistImage = track.artists?.first.images?.first.url;
          final yt = YoutubeExplode();
          final video = (await yt.search
                  .search("$tempSongName ${music.artistName ?? ""}"))
              .first;
          final videoId = video.id.value;
          music.duration = video.duration;
        }
      });
    }
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  @override
  Widget build(BuildContext context) {
    late List<MediaItem> mediaList;
    if (widget.mediaItem is MusicItem) {
      mediaList = musicList;
    } else if (widget.mediaItem is MeditationItem) {
      mediaList = meditationList;
    } else if (widget.mediaItem is StoryItem) {
      mediaList = storyList;
    }
    final rowWidgets = <Widget>[];
    for (int i = 0; i < mediaList.length; i += 2) {
      final card1 = i < mediaList.length
          ? TherapyCard(
              mediaList[i],
              mediaItem: mediaList[i],
              margin: const EdgeInsets.only(left: 15),
              image: music.songImage,
              title: music.songName.toString(),
              singerOrAuthor: music.artistName.toString(),
            )
          : Container();
      final card2 = (i + 1) < mediaList.length
          ? TherapyCard(
              mediaList[i + 1],
              mediaItem: mediaList[i + 1],
              margin: const EdgeInsets.only(left: 15),
              image: music.songImage,
              title: music.songName.toString(),
              singerOrAuthor: music.artistName.toString(),
            )
          : Container();

      final row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [card1, card2],
      );

      rowWidgets.addAll([row, const SizedBox(height: 15)]);
    }

    return Column(
      children: rowWidgets,
    );
  }
}
