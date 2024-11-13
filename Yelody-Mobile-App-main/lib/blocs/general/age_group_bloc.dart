import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/models/age_group/age_group_model.dart';
import 'package:yelody_app/models/genre/genre_model.dart';
import 'package:yelody_app/models/keywords/keyword_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AddInterest/controller/createProfile_controller.dart';

import '../../utils/app_navigation.dart';
import 'keywords_bloc.dart';

class AgeGroupBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  // OtpUserResponseModel? _loginResponse;

  void loaddAllGrenres({
    required BuildContext context,
    required VoidCallback setProgressBar,
    Function()? onSuucess,
    bool isEditProfile = false,
  }) async {
    setProgressBar();

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(context);
    };
    //! ============> Call api
    await _getRequest(
      endPoint: NetworkStrings.getGenreAgeCombined,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(
        context,
      );

      _ageGroupReponseMethod(
          context: context, isEditprofile: isEditProfile, onSucecss: onSuucess);
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
  void _ageGroupReponseMethod(
      {required BuildContext context,
      bool isEditprofile = false,
      Function()? onSucecss}) async {
    try {
      log("Age Groupp Loaded Successfully");
      List<AgeGroupModel> genreList =
          List<dynamic>.from(_response?.data['data']['ageGroups'])
              .map((e) => AgeGroupModel.fromJson(e))
              .toList();

      // if (genreList.isNotEmpty) {
      //   genreList.insert(
      //     0,
      //     AgeGroupModel(
      //       name: 'all',
      //       ageGroupId: 'all',
      //     ),
      //   );
      // }
      final keywords = List<dynamic>.from(_response?.data['data']['keywords'])
          .map((e) => KeywordModel.fromJson(e))
          .toList();

      if (keywords.isNotEmpty) {
        keywords.insert(
          0,
          KeywordModel(name: 'all', keywordId: 'all'),
        );
      }

      final genres = List<dynamic>.from(_response?.data['data']['genres'])
          .map((e) => GenreModel.fromJson(e))
          .toList();

      if (genres.isNotEmpty) {
        genres.insert(
          0,
          GenreModel(genreId: 'all', type: 'all'),
        );
      }

      GetxController.Get.find<CompleteProfileCOntroller>().ageGruopList.value =
          genreList.toList();

      GetxController.Get.find<CompleteProfileCOntroller>().keywordList.value =
          keywords.toList();

      GetxController.Get.find<CompleteProfileCOntroller>().genreList.value =
          genres.toList();

      onSucecss?.call();

      if (isEditprofile) {
        GetxController.Get.find<CompleteProfileCOntroller>()
            .updateSelectedItems();

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          AgeGroupBloc().loaddAllGrenres(
              isEditProfile: false,
              context: context,
              setProgressBar: () {
                AppDialogs.progressAlertDialog(context: context);
              });
        });
      }
    } catch (e) {
      print(e.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
