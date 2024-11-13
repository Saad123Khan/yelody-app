import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';

import '../../utils/app_navigation.dart';

class DeleteSongFromPlayList {
  Response? _response;
  Map<String, dynamic>? _data;
  VoidCallback? _onSuccess, _onFailure;
  void postSongToQue({
    required BuildContext context,
    required List<String> songId,
    required String playListID,
    Function()? successCall,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(context);
    };
    // final userID = GetxController.Get.find<AuthController>()
    //     .getAppLoginSession
    //     ?.data
    //     ?.userId;

    _data = {"playlistId": playListID, "songIds": songId};
    //! ============> Call api
    await _deleteRequest(
      endPoint: NetworkStrings.deleteSongFromPlayList,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);
      _getSongByIdSuccessResponse(context: context, successCall: successCall);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _deleteRequest({
    required String endPoint,
    required BuildContext context,
  }) async {
    _response = await Network().deleteRequest(
        endPoint: endPoint,
        context: context,
        data: _data,
        onFailure: _onFailure,
        isHeaderRequire: false);
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
  void _getSongByIdSuccessResponse(
      {required BuildContext context, Function()? successCall}) async {
    try {
      AppDialogs.showToast(message: _response?.data['message'] ?? '');
      successCall?.call();
    } catch (e) {
      print(e.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
