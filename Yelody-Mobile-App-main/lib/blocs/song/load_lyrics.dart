import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/models/songs/getsongbyid_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/MusicPlayDetailScreen/data/musicplaydetails_controller.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

import '../../utils/app_navigation.dart';

class LoadLyricsBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void getLyrics({
    required BuildContext context,
    required String lyricFile,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(context);
    };
    //! ============> Call api

    await _getRequest(
      endPoint: '${NetworkStrings.getXmLBySongID}$lyricFile',
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
  Future<void> _getRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().getRequest(
        fullURlm: endPoint,
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
  void _getSongByIdSuccessResponse({required BuildContext context}) async {
    // try {
    // final dataModel = GetSongByIdModel.fromJson(_response?.data);
    log("_RES " + _response?.data);

    final controller = GetxController.Get.find<HomeController>();
    controller.currentLyrics.value = _response!.data.toString();

    print("------------------------------");
    // print(dataModel.data);
    // GetxController.Get.find<MusicPlayDetailsController>().musicDetails.value = dataModel;
    // } catch (e) {
    // print(e.toString());
    // AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    // }
  }
}
