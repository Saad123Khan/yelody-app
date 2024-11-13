import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/services/shared_prefernces.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/app_navigation.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/onboarding/onboarding_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            'assets/icons/back_icon.png',
            scale: 2.5,
          ),
        ),
        backgroundColor: AppColor.darkBackgroundColor,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFE6E0E9),
            fontSize: 22.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/man.svg"),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/information_icon.svg"),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'Help',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/about_icon.svg"),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'About',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.w,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFF2A2B39),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () async {
                        AppDialogs.progressAlertDialog(context: context);
                        await Future.delayed(const Duration(seconds: 3), () {
                          AppNavigation.navigatorPop(context);
                        });
                        SharedPreference().clear();
                        Get.find<AuthController>().updateUserRes(null);
                        Get.offAll(const OnboardingScreen());
                        AppDialogs.showToast(message: 'Logout Sucess');
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: const Color(0xFFF6AD00),
                          fontSize: 16.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
