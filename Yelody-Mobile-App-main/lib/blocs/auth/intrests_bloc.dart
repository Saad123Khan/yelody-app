import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/blocs/general/keywords_bloc.dart';
import 'package:yelody_app/models/genre/genre_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AddInterest/controller/createProfile_controller.dart';

import '../../utils/app_navigation.dart';

class GenreBloc {
  FormData? _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  // OtpUserResponseModel? _loginResponse;
  String? deviceToken;

  void loaddAllGrenres({
    required BuildContext context,
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
      endPoint: NetworkStrings.getGenreList,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);
      _socialloginResponseMethod(context: context);
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

  //! ============> INtreset  Response
  void _socialloginResponseMethod({required BuildContext context}) async {
    try {
      log("GENRE Loaded Successfully");
      final genreList = List<dynamic>.from(_response?.data['data'])
          .map((e) => GenreModel.fromJson(e));

      GetxController.Get.find<CompleteProfileCOntroller>().genreList.value =
          genreList.toList();
    } catch (e) {
      print(e.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
