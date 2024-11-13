import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/auth/complete_profile_bloc.dart';
import 'package:yelody_app/blocs/auth/guest_login_bloc.dart';
import 'package:yelody_app/utils/app_dialogs.dart';

class AccountProfileController extends GetxController {
  late final String email;
  late final bool isGuest;

  late final TextEditingController emailController;

  late final TextEditingController nicknameController;

  late final TextEditingController descriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rxn<File> imagePicked = Rxn(null);
  RxBool isChecked = false.obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    nicknameController = TextEditingController();
    descriptionController = TextEditingController();
    email = Get.arguments?['email'] ?? '';
    isGuest = Get.arguments?['isGuest'] ?? false;
    emailController.text = email;
    super.onInit();
  }

  validateForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();

      print("IS Guest $isGuest");

      if (isChecked.value) {
        if (isGuest) {
          GuestLoginBloc().guestLoginBlocMethod(
              context: context,
              image: imagePicked.value,
              userName: nicknameController.text,
              description: descriptionController.text,
              setProgressBar: () {
                AppDialogs.progressAlertDialog(context: context);
              });
        } else {
          print("User IS Nor Gest Ser ");
          CompleteProfileBloc().updateProfile(
              isGuest: isGuest,
              context: Get.context!,
              setProgressBar: () {
                AppDialogs.progressAlertDialog(context: Get.context!);
              },
              email: email,
              name: nicknameController.text,
              imagePath: imagePicked.value,
              description: descriptionController.text);
        }
      } else {
        AppDialogs.showToast(
            message: 'Please Accept Terms and Conditions Sign up.');
      }

      // Get.toNamed(RouteName.addInterestsScreen);
    }
  }
}
