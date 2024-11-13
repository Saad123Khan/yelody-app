import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/linearprogress_indicator.dart';
import 'package:yelody_app/view_models/services/splash_services.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  void _onSuccess() {
    splashScreen.isLogin();
  }

  final SplashServices splashScreen = SplashServices();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onSuccess();
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: AppColor.secondaryColor,
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: Container(
              decoration: const BoxDecoration(
                color: AppColor.darkBackgroundColor,
                image: DecorationImage(
                  image: AssetImage("assets/images/splash.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    SizedBox(
                        width: size.width * 0.85.w,
                        height: 10.h,
                        child: const CustomLinearProgressIndicator()),
                    SizedBox(
                      height: 60.h,
                    ),
                  ]))),
    );
  }
}
