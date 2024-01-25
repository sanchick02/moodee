import 'package:audio_service/audio_service.dart';
import 'package:moodee/models/music_player_data.dart';
import 'package:moodee/models/song_model.dart';
import 'package:rxdart/rxdart.dart';

class SongRepository {
  SongRepository({required AudioHandler audioHandler})
      : _audioHandler = audioHandler;

  final AudioHandler _audioHandler;

  void play() => _audioHandler.play();

  void pause() => _audioHandler.pause();

  Stream<MusicPlayerData> get musicPlayerDataStream => Rx.combineLatest4<
              PlaybackState,
              List<MediaItem>,
              MediaItem?,
              Duration,
              MusicPlayerData>(
          _audioHandler.playbackState,
          _audioHandler.queue,
          _audioHandler.mediaItem,
          AudioService.position, (PlaybackState playbackState,
              List<MediaItem> queue, MediaItem? mediaItem, Duration position) {
        return MusicPlayerData(
          songQueue: queue.map((mediaItem) {
            return Song.fromMediaItem(mediaItem);
          }).toList(),
          playbackState: playbackState,
          currentSongPosition: position,
          currentSongDuration: (mediaItem == null) ? null : mediaItem.duration,
        );
      });

  Future<void> setCurrentSong(Song song) async {
    _audioHandler.removeQueueItemAt(0);
    _audioHandler.addQueueItem(song.toMediaItem());
  }
}
