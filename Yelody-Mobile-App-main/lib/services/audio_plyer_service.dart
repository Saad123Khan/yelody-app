import 'package:flutter_sound/flutter_sound.dart';

enum AudioType { asset, network, file }

class AudioPlayerService {
  late final FlutterSoundPlayer _flutterSoundPlayer;
  late AudioType _audioType;
  late String _currentAudioPath;

  AudioPlayerService.instance() {
    _flutterSoundPlayer = FlutterSoundPlayer();
    _flutterSoundPlayer.openPlayer();
    _audioType = AudioType.file;
    _currentAudioPath = '';
  }

  Future<void> play(String audioPath,
      {AudioType audioType = AudioType.asset}) async {
    if (_flutterSoundPlayer.isStopped) {
      _audioType = audioType;
      _currentAudioPath = audioPath;

      if (_audioType == AudioType.file) {
        await _flutterSoundPlayer.startPlayer(
          fromURI: audioPath,
          codec: Codec.pcm16WAV,
        );
      } else {
        await _flutterSoundPlayer.startPlayer(
          fromURI: audioPath,
        );
      }
    }
  }

  Future<void> pause() async {
    if (_flutterSoundPlayer.isPlaying) {
      await _flutterSoundPlayer.pausePlayer();
    }
  }

  Future<void> resume() async {
    if (_flutterSoundPlayer.isPaused) {
      await _flutterSoundPlayer.resumePlayer();
    }
  }




  // You can add more methods as needed, such as stop, seek, etc.

  Future<void> dispose() async {
    await _flutterSoundPlayer.stopPlayer();
    await _flutterSoundPlayer.closePlayer();
  }
}
