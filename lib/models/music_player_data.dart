import 'package:audio_service/audio_service.dart';
import 'package:moodee/models/song_model.dart';

class MusicPlayerData {
  final Song? currentSong;
  final List<Song> songQueue;
  final PlaybackState playbackState;
  final Duration? currentSongDuration;
  final Duration? currentSongPosition;

  MusicPlayerData(
      {this.currentSong,
      required this.songQueue,
      required this.playbackState,
      this.currentSongDuration,
      this.currentSongPosition});
}
