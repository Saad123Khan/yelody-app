import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';

import '../../utils/app_navigation.dart';

class AddSongToQueBloc {
  Response? _response;
  Map<String, dynamic>? _data;
  VoidCallback? _onSuccess, _onFailure;
  void postSongToQue({
    required BuildContext context,
    required String songId,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(context);
    };
    final userID = GetxController.Get.find<AuthController>()
        .getAppLoginSession
        ?.data
        ?.userId;

    //! ============> Call api
    await _postRequest(
      endPoint:
          '${NetworkStrings.addSongToQueEndpoint}userId=$userID&songId=$songId',
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);
      _getSongByIdSuccessResponse(context: context);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postRequest({
    required String endPoint,
    required BuildContext context,
  }) async {
    _response = await Network().postRequest(
        endPoint: endPoint,
        context: context,
        formData: {},
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
  void _getSongByIdSuccessResponse({required BuildContext context}) async {
    try {
      AppDialogs.showToast(message: _response?.data['message'] ?? '');
    } catch (e) {
      print(e.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
