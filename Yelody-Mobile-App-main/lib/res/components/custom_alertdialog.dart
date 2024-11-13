import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/view/bottom_navigation/bottom_navigation.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback onpressed;

  const CustomAlertDialog({super.key, required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFF1A1B22),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        height: 428,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                "assets/images/congratulations.svg",
                height: 180.h,
                width: 130.w,
              ),
              Text(
                'Congratulation!',
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 32.sp,
                  // height: .2,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
              // SizedBox(
              //   height: 3.h,
              // ),
              Text(
                'Your account is ready to use',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: .6,
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              PrimaryButton(
                // onpressed: () {
                //   // Navigator.of(context).pop();
                //   //  Get.toNamed(RouteName.homeScreenYellody) ;
                //   //  Get.toNamed(RouteName.featureClicked) ;

                //   //  Get.off(RouteName.bottomNavigation) ;
                //   Get.off(BottomNavigation());
                // },
                onpressed: onpressed,
                text: 'Go to Home',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
