import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/blocs/playlist/getplaylist_byuserid_bloc.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/app_navigation.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

class DeletePlayListBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  // OtpUserResponseModel? _loginResponse;

  void deletePlayListByID({
    required BuildContext context,
    required String playListID,
    required VoidCallback setProgressBar,
    Function()? onFailure,
    Function()? onSuccess,
  }) async {
    setProgressBar();

//! ============> If Api f  ails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(context);
    };
    //! ============> Call api
    await _postRequest(
      endPoint: NetworkStrings.deletePlayListByID + playListID,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);
      _getGetAllPlayListResponse(
        context: context,
      );
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().deleteRequest(
        endPoint: endPoint,
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
  void _getGetAllPlayListResponse(
      {required BuildContext context, Function}) async {
    try {
      AppDialogs.showToast(message: _response?.data['message'] ?? '');
      GetPlayListByUserId().loadGetPlayListByUserId(
          context: context,
          sucess: () {
            GetxController.Get.find<HomeController>().selectedPlayList.value =
                null;
            Navigator.pop(context);
            Navigator.pop(context);
          },
          userId: GetxController.Get.find<AuthController>()
                  .getAppLoginSession
                  ?.data
                  ?.userId ??
              '',
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });
    } catch (e) {
      print(e.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
