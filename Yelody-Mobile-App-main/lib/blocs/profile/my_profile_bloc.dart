import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/models/login/profile_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/app_navigation.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';

class MyProfileBoc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  // OtpUserResponseModel? _loginResponse;
  String? deviceToken;

  void  loadMyProfile(
      {required BuildContext context,
      required VoidCallback setProgressBar,
      Function()? sucesss}) async {
    setProgressBar();

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(
        context,
      );
    };
    final id = GetxController.Get.find<AuthController>()
        .getAppLoginSession
        ?.data
        ?.userId;
    //! ============> Call api
    await _getRequest(
      endPoint: '${NetworkStrings.getUserDetailByIDEndpoint}$id',
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);
      _bannerSuccessResponse(context: context, suvcess: sucesss);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _getRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().getRequest(
        endPoint: endPoint,
        // formData: null,
        context: context,
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
  void _bannerSuccessResponse(
      {required BuildContext context, Function()? suvcess}) async {
    try {
      GetxController.Get.find<AuthController>().profileRes?.value =
          ProfileRes.fromJson(_response?.data);
      suvcess?.call();
    } catch (e) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
