import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/blocs/auth/update_keywords_and_genres.dart';
import 'package:yelody_app/models/genre/genre_model.dart';
import 'package:yelody_app/models/keywords/keyword_model.dart';
import 'package:yelody_app/models/login/user_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/services/shared_prefernces.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/AddInterest/controller/createProfile_controller.dart';
import '../../utils/app_navigation.dart';

class UpdateUserPrfrencesAndProfileDetails {
  Response? _response;
  FormData? _formData;
  VoidCallback? _onSuccess, _onFailure;

  void updatePrefernces({
    required BuildContext context,
    required VoidCallback setProgressBar,
    required String name,
    required String description,
  }) async {
    setProgressBar();
    final userID = GetxController.Get.find<AuthController>().getAppLoginSession;

    final Map<String, dynamic> _requestBody = {
      'email': userID?.data?.email,
      'userName': name,
      'description': description,
      'profileComplete': true,
      'interestComplete': true
    };

    log("USer Data Requested $_requestBody");

    _formData = FormData.fromMap(_requestBody);

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
      endPoint:
          NetworkStrings.updateUserDetailsEndpoint + userID!.data!.userId!,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);

      // AppNavigation.navigatorPop(context);
      _ageGroupReponseMethod(context: context);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _postRequest({
    required String endPoint,
    required BuildContext context,
  }) async {
    _response = await Network().putRequest(
        endPoint: endPoint,
        isToast: true,
        data: _formData,
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
    log("USer Data Updated ${_response!.data}");
    final newUserData = AppLoginResponse.fromJson(_response?.data);
    if (_response?.data['success'] == true && newUserData.data != null) {
      GetxController.Get.find<AuthController>().updateUserRes(newUserData);
      newUserData.data?.profileComplete = true;
      newUserData.data?.interestComplete = true;
      SharedPreference().setUser(user: jsonEncode(newUserData.toJson()));
      // AppDialogs.showToast(message: _response?.data['message'] ?? '');

      final controller = GetxController.Get.find<CompleteProfileCOntroller>();

      List<String> keywords = [];
      List<String> generes = [];

      if (controller.selectedKeywords
          .contains(KeywordModel(keywordId: 'all', name: 'all'))) {
        log("SelectingAll Age Groups");
        keywords = controller.keywordList
            .map((element) => element.keywordId!)
            .toList();

        keywords.removeAt(0);
      } else {
        keywords = controller.selectedKeywords
            .map((element) => element.keywordId!)
            .toList();
      }

      // final ageGroups = controller.selectedAgeGroup
      //     .map((element) => element.ageGroupId!)
      //     .toList();

      if (controller.selectedgenre
          .contains(GenreModel(genreId: 'all', type: 'all'))) {
        log("SelectingAll Age Genres");
        generes =
            controller.genreList.map((element) => element.genreId!).toList();
        generes.removeAt(0);
      } else {
        generes = controller.selectedgenre
            .map((element) => element.genreId!)
            .toList();
      }

      UpdateKeywordsAndGenres().updatePrefernces(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          },
          ageGroups: [controller.selectedAgeGroup.value!.ageGroupId!],
          genre: generes,
          keywords: keywords);
    } else {
      AppDialogs.showToast(message: _response?.data['message'] ?? '');
    }
  }
}
