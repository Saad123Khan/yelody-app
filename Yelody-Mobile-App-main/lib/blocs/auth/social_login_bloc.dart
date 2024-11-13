import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/models/login/user_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/services/shared_prefernces.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';

import '../../utils/app_navigation.dart';

class SocialLoginBloc {
  Map<String, dynamic>? _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  // OtpUserResponseModel? _loginResponse;
  String? deviceToken;

  void socialloginBlocMethod({
    required BuildContext context,
    required String accessToken,
    bool isApple = false,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    //! ============> Get the device token from firebaseservice class
    // deviceToken = await FirebaseMessagingService().getToken();

    //! ============> Form Data

    //! ============> Print Form Data
    print({
      "access_token": accessToken,
    });
//! ============> If Api fails then stop the loader
    _onFailure = () {
      AppNavigation.navigatorPop(context);
      print("Failure m Chala Gaya");
      final error = _response?.data;
      if (error?['email'] != null) {
        _emailNotFound(error['email']);
      }
    };
    final url =
        isApple ? NetworkStrings.appleLogin : NetworkStrings.loginGoogle;
    //! ============> Call api
    await _postRequest(
      endPoint: url + accessToken,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      // AppNavigation.navigatorPop(context);
      _socialloginResponseMethod(context: context, isAppleLogin: isApple);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  _emailNotFound(String email) {
    log("Email Not FOund ");
    GetxController.Get.toNamed(RouteName.profileScreen,
        arguments: {'email': email});
  }

  //! ============> Post Request
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
        endPoint: endPoint,
        // formData: ,
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

  // void validateExpection(BuildContext context) {
  //   if (_response != null) {
  //     Network().validateException(
  //       context: context,
  //       isToast: false,
  //       response: _response,
  //       // onSuccess: _onSuccess,
  //       onFailure: _onFailure,
  //     );
  //   }
  // }

  //! ============> Social Login Response
  void _socialloginResponseMethod(
      {required BuildContext context, bool isAppleLogin = false}) async {
    try {
      final data = _response?.data.toString();

      if (_response?.data['message'] == 'NEW USER') {
        print("USER USER Navigating to Add Profile Creation Screen  ");
        GetxController.Get.toNamed(RouteName.profileScreen, arguments: {
          'email': _response?.data['data']['email'],
          'isGuest': isAppleLogin
        });
      } else {
        log("Idhar Ja rha hai Ab");
        SharedPreference().setUser(user: jsonEncode(_response?.data));
        final data = AppLoginResponse.fromJson(_response?.data);
        GetxController.Get.find<AuthController>().updateUserRes(data);
        GetxController.Get.offAllNamed(RouteName.bottomNavigation);
        AppDialogs.showToast(message: "Login Success");
      }
    } catch (e) {
      log("Exception m Chala Gya$e");
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
