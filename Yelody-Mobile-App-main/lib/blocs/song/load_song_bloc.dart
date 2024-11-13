import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/services/path_manager.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/app_navigation.dart';
import 'package:yelody_app/view/singMode/controller/songController.dart';
import 'package:yelody_app/view/singMode/data/get_song_model.dart';

class LoadSongBloc {
  FormData? _formData;
  VoidCallback? _onSuccess, _onFailure, _onXMLSuccess, _onXMLFailure;
  Response? _response;
  Response? _xmlResponse;
  String? deviceToken;

  void loadSongByID({
    required BuildContext context,
    required String songID,
    required String lyricsId,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

//! ============> If Api fails then stop the loader
    _onFailure = () {
      AppNavigation.navigatorPop(context);
    };

    _onXMLFailure = () {
      AppNavigation.navigatorPop(context);
      AppDialogs.showToast(message: 'Error Loading Lyrics');
      log("XML Fail Hogyaaa");
    };

    _onXMLSuccess = () {
      AppNavigation.navigatorPop(context);
      log("XML Wala Method Success Hogyaaa");
      loadXml(context: context);
    };

    // await    getXML(endPoint: "${NetworkStrings.getXmLBySongID}3a1d1c45-5f0c-4799-abe7-44ec9ba65ada" , context: context);

    // ! ============> Call api
    await _postRequest(
      endPoint: NetworkStrings.getSongByIDEndpoint + songID,
      context: context,
    );

    //! ============> Get the Banners response
    _onSuccess = () {
      log("Sucess CALL OF API");
      // AppNavigation.navigatorPop(context);
      loadSongResponseMethod(
          context: context, songId: songID, lyricsId: lyricsId);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().getRequest(
        endPoint: endPoint,
        context: context,
        onFailure: _onFailure,
        isHeaderRequire: false);
  }

  Future<String?> getXML({
    required String endPoint,
    required BuildContext context,
    Function()? setProgressBar,
    Function()? successCallBack,
    Function()? failureCallBack,
  }) async {
    if (setProgressBar != null) {
      setProgressBar();
    }

    _xmlResponse = await Network().downloadFile(
      endpoint: endPoint,
      context: context,
      queryParameters: {},
      onSuccess: _onXMLSuccess,
      onFailure: _onXMLFailure,
    );

    if (_xmlResponse?.statusCode == 200) {
      _onXMLSuccess?.call();
      if (successCallBack != null) {
        successCallBack.call();
      }

      GetxController.Get.find<SongController>().lyricsInitilazied.value = true;
    } else {
      if (failureCallBack != null) {
        failureCallBack.call();
      }

      _onFailure?.call();
    }
  }

  void loadXMLData(
    BuildContext context,
    Function()? setProgressBar,
    String lyricsId,
  ) {
    setProgressBar?.call();

    log("Lyrics " + lyricsId);
    _onXMLFailure = () {
      AppNavigation.navigatorPop(context);
      AppDialogs.showToast(message: 'Error Loading Lyrics');
      log("XML Fail Hogyaaa");
    };

    _onXMLSuccess = () {
      AppNavigation.navigatorPop(context);
      log("XML Wala Method Success Hogyaaa");
      loadXml(context: context);
    };

    log("Preparing XML " + NetworkStrings.getXmLBySongID + lyricsId);

    getXML(
        endPoint: "${NetworkStrings.getXmLBySongID}$lyricsId",
        context: context);
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

  //! ============> Validate Response
  // void _validateXML() {
  //   if (_response != null) {
  //     Network().validateResponse(
  //       isToast: false,
  //       response: _xmlResponse,
  //       onSuccess: _onXMLSuccess,
  //       onFailure: _onXMLFailure,
  //     );
  //   }
  // }

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

  //! ============> Banners Response

  loadXml({required BuildContext context}) {
    final controller = GetxController.Get.find<SongController>();

    log("XML Null Nahiii hai ");

    log("XML RESPONSE DATA " + _xmlResponse!.data.toString());

    controller.xmlLyrics.value = _xmlResponse!.data.toString();
    controller.prepareLyrics();

    log("XML Chala Gaya ${controller.xmlLyrics.value}");
  }

  void loadSongResponseMethod(
      {required BuildContext context,
      required String songId,
      required String lyricsId}) async {
    try {
      log("Song Info Loaded Successfully");
      final controller = GetxController.Get.find<SongController>();

      controller.getSongModel.value =
          GetSongModel.fromJson(_response?.data['data']);

      // controller.songsBytes = controller.getSongModel.value?.songFile;
      log("${controller.getSongModel.value?.name}");
      if (controller.getSongModel.value?.songFile != null) {
        // controller.initSong();
        final path = await CustomPathManager.createCustomPath('files');

        Uint8List bytes = base64Decode(controller.getSongModel.value?.songFile);
        String filePath = "$path/$songId.mp3";
        final file = await File(filePath).writeAsBytes(bytes);

        controller.musicFile.value = file;
        log("File Write Hogyaaa............" + file.path.toString());
      }
      // if (controller.getSongModel.value?.lyricsXml == null) {
      //   AppDialogs.showToast(message: "Lyrics Not Found");
      // } else {
      await getXML(
          endPoint: "${NetworkStrings.getXmLBySongID}$lyricsId",
          context: context);
      //   // _validateXML();
      // }
    } catch (e) {
      print(e.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
