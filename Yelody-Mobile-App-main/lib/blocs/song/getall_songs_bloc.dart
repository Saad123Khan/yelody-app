import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/models/songs/song_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/app_navigation.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

class GetAllSongsBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  Map<String, dynamic>? data;
  // OtpUserResponseModel? _loginResponse;

  void loadAllSongs({
    required BuildContext context,
    required VoidCallback setProgressBar,
    Function()? onFailure,
    Function()? onSuccess,
    bool applyFilter = false,
  }) async {
    setProgressBar();

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(context);
    };

    data = {'sortBy': 'name', 'order': 'asc'};

    if (applyFilter) {
      data?['location'] = GetxController.Get.find<HomeController>()
          .currentSelectedCountry
          .value;
    }

    //! ============> Call api
    await _postRequest(
      endPoint: NetworkStrings.getAllSongsEndpoint,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);
      _getAllSongsResponse(context: context);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postRequest({
    required String endPoint,
    required BuildContext context,
  }) async {
    _response = await Network().postRequest(
        endPoint: endPoint,
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
  void _getAllSongsResponse({required BuildContext context}) async {
    // try {
    final dataModel = SongsList.fromJson(_response?.data);

// Sort the songs by ranking
    dataModel.data?.sort((a, b) => a.rank!.compareTo(b.rank!));

// Assign the sorted songs to the controller
    // GetxController.Get.find<HomeController>().songs.value = sortedSongs;
    GetxController.Get.find<HomeController>().songs.value = dataModel;

    // } catch (e) {
    //   print(e.toString());
    //   AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    // }
  }
}
