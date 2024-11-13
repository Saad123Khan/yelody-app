import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yelody_app/res/colors/app_color.dart';


const kPaddingHorizontal =  EdgeInsets.symmetric(horizontal: 20);
const kMargin =  EdgeInsets.all(20);

TextTheme textTheme =  TextTheme(
  displayLarge: GoogleFonts.urbanist(
    fontSize: 102,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5
  ),
  displayMedium: GoogleFonts.urbanist(
    fontSize: 64,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5
  ),
  displaySmall: GoogleFonts.urbanist(
    fontSize: 51,
    fontWeight: FontWeight.w400
  ),
  headlineMedium: GoogleFonts.urbanist(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25
  ),


    headlineSmall: GoogleFonts.urbanist(
    fontSize: 28.sp,
fontWeight: FontWeight.w700,

     color: Colors.white,
  ),


  titleLarge: GoogleFonts.urbanist(
    fontSize: 21,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15
  ),
  titleMedium: GoogleFonts.urbanist(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15
  ),
  titleSmall: GoogleFonts.urbanist(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
        color:AppColor.primaryColor
    
  ),
  bodyLarge: GoogleFonts.urbanist(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5
  ),
  bodyMedium: GoogleFonts.urbanist(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25
  ),
  labelLarge: GoogleFonts.urbanist(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25
  ),
  bodySmall: GoogleFonts.urbanist(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4
  ),
  labelSmall: GoogleFonts.urbanist(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5
  ));

