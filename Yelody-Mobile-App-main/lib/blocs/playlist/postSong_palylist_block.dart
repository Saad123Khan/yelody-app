import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:path/path.dart';
import 'package:yelody_app/blocs/playlist/getplaylist_byuserid_bloc.dart';
import 'package:yelody_app/blocs/playlist/getsongs_byplaylistid_bloc.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';

import '../../utils/app_navigation.dart';

class PostSongPlaylistBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  Map<String, dynamic>? data;

  void createPostSongPlaylistMethod({
    required BuildContext context,
    Function()? onSuccessCalled,
    required String playlistId,
    required String songId,
    // required String name,
    // required File image,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    final Map<String, dynamic> _requestbody = {
      // 'name': name,
      // 'userId': GetxController.Get.find<AuthController>()
      //         .getAppLoginSession
      //         ?.data
      //         ?.userId ??
      //     ''
      "playlistId": playlistId,
      "songIds": [songId]
    };

    data = _requestbody;

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(context);
    };
    //! ============> Call api
    await _postReuqest(
      endPoint: NetworkStrings.postSongPlaylist,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      AppNavigation.navigatorPop(context);
      _getpostSongToPlaylistSuccessResponse(
          playListID: playlistId,
          context: context,
          successCalled: onSuccessCalled);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postReuqest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().putRequest(
        endPoint: endPoint,
        data: data,
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
  void _getpostSongToPlaylistSuccessResponse(
      {required BuildContext context,
      required String playListID,
      Function()? successCalled}) async {
    try {
      AppDialogs.showToast(message: _response?.data['message'] ?? '');

      print("post songs to playlist sucessfully");

      successCalled?.call();

      // GetSongsByPlayListIdBloc().loadGetSongsByPlayListId(
      //     context: context,
      //     id: playListID,
      //     setProgressBar: () {
      //       AppDialogs.progressAlertDialog(context: context);
      //     });

      // if (successCalled == null) {
      // GetPlayListByUserId().loadGetPlayListByUserId(
      //     context: context,
      //     userId: GetxController.Get.find<AuthController>()
      //             .getAppLoginSession
      //             ?.data
      //             ?.userId ??
      //         '',
      //     setProgressBar: () {
      //       AppDialogs.progressAlertDialog(context: context);
      //     });
      // }
    } catch (e) {
      print(e.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
