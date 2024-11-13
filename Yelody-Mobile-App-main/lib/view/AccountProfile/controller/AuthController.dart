import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/auth/update_image.dart';
import 'package:yelody_app/models/login/profile_model.dart';
import 'package:yelody_app/models/login/user_model.dart';
import 'package:yelody_app/models/profile/getsing_historybyid_model.dart';
import 'package:yelody_app/utils/app_dialogs.dart';

class AuthController extends GetxController {
  AppLoginResponse? _loginRes;
  Rxn<ProfileRes>? profileRes = Rxn(null);
  updateUserRes(AppLoginResponse? res) {
    _loginRes = res;
  }

  Rxn<File> imagePicked = Rxn(null);

  updateUser(AppLoginResponse? res) {
    _loginRes = res;
  }

  AppLoginResponse? get getAppLoginSession => _loginRes;

  Rxn<UserSingHistory> getSingHistory = Rxn(null);

  getUserDetails(BuildContext context) {}

  updateProfileImage(BuildContext context) {
    if (imagePicked.value != null) {
      UpdateImageBloc().updatePrefernces(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          },
          image: imagePicked.value!);
    }
  }

  @override
  void onReady() {
    super.onInit();
  }
}
