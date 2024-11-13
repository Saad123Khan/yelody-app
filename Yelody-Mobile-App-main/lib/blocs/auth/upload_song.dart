import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/congratulations/congratulations.dart';
import 'package:yelody_app/view/singMode/controller/songController.dart';

import '../../utils/app_navigation.dart';

class UploadSong {
  Response? _response;
  FormData? _formData;
  VoidCallback? _onSuccess, _onFailure;

  void uploadSongForResult(
      {required BuildContext context,
      required VoidCallback setProgressBar,
      required String songID,
      required String songPath,
      required String fileUrl,
      int currentIndex = 0,
      PlayListData? playListData,
      required bool singleSong}) async {
    setProgressBar();
    final user = GetxController.Get.find<AuthController>();

    final Map<String, dynamic> requestBody = {
      'userId': user.getAppLoginSession?.data?.userId,
      // 'userId': '025413fa-8b6a-464a-a934-a4309e02bc21',
      'songId': songID,
      'text_file_url': NetworkStrings.imageURL + fileUrl,
      'model_size': 'tiny',
    };

    log("Request Body $requestBody");

    final file = File(songPath);
    requestBody["song"] = await MultipartFile.fromFile(file.path,
        filename: songPath.split('/').last);

    requestBody["file"] = await MultipartFile.fromFile(file.path,
        filename: songPath.split('/').last);

    log("Request Body $requestBody");
    log("Request Body ${file.path.split('/').last}");

    // requestBody["song"] = await MultipartFile.fromFile(file.path,
    //     filename: songPath.split('/').last);

    _formData = FormData.fromMap(requestBody);

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");

      AppNavigation.navigatorPop(context);
    };
    //! ============> Call api

    await _postRequest(
      endPoint: NetworkStrings.updateUSerEndpoint,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");

      AppNavigation.navigatorPop(context);
      _ageGroupReponseMethod(
          context: context,
          playListData: playListData,
          currentIndex: currentIndex);
      // AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
        endPoint: endPoint,
        fullUrl: NetworkStrings.uploadKarokey,
        isToast: true,
        formData: _formData,
        context: context,
        mapHeader: {
          'Content-Type': 'multipart/form-data',
        },
        onFailure: _onFailure,
        isHeaderRequire: true);

    // await Future.delayed(Duration(seconds: 5), () {
    //   _onSuccess?.call();
    //   Navigator.pop(context);
    // });
  }

  //! ============> Validate Response
  void _validateResponse() {
    if (_response != null) {
      Network().validateResponse(
        isToast: false,
        response: _response,
        onSuccess: _onSuccess,
        onFailure: _onFailure,
      );
    }
  }

  //! ============> Social Login Response
  void _ageGroupReponseMethod({
    required BuildContext context,
    bool singleSong = false,
    PlayListData? playListData,
    int currentIndex = 0,
  }) async {
    // try {
    print("Uploaded Updated Success");

    // final score = UploadSongRes.fromJson(_response?.data);
    await GetxController.Get.find<SongController>()
        .audioRecordService
        .dispose();
    GetxController.Get.delete<SongController>();
    AppDialogs.showToast(message: _response?.data['message'] ?? '');
    final double scre = _response?.data['similarity_score'] ?? 0.0;
    // GetxController.Get.off(() => CongratulationsScreen(
    //       score: scre.toStringAsFixed(2),
    //     ));

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CongratulationsScreen(
                  currentIndex: currentIndex,
                  playListData: playListData,
                  score: scre.toInt().toString(),
                  isSingleSongs: singleSong,
                )));
    // final data = LoginRes.fromJson(_response?.data);
    // SharedPreference().setUser(user: jsonEncode(_response?.data));
    // GetxController.Get.offAndToNamed(RouteName.addInterestsScreen);
    // AppDialogs.showToast(message: 'Updated Successfully');
  }

  // catch (e) {
  //   print(e.toString());
  //   AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
  // }
  // }
}
