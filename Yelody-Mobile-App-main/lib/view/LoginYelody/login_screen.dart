import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:yelody_app/blocs/auth/firebase_auth_bloc.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthBloc _firebaseAuthBloc = FirebaseAuthBloc();

    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  SvgPicture.asset("assets/images/login.svg"),
                  SizedBox(
                    height: 5.h,
                  ),
                  LoginRichText(),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                      onTap: () async {
                        // await showDialog(
                        //   barrierDismissible: false,
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return CustomAlertDialog(onpressed: () {
                        //       Get.offAllNamed(RouteName.bottomNavigation);
                        //     });
                        //   },
                        // );
                        // Get.toNamed(RouteName.profileScreen);
                        // Get.toNamed(RouteName.bottomNavigation);
                      },
                      child: const ContinueWithContainer(
                          imageIcon: "assets/icons/fb.svg", text: "Facebook")),
                  SizedBox(
                    height: 12.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        // Get.toNamed(RouteName.bottomNavigation);
                        print("Tapped Google");
                        _firebaseAuthBloc.signInWithGoogle(
                            context: context, socialType: 'google');
                        // googleSignIn();
                        // Get.toNamed(RouteName.bottomNavigation);

                        // showModalBottomSheet(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return Container(
                        //       width: double.infinity,
                        //          height: 220.h,
                        //       decoration: ShapeDecoration(
                        //         color: Color(0xFF1A1B22),
                        //         shape: RoundedRectangleBorder(
                        //           side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
                        //           borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(18),
                        //   topRight: Radius.circular(18),
                        //           ),
                        //         ),
                        //       ),
                        //      child: Padding(
                        //        padding: const EdgeInsets.symmetric(horizontal: 15),
                        //        child: Column(

                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //         SizedBox(height: 25.h,),
                        //         Text(
                        //     'Your email has been registered with Google Login, try again.',
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 20.sp,
                        //       fontFamily: 'Urbanist',
                        //       fontWeight: FontWeight.w700,

                        //     ),
                        //   ),

                        //       SizedBox(height: 15.h,),
                        //   Text.rich(
                        //     TextSpan(
                        //       children: [
                        //         TextSpan(
                        //           text: 'Try logging in with ',
                        //           style: TextStyle(
                        //             color: Color(0xFF6C6D76),
                        //             fontSize: 14.sp,
                        //             fontFamily: 'Urbanist',
                        //             fontWeight: FontWeight.w400,

                        //           ),
                        //         ),

                        //         TextSpan(
                        //           text: 'Google Login.',
                        //           style: TextStyle(
                        //             color:AppColor.primaryColor,
                        //             fontSize: 14.sp,
                        //             fontFamily: 'Urbanist',
                        //             fontWeight: FontWeight.w500,

                        //           ),
                        //         ),

                        //       ],
                        //     ),
                        //   ),
                        //      SizedBox(height: 30.h,),

                        //      PrimaryButton(onpressed: (){
                        //       Navigator.pop(context);
                        //      }, text: "Okay")
                        //        ],),
                        //      ),
                        //     );
                        //   },
                        // useSafeArea: false,
                        //   elevation: 0.0,
                        //   shape: RoundedRectangleBorder(
                        //           side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
                        //           borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(18),
                        //   topRight: Radius.circular(18),
                        //           ),
                        //         ),

                        // );
                      },
                      child: const ContinueWithContainer(
                          imageIcon: "assets/icons/google.svg",
                          text: "Google")),
                  SizedBox(
                    height: 12.h,
                  ),
                  Platform.isIOS
                      ? GestureDetector(
                          onTap: () {
                            _firebaseAuthBloc.signInWithApple(
                                context: context, socialType: 'apple');
                            // showDialog(
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return CustomAlertDialog();
                            //           },
                            //         );

                            // Get.toNamed(RouteName.bottomNavigation);
                          },
                          child: const ContinueWithContainer(
                              imageIcon: "assets/icons/apple.svg",
                              text: "Apple"))
                      : const SizedBox(),
                  SizedBox(
                    height: 30.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: MyText.TermsCondition(
                      'I agree with our',
                      'Terms of Service,',
                      'and',
                      'Privacy Policy.',
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.profileScreen, arguments: {
                        'isGuest': true,
                      });

                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return Container(
                      //       width: double.infinity,
                      //       height: 357.h,
                      //       decoration: ShapeDecoration(
                      //         color: Color(0xFF1A1B22),
                      //         shape: RoundedRectangleBorder(
                      //           side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
                      //           borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(18),
                      //   topRight: Radius.circular(18),
                      //           ),
                      //         ),
                      //       ),
                      //      child:
                      // Padding(
                      //        padding: const EdgeInsets.symmetric(horizontal: 15),
                      //        child: Column(

                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //         SizedBox(height: 25.h,),
                      //         Text(
                      //     'You need to login!',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 20.sp,
                      //       fontFamily: 'Urbanist',
                      //       fontWeight: FontWeight.w700,

                      //     ),
                      //   ),SizedBox(height: 25.h,),

                      //   ContinueWithContainer(imageIcon: "assets/icons/fb.svg",text:"Facebook" ), SizedBox(height: 12.h,),
                      //   ContinueWithContainer(imageIcon: "assets/icons/google.svg",text:"Google" ), SizedBox(height: 12.h,),
                      //   ContinueWithContainer(imageIcon: "assets/icons/apple.svg",text:"Apple" ),

                      //       SizedBox(height: 30.h,),
                      //   Center(
                      //     child: Text.rich(
                      //       TextSpan(
                      //         children: [
                      //           TextSpan(
                      //             text: 'You need to login when accessed by ',
                      //             style: TextStyle(
                      //               color: Color(0xFF6C6D76),
                      //               fontSize: 14.sp,
                      //               fontFamily: 'Urbanist',
                      //               fontWeight: FontWeight.w400,

                      //             ),
                      //           ),

                      //           TextSpan(
                      //             text: 'guest',
                      //             style: TextStyle(
                      //               color:AppColor.primaryColor,
                      //               fontSize: 14.sp,
                      //               fontFamily: 'Urbanist',
                      //               fontWeight: FontWeight.w500,

                      //             ),
                      //           ),

                      //         ],
                      //       ),
                      //     ),
                      //   ),

                      //        ],),
                      //      ),
                      //     );
                      //   },
                      // useSafeArea: false,
                      //   elevation: 0.0,
                      //   shape: RoundedRectangleBorder(
                      //           side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
                      //           borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(18),
                      //   topRight: Radius.circular(18),
                      //           ),
                      //         ),

                      // );
                    },
                    child: Text(
                      'Log in as guest',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContinueWithContainer extends StatelessWidget {
  final String imageIcon;
  final String text;
  const ContinueWithContainer({
    super.key,
    required this.imageIcon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56.h,
      decoration: ShapeDecoration(
        color: Color(0xFF23252F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            // "assets/icons/fb.svg",
            imageIcon,

            width: 21.w,
            height: 21.h,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Continue with',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text:
                      // ' Apple',
                      " ${text}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginRichText extends StatelessWidget {
  const LoginRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Log in to ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.h,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: 'Yelody',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 30.h,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
