import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/models/charts/getchartSongsbyid_model.dart';
import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';
import 'package:yelody_app/models/songs/getsongbyid_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/MusicPlayDetailScreen/data/musicplaydetails_controller.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

import '../../utils/app_navigation.dart';

class GetSongsByPlayListIdBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  // OtpUserResponseModel? _loginResponse;
  String? deviceToken;

  void loadGetSongsByPlayListId({
    required BuildContext context,
    required String id,
    Function()? onSuccess,
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
      endPoint: '${NetworkStrings.getSongByPlaylistId}?id=$id',
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);
      _getSongsByPlayListIdSuccessResponse(
          context: context, onSuccess: onSuccess);
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
  void _getSongsByPlayListIdSuccessResponse(
      {required BuildContext context, Function()? onSuccess}) async {
    // try {
    final dataModel = GetSongByPlaylistIdModel.fromJson(_response?.data);

    GetxController.Get.find<HomeController>().getSongbyPlaylistId.value =
        dataModel;
    onSuccess?.call();
    // } catch (e) {
    //   print(e.toString());
    //   AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    // }
  }
}
