import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:path/path.dart';
import 'package:yelody_app/models/login/user_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/services/shared_prefernces.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';

import '../../utils/app_navigation.dart';

class GuestLoginBloc {
  FormData? _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  String? deviceToken;

  void guestLoginBlocMethod({
    required BuildContext context,
    required File? image,
    required String userName,
    required String description,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    print("Guest Signing User");
    final Map<String, dynamic> _requestBody = {
      'userName': userName,
      'description': description,
      'type': 'guest',
    };

    print("Request Body $_requestBody");

    if (image != null) {
      final imageName = basename(image.path);
      _requestBody["image"] =
          await MultipartFile.fromFile(image.path, filename: imageName);
    }

    _formData = FormData.fromMap(_requestBody);

//! ============> If Api fails then stop the loader
    _onFailure = () {
      AppNavigation.navigatorPop(context);
      // print("Failure m Chala Gaya");
      // final error = _response?.data;
      // if (error?['email'] != null) {
      //   _emailNotFound(error['email']);
      // }
    };
    //! ============> Call api
    await _postRequest(
      endPoint: NetworkStrings.guestLoginEndPoint,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      // AppNavigation.navigatorPop(context);
      _guestLoginResponseMethod(context: context);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
        endPoint: endPoint,
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
  void _guestLoginResponseMethod({required BuildContext context}) async {
    try {
      print("USER USER Navigating to Add Intrest Screen  ");

      if (_response?.data['success'] == true) {
        SharedPreference().setUser(user: jsonEncode(_response?.data));
        final data = AppLoginResponse.fromJson(_response?.data);
        GetxController.Get.find<AuthController>().updateUserRes(data);
        AppDialogs.showToast(message: "Guest Login Success");
        GetxController.Get.offAndToNamed(RouteName.addInterestsScreen);
      } else {
        AppNavigation.navigatorPop(context);
        AppDialogs.showToast(
            message: _response?.data['message'] ??
                NetworkStrings.SOMETHING_WENT_WRONG);
      }
    } catch (e) {
      log("Exception m Chala Gya$e");
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
