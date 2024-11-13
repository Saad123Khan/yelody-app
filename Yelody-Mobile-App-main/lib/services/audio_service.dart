import 'dart:async';
import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'path_manager.dart';

class AudioRecordService {
  late final FlutterSoundRecorder _record;
  late final String _audioRecordBasePath;
  late final AudioSession _audioSession;

  String? get getPath => _audioRecordBasePath;
  AudioSession? get getAudioSession => _audioSession;

  init() async {
    log("/////-----------------Starting Audio Record Service -------------------------\\\\");
    _audioSession = await AudioSession.instance;
    await setSession();
    await setActiveSessionOfAudio();
    _record = FlutterSoundRecorder();
    _record.openRecorder();
    _audioRecordBasePath = await CustomPathManager.createCustomPath();

    _record.isRecording ? await _record.stopRecorder() : null;
  }

  Future setActiveSessionOfAudio() {
    print("----------Audio Session Active -----------");
    return _audioSession.setActive(true);
  }

  Future setSession() async {
    print("//////////------------_Setting Audio Session--------------///////");
    return await _audioSession.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.audibilityEnforced,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
      androidWillPauseWhenDucked: false,
    ));
  }

  Future<void> startAudioRecording() async {
    ///CHECK PERMISSIONS TO RECORD AUDIO FILE
    ///***********************************\\\\
    // if (await _record.hasPermission()) {
    // Start recording to file

    if (_record.isRecording) {
      return;
    } else {
      debugPrint("New Recoding Started");
      final dateTimeNow = DateTime.now();

      debugPrint(
          "Starting Recoding With Path :  $_audioRecordBasePath/audioCache_${dateTimeNow.microsecondsSinceEpoch}.mp4");

      // Future.delayed(const Duration(seconds: 1), () async {
      await _record.startRecorder(
        toFile:
            '$_audioRecordBasePath/audioCache_${dateTimeNow.microsecondsSinceEpoch}.mp4',
        codec: Codec.aacMP4,
      );
      print(
          '$_audioRecordBasePath/audioCache_${dateTimeNow.millisecondsSinceEpoch}.mp4');
    }

    // resumeRecoding();
  }

  Future<void> pauseRecording() async {
    ///PAUSE AUDIO RECODING
    ///***********************************\\\\
    if (_record.isRecording) {
      await _record.pauseRecorder();

      debugPrint("**********  Recording Paused   ************");
    } else {
      return;
    }
  }

  bool isRecording() {
    ///PAUSE AUDIO RECODING
    ///***********************************\\\\
    return _record.isRecording;
  }

  Future<void> resumeRecoding() async {
    ///RESUME AUDIO RECODING
    ///***********************************\\\\
    if (_record.isPaused) {
      await _record.resumeRecorder();
      debugPrint("**********  Recording Resume   ************");
    } else {
      return;
    }
  }

  Future<String?> stopAudioAndSaveFile() async {
    ///STOP AUDIO RECORDING IN GIVE ITS Full PATH
    ///***********************************\\\\
    debugPrint(
        "**********  Recording Stopped  Returning Saved File  ************");
    return await _record.stopRecorder();
  }

  Future<void> dispose() async {
    ///STOP AUDIO RECORDING IN GIVE ITS Full PATH
    ///***********************************\\\\
    debugPrint(
        "**********  Recording Stopped  Returning Saved File  ************");
    await _record.closeRecorder();
  }
}
