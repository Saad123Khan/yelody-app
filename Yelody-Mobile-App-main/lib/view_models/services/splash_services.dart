import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:yelody_app/models/login/user_model.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/services/shared_prefernces.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/onboarding/onboarding_screen.dart';

class SplashServices {
  void isLogin() async {
    await SharedPreference().sharedPreference;

    final user = SharedPreference().getUser();

    if (user != null) {
      print("USER MIl GAYA");
      Get.find<AuthController>()
          .updateUserRes(AppLoginResponse.fromJson(jsonDecode(user)));

      final userData = Get.find<AuthController>().getAppLoginSession;

      print("user " + user.toString());

      if (userData?.data?.profileComplete == false) {
        Get.offAllNamed(RouteName.profileScreen,
            arguments: {'email': userData?.data?.email, 'isGuest': false});
      } else if (userData?.data?.interestComplete == false) {
        userData?.data?.interestComplete = true;
        Get.offAllNamed(RouteName.bottomNavigation);
        // Get.offAllNamed(RouteName.addInterestsScreen);
      } else {
        Timer(const Duration(seconds: 3),
            () => Get.offAllNamed(RouteName.bottomNavigation));
      }
    } else {
      Timer(
          const Duration(seconds: 3),
          () =>
              // Get.toNamed(RouteName.onboarding_screen)
              // Get.off(RouteName.onboarding_screen)
              // Get.off(OnboardingScreen()),
              Get.offAll(() => const OnboardingScreen()));
    }
  }
}
