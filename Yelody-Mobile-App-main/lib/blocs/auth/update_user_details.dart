// import 'dart:developer';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' as GetxController;
// import 'package:path/path.dart';
// import 'package:yelody_app/res/app_url/network_strings.dart';
// import 'package:yelody_app/res/routes/routes_name.dart';
// import 'package:yelody_app/services/network.dart';
// import 'package:yelody_app/utils/app_dialogs.dart';
// import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
// import '../../utils/app_navigation.dart';

// class UpdateUserDetailsBloc {
//   Response? _response;
//   FormData? _formData;
//   VoidCallback? _onSuccess, _onFailure;

//   void updatePrefernces({
//     required BuildContext context,
//     required VoidCallback setProgressBar,
//     required String name,
//     required File imagePath,
//     required String description,
//   }) async {
//     setProgressBar();
//     log("Updating Guest Profile Details");
//     final userID = GetxController.Get.find<AuthController>().getAppLoginSession;

//     final Map<String, dynamic> _requestBody = {
//       'userName': name,
//       'phone': '',
//       'descrription': description,
//     };

//     final imageName = basename(imagePath.path);
//     _requestBody["image"] =
//         await MultipartFile.fromFile(imagePath.path, filename: imageName);

//     _formData = FormData.fromMap(_requestBody);

//     print(
//         "Reuqtes Body $_requestBody"); //! ============> If Api fails then stop the loader
//     _onFailure = () {
//       log("Genre CALL  FAILED");

//       final errors = _response?.data;
//       AppDialogs.showToast(message: _response?.data['message'] ?? '');
//       print("Errors $errors");
//       AppNavigation.navigatorPop(context);
//     };
//     //! ============> Call api

//     await _postRequest(
//       endPoint:
//           NetworkStrings.updateUserDetailsEndpoint + userID!.data!.userId!,
//       context: context,
//     );

//     //! ============> Get the login response
//     _onSuccess = () {
//       log("Sucess CALL OF API");
//       // AppNavigation.navigatorPop(context);
//       _ageGroupReponseMethod(context: context);
//     };

//     //! ============> Validate the response
//     _validateResponse();
//   }

//   //! ============> Post Request
//   Future<void> _postRequest({
//     required String endPoint,
//     required BuildContext context,
//   }) async {
//     _response = await Network().putRequest(
//         endPoint: endPoint,
//         isToast: true,
//         data: _formData,
//         context: context,
//         onFailure: _onFailure,
//         isHeaderRequire: false);
//   }

//   //! ============> Validate Response
//   void _validateResponse() {
//     if (_response != null) {
//       Network().validateResponse(
//         isToast: false,
//         response: _response,
//         onSuccess: _onSuccess,
//         onFailure: _onFailure,
//       );
//     }
//   }

//   //! ============> Social Login Response
//   void _ageGroupReponseMethod({required BuildContext context}) async {
//     GetxController.Get.offAllNamed(RouteName.addInterestsScreen);
//   }
// }
