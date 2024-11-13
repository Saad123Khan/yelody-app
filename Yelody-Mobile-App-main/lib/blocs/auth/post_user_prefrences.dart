import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/components/custom_alertdialog.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/services/shared_prefernces.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import '../../utils/app_navigation.dart';

class PostUserPrefrencesBloc {
  Response? _response;
  FormData? _formData;
  VoidCallback? _onSuccess, _onFailure;
  // OtpUserResponseModel? _loginResponse;

  void updatePrefernces({
    required BuildContext context,
    required VoidCallback setProgressBar,
    required List<String> ageGroups,
    required List<String> genre,
    required List<String> keywords,
  }) async {
    setProgressBar();
    final userID = GetxController.Get.find<AuthController>().getAppLoginSession;

    final Map<String, dynamic> _requestBody = {
      'userId': userID?.data?.userId,
      'ageGroup': ageGroups,
      'genre': genre,
      'keyword': keywords,
    };

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
      data: _requestBody,
      endPoint: NetworkStrings.userPrefrencesUpdateEndpoint,
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
  Future<void> _postRequest(
      {required String endPoint,
      required BuildContext context,
      required Map<String, dynamic> data}) async {
    _response = await Network().postRequest(
        endPoint: endPoint,
        isToast: true,
        formData: data,
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
    final data = GetxController.Get.find<AuthController>().getAppLoginSession;
    data?.data?.interestComplete = true;
    log("Kewords Resonse ${_response!.data}");

    GetxController.Get.find<AuthController>().updateUserRes(data);
    SharedPreference().setUser(user: jsonEncode(data?.toJson()));

    // GetxController.Get.offAllNamed(RouteName.bottomNavigation);
    // Show the congratulations dialog
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(onpressed: () {
          GetxController.Get.offAllNamed(RouteName.bottomNavigation);
        });
      },
    );

    // Navigate to the bottom navigation screen
    // GetxController.Get.offAllNamed(RouteName.bottomNavigation);
  }
}
