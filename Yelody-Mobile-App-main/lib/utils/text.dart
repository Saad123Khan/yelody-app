import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class MyText {
//  Primarybuttontext
  static Widget PrimaryBtnText(
    String text, {
    Color? textColor,
  }) =>
      Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColor.linearProgressIndicator,
          fontSize: 16.sp,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
      );

  static Widget AppBarTextWidget(String text) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFFE6E0E9),
          fontSize: 22.sp,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        ),
      );
  static Widget HomeText(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        ),
      );

  static Widget TermsCondition(
    String text1,
    String text2,
    String text3,
    String text4,
  ) =>
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text:
                  // 'I agree with our ',
                  "${text1} ",
              style: TextStyle(
                color: Color(0xFF6C6D76),
                fontSize: 13.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text:
                  // 'Terms of Service,',
                  "${text2} ",
              style: TextStyle(
                color: Color(0xFFF6AD00),
                fontSize: 13.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text:
                  // ' and ',
                  "${text3} ",
              style: TextStyle(
                color: Color(0xFF6C6D76),
                fontSize: 13.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: "${text4} ",
              //  'Privacy Policy.',
              style: TextStyle(
                color: Color(0xFFF6AD00),
                fontSize: 13.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      );

  static Widget lyricsText(String text) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF95969F),
          height: 1.7,
          fontSize: 13.sp,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w400,
        ),
      );

  //fontsize 15 w600
  static Widget addInterestText(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        ),
      );

  //fontsize 15 w600
  static Widget headingText(
    String text, {
    Color? color,
    double? fontSize,
    double? height,
  }) =>
      Text(
        text,
        style: TextStyle(
          height: height ?? 1.5,
          color: color ?? Colors.white,
          fontSize: fontSize ?? 22.sp,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.bold,
        ),
      );

  //fontsize 15 w600
  static Widget labelText(String text) => Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );
  static Widget labelTextWhite(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );
  //fontsize 16 w600
  static Widget businesssubscription(String text) => Text(
        text,
        style: TextStyle(
          color: Color(0xff6f6f6f),
          fontSize: 16,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );

  //fontsize 13 w600
  static Widget forgetPassword(String text) => Text(
        text,
        style: TextStyle(
          color: Color(0xff848383),
          fontSize: 13,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );
  //fontsize 12 grey w600
  static Widget simplegreyText(String text) => Text(
        text,
        style: TextStyle(
          color: Color(0xff6f6d6d),
          fontSize: 12,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );
  //fontsize 12 black w600
  static Widget simpleblackText(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );
  //fontsize 12 blue w600
  static Widget simpleblueText(String text) => Text(
        text,
        style: TextStyle(
          color: Color(0xff00b0f0),
          fontSize: 12,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );

  //fontsize 10 w600
  static Widget viewText(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );

  //fontsize 12 w600
  static Widget simpleText(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );

  static Widget buttonText(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );

  static Widget h1(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 38.0,
          fontWeight: FontWeight.w700,
        ),
      );

  static Widget h2(String text) => Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 25.0,
        ),
      );

  static Widget body(String text) => Text(
        text,
        style: const TextStyle(
          color: Color(0xFF6E6E6E),
        ),
      );

  static Widget HeadingText(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
      );
  //tournament heading
  static Widget TournamentHeadingText(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
      );
  static Widget tableHeading(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
      );
  static Widget tableRow(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );
  static Widget selectRole(String text) => Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      );
  static Widget x(String text) => Text(
        text,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 20,
          color: Color(0xff535353),
          fontWeight: FontWeight.bold,
        ),
      );
}
