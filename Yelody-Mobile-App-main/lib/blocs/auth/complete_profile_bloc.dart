import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:path/path.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/services/shared_prefernces.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';

import '../../models/login/user_model.dart';
import '../../utils/app_navigation.dart';

class CompleteProfileBloc {
  Response? _response;
  FormData? _formData;
  VoidCallback? _onSuccess, _onFailure;
  // OtpUserResponseModel? _loginResponse;

  void updateProfile(
      {required BuildContext context,
      required VoidCallback setProgressBar,
      required String email,
      required String name,
      required File? imagePath,
      required String description,
      required bool isGuest}) async {
    setProgressBar();

    final Map<String, dynamic> _requestBody = {
      'userName': name,
      'email': email,
      'description': description,
      'ageGroup': '20~29',
      'phone': '1324567890',
      'type': isGuest ? 'guest' : 'google',
      'profileComplete': true,
      'interestComplete': false,
    };

    print("Request Body $_requestBody");

    if (imagePath != null) {
      final imageName = basename(imagePath.path);
      _requestBody["image"] =
          await MultipartFile.fromFile(imagePath.path, filename: imageName);
    }

    _formData = FormData.fromMap(_requestBody);

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");

      final errors = _response?.data;
      AppDialogs.showToast(message: _response?.data['message'] ?? '');
      print("Errors $errors");
      AppNavigation.navigatorPop(context);
    };
    //! ============> Call api

    await _postRequest(
      endPoint: NetworkStrings.updateUSerEndpoint,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      AppNavigation.navigatorPop(context);
      log("Sucess CALL OF API");
      // AppNavigation.navigatorPop(context);
      _ageGroupReponseMethod(context: context);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
        endPoint: endPoint,
        isToast: true,
        formData: _formData,
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
    try {
      if (_response?.data['message'] == 'User has been created.') {
        print("Profile Created  Success");
        final data = AppLoginResponse.fromJson(_response?.data);
        print("User Data ${data.toJson()}");
        GetxController.Get.find<AuthController>().updateUserRes(data);
        SharedPreference().setUser(user: jsonEncode(_response?.data));
        GetxController.Get.offAndToNamed(RouteName.addInterestsScreen);
      } else {
        AppDialogs.showToast(message: _response?.data['message'] ?? '');
      }
    } catch (e) {
      print(e.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
