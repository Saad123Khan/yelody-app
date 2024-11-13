import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/auth/post_user_prefrences.dart';
import 'package:yelody_app/blocs/auth/update_user_prefrences_and_profile.dart';
import 'package:yelody_app/blocs/general/age_group_bloc.dart';
import 'package:yelody_app/models/age_group/age_group_model.dart';
import 'package:yelody_app/models/genre/genre_model.dart';
import 'package:yelody_app/models/keywords/keyword_model.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';

class CompleteProfileCOntroller extends GetxController {
  RxList<GenreModel> genreList = <GenreModel>[].obs;
  RxList<KeywordModel> keywordList = <KeywordModel>[].obs;
  RxList<AgeGroupModel> ageGruopList = <AgeGroupModel>[].obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rxn<AgeGroupModel> selectedAgeGroup = Rxn(null);
  RxList<KeywordModel> selectedKeywords = <KeywordModel>[].obs;
  RxList<GenreModel> selectedgenre = <GenreModel>[].obs;

  updateSelectedItems() {
    final controller = Get.find<AuthController>();
    final selectedGenres = controller.profileRes?.value?.data?.genre ?? [];
    final kwordsSelected = controller.profileRes?.value?.data?.keyword ?? [];
    final selectedAgeGroups =
        controller.profileRes?.value?.data?.ageGroup ?? [];

    selectedgenre
        .assignAll(genreList.where((genre) => selectedGenres.contains(genre)));

    if (selectedGenres.length == genreList.length - 1) {
      selectedgenre.clear();
      selectedgenre.add(genreList.first);
    }

    selectedAgeGroup.value = selectedAgeGroups
        .where((keyword) => selectedAgeGroups.contains(keyword))
        .firstOrNull;

    selectedKeywords.assignAll(
        keywordList.where((keyword) => kwordsSelected.contains(keyword)));

    if (selectedKeywords.length == keywordList.length - 1) {
      selectedKeywords.clear();
      selectedKeywords.add(keywordList.first);
    }
  }

  getAllGenres() async {
    AgeGroupBloc().loaddAllGrenres(
        context: Get.context!,
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: Get.context!);
        });
  }

  selectOrDeselectGenre(GenreModel genreModel) {
    ///If ALL Selected
    if (genreModel.genreId == 'all') {
      selectedgenre.clear();
      selectedgenre.add(genreModel);
    } else if (selectedgenre.contains(genreModel)) {
      selectedgenre.remove(genreModel);
      selectedgenre.removeWhere((element) => element.genreId == 'all');
    } else {
      selectedgenre.add(genreModel);
      selectedgenre.removeWhere((element) => element.genreId == 'all');
    }

    // if (selectedgenre.contains(genreModel)) {
    //   selectedgenre.remove(genreModel);
    //   selectedgenre.removeWhere((element) => element.genreId == 'all');
    // } else if (genreModel.type == 'all') {
    //   selectAllgeneres();
    // } else {
    //   selectedgenre.add(genreModel);
    // }
  }

  selectAllgeneres() {
    for (var element in genreList) {
      if (!selectedgenre.contains(element)) {
        selectedgenre.add(element);
      }
    }
  }

  selectAllKeywords() {
    for (var element in keywordList) {
      if (!selectedgenre.contains(element)) {
        selectedKeywords.add(element);
      }
    }
  }

  // selectAllAgeGroups() {
  //   for (var element in ageGruopList) {
  //     if (!selectedAgeGroup.contains(element)) {
  //       selectedAgeGroup.add(element);
  //     }
  //   }
  // }

  @override
  void onReady() {
    getAllGenres();
    super.onReady();
  }

  updateProfile(BuildContext context) {
    if (selectedAgeGroup.value != null &&
        selectedKeywords.isNotEmpty &&
        selectedgenre.isNotEmpty) {
      UpdateUserPrfrencesAndProfileDetails().updatePrefernces(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          },
          name: nicknameController.text,
          description: descriptionController.text);
    } else {
      AppDialogs.showToast(message: 'Please select all data to updates');
    }
  }

  updatePrefrences(BuildContext context, {bool isEditProfile = false}) {
    if (selectedAgeGroup.value == null ||
        selectedgenre.isEmpty ||
        selectedKeywords.isEmpty) {
      AppDialogs.showToast(message: 'Please select complete data');
    } else {
      // final keywords =
      //     selectedKeywords.map((element) => element.keywordId!).toList();

      List<String> keywords = [];
      List<String> generes = [];

      if (selectedKeywords
          .contains(KeywordModel(keywordId: 'all', name: 'all'))) {
        log("SelectingAll Age Groups");
        keywords = keywordList.map((element) => element.keywordId!).toList();

        keywords.removeAt(0);
      } else {
        keywords =
            selectedKeywords.map((element) => element.keywordId!).toList();
      }

      // final ageGroups = [selectedAgeGroup.value!.ageGroupId!];

      if (selectedgenre.contains(GenreModel(genreId: 'all', type: 'all'))) {
        generes = genreList.map((element) => element.genreId!).toList();
        generes.removeAt(0);
      } else {
        generes = selectedgenre.map((element) => element.genreId!).toList();
      }

      print("Selected Age Group === ${selectedAgeGroup.value?.toJson()}");

      PostUserPrefrencesBloc().updatePrefernces(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          },
          ageGroups: [selectedAgeGroup.value!.ageGroupId!],
          genre: generes,
          keywords: keywords);
    }
  }
}
