// import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerScreen extends StatefulWidget {
//   final String audioPath;

//   const AudioPlayerScreen({Key? key, required this.audioPath})
//       : super(key: key);

//   @override
//   _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
// }

// class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
//   late AudioPlayer _audioPlayer;
//   bool isPlaying = true;

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     _audioPlayer.onPlayerStateChanged.listen((event) {
//       if (event == PlayerState.playing) {
//         setState(() {
//           isPlaying = true;
//         });
//       } else {
//         setState(() {
//           isPlaying = false;
//         });
//       }
//     });
//   }

//   void play() async {
//     print("Playing FIle");
//     try {
//       await AudioPlayer().play(DeviceFileSource(Platform.isIOS
//           ? widget.audioPath.replaceFirst('/', '')
//           : widget.audioPath));
//     } catch (e) {
//       print("Error $e");
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Audio Player"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               !isPlaying ? Icons.pause : Icons.play_arrow,
//               size: 100,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_audioPlayer.state == PlayerState.paused) {
//                   await _audioPlayer.resume();
//                 } else {
//                   play();
//                 }
//               },
//               child: Text(!isPlaying ? "Resume" : "Play"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
