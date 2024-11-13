import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yelody_app/blocs/auth/upload_song.dart';
import 'package:yelody_app/services/audio_plyer_service.dart';
import 'package:yelody_app/utils/app_dialogs.dart';

class SoundPlayerScreen extends StatefulWidget {
  final String audioPath;
  final File? file;
  final String songID;
  final String fileUrl;
  const SoundPlayerScreen({
    required this.audioPath,
    required this.file,
    required this.songID,
    required this.fileUrl,
  });

  @override
  _SoundPlayerScreenState createState() => _SoundPlayerScreenState();
}

class _SoundPlayerScreenState extends State<SoundPlayerScreen> {
  AudioPlayerService audioPlayerService = AudioPlayerService.instance();
  String text = '';
  @override
  void initState() {
    super.initState();
  }

  Future<String> _readFileContent(File filePath) async {
    // Read the content of the file and return it
    String content = await filePath.readAsString();
    return content;
  }

  @override
  void dispose() {
    audioPlayerService.dispose();
    super.dispose();
  }

  void _playPause() {
    UploadSong().uploadSongForResult(
        singleSong: true,
        fileUrl: widget.fileUrl,
        songID: widget.songID,
        context: context,
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        },
        songPath: widget.audioPath);
    try {
      audioPlayerService.play(widget.audioPath, audioType: AudioType.file);
    } catch (e) {
      print("PlayBack error $e");
    }

    // if (isPlaying) {
    //   _audioPlayer.pause();
    // } else {
    //   _audioPlayer.play(DeviceFileSource(widget.audioPath.replaceFirst('.wav', '.mp3')), mode: PlayerMode.mediaPlayer);
    // }
    // setState(() {
    //   isPlaying = !isPlaying;
    // });
  }

  void _stop() {
    // _audioPlayer.stop();
    setState(() {
      // isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the audio file name or any other information
            Text('Audio: ${widget.audioPath.split('/').last}'),
            const SizedBox(height: 20),
            // Play/Pause button
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: _playPause,
            ),
            // Stop button
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: _stop,
            ),

            // Visibility(
            //   visible:  widget.file != null,
            //   child: FutureBuilder(
            //     future: _readFileContent(widget.file!),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return CircularProgressIndicator();
            //       } else if (snapshot.hasError) {
            //         return Text('Error: ${snapshot.error}');
            //       } else {
            //         return Text(snapshot.data.toString());
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
