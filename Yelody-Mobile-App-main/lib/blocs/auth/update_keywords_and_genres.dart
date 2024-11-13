import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/models/login/profile_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/AddInterest/controller/createProfile_controller.dart';
import '../../utils/app_navigation.dart';

class UpdateKeywordsAndGenres {
  Response? _response;
  Map<String, dynamic>? _formData;
  VoidCallback? _onSuccess, _onFailure;

  void updatePrefernces({
    required BuildContext context,
    required VoidCallback setProgressBar,
    required List<String> ageGroups,
    required List<String> genre,
    required List<String> keywords,
  }) async {
    setProgressBar();
    log("Updating Guest Profile Details");
    final userID = GetxController.Get.find<AuthController>().getAppLoginSession;

    final Map<String, dynamic> _requestBody = {
      'userId': userID?.data?.userId,
      'ageGroup': ageGroups,
      'genre': genre,
      'keyword': keywords,
    };

    _formData = _requestBody;

    print(
        "Reuqtes Body $_requestBody"); //! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");

      final errors = _response?.data;
      AppDialogs.showToast(message: _response?.data['message'] ?? '');
      print("Errors $errors");
      AppNavigation.navigatorPop(context);
    };
    //! ============> Call api

    await _postRequest(
      endPoint: NetworkStrings.updateUserPrefrences + userID!.data!.userId!,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      // AppNavigation.navigatorPop(context);
      _ageGroupReponseMethod(context: context);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postRequest({
    required String endPoint,
    required BuildContext context,
  }) async {
    _response = await Network().putRequest(
        endPoint: endPoint,
        isToast: true,
        data: _formData,
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
  void _ageGroupReponseMethod({required BuildContext context}) async {
    final profile = ProfileRes.fromJson(_response?.data);
    GetxController.Get.find<AuthController>().profileRes?.value = profile;
    GetxController.Get.close(2);
    AppDialogs.showToast(message: 'Profile has been updated successfully');
  }
}
