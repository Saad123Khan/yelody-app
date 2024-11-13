import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:path/path.dart';
import 'package:yelody_app/blocs/playlist/getplaylist_byuserid_bloc.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

import '../../utils/app_navigation.dart';

class CreatePlayListBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  FormData? _formData;

  void createPlayListMethod({
    required BuildContext context,
    required String name,
    required File? image,
    Function()? onSuccess,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    final Map<String, dynamic> _requestbody = {
      'name': name,
      'userId': GetxController.Get.find<AuthController>()
              .getAppLoginSession
              ?.data
              ?.userId ??
          ''
    };

    if (image != null) {
      final imageName = basename(image.path);
      _requestbody["image"] =
          await MultipartFile.fromFile(image.path, filename: imageName);
    }

    _formData = FormData.fromMap(_requestbody);

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(context);
    };
    //! ============> Call api
    await _postReuqest(
      endPoint: NetworkStrings.createPlaylist,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);
      _getPlaylistByUserIdSuccessResponse(
          context: context, onSuccess: onSuccess);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postReuqest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
        endPoint: endPoint,
        formData: _formData,
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
  void _getPlaylistByUserIdSuccessResponse(
      {required BuildContext context, Function()? onSuccess}) async {
    // try {
    AppDialogs.showToast(message: _response?.data['message'] ?? '');

    final homeCOntroller = GetxController.Get.find<HomeController>();

    homeCOntroller.playListImagePciked.value = null;
    homeCOntroller.nameController.clear();

    GetPlayListByUserId().loadGetPlayListByUserId(
        context: context,
        sucess: () {
          onSuccess?.call();
        },
        userId: GetxController.Get.find<AuthController>()
                .getAppLoginSession
                ?.data
                ?.userId ??
            '',
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        });
    // } catch (e) {
    // print(e.toString());
    // AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    // }
  }
}
