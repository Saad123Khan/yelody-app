// import 'package:get/get.dart';
// // import 'package:webview_flutter/webview_flutter.dart';

// import '../widgets/show_toast.dart';

// class SongRecordController extends GetxController {
//   ////
//   RxBool isLoading = true.obs;
//   RxDouble opacity = 0.0.obs;
//   RxInt porgress = 0.obs;
//   // late final WebViewController inAppWebViewController;

//   ////CHECKING SOUND AND STORAGE PERMISSIONS
//   ///
//   handleArgs(dynamic args) {
//     final data = args as List<dynamic>;

//     if (data.first.toString() == 'start') {
//       showToastMessage(msg: 'Recording Started...');
//       // _audioService.startAudioRecording();
//     } else if (data.first.toString() == 'play') {
//       showToastMessage(msg: 'Recording Resumed...');
//       // _audioService.resumeRecoding();
//     } else if (data.first.toString() == 'pause') {
//       showToastMessage(msg: 'Recording Paused...');

//       // _audioService.pauseRecording();
//     } else if (data.first.toString() == 'end') {
//       showToastMessage(msg: 'Recording Ended...');
//       print("Saving Recoding...");
//       // isLoading.value = true;

//       songEndedApiCall();
//     }
//   }

//   songEndedApiCall() async {
//     // final recording = await _audioService.stopAudioAndSaveFile();

//     // if (recording != null) {
//     //   // final file = File(recording);
//     //   // await _audioService.releseReder();
//     //   print("Success File Name oF Recorded Audio File: $recording");

//     //   // // Navigator.pushReplacement(Get.con, newRoute)
//     //   // Get.off(AudioPlayerScreen(
//     //   //   audioPath: recording,
//     //   // ));

//     //   ///CallApiHere();
//     // }
//   }

//   @override
//   void onReady() {
//     // _audioService.init();
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     // inAppWebViewController.clearCache();
//     print("Cache CLeared");
//     super.onClose();
//   }
// }
