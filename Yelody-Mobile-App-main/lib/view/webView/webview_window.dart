// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:yelody_app/res/app_url/network_strings.dart';
// import 'package:yelody_app/res/colors/app_color.dart';

// import 'controller/songController.dart';

// class ContentScreen extends StatelessWidget {
//   const ContentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final songController = Get.put(SongRecordController());
//     return Scaffold(
//       backgroundColor: AppColor.secondaryColor,
//       body: Obx(
//         () => Stack(
//           children: [
//             Opacity(
//               opacity: songController.opacity.value,
//               child: WebView(
//                 javascriptMode: JavascriptMode.unrestricted,
//                 javascriptChannels: {
//                   JavascriptChannel(
//                     name: 'playHandler',
//                     onMessageReceived: (message) {
//                       print(message);
//                     },
//                   )
//                 },
//                 initialUrl: NetworkStrings.webViewURL,
//                 onProgress: (progress) {
//                   songController.porgress.value = progress;
//                 },
//                 onWebViewCreated: (controller) {
//                   songController.inAppWebViewController = controller;
//                 },
//                 onWebResourceError: (error) {
//                   log("ERROR " + error.description.toString());
//                 },
//                 onPageStarted: (url) {
//                   songController.opacity.value = 1.0;
//                   songController.isLoading.value = false;
//                 },
//                 onPageFinished: (url) {
//                   // setState(() {
//                   //   _opacity = 1.0;
//                   //   _isLoading = false;
//                   // });

//                   songController.opacity.value = 1.0;
//                   songController.isLoading.value = false;
//                 },
//               ),
//             ),
//             Visibility(
//               visible: songController.isLoading.value,
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CircularProgressIndicator(
//                       strokeWidth: 3,
//                       backgroundColor: AppColor.whiteColor,
//                       color: AppColor.primaryColor,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//                 top: 30,
//                 child: IconButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       color: AppColor.whiteColor,
//                     ))),
//           ],
//         ),
//       ),
//     );
//   }
// }
