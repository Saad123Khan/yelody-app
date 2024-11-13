import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/routes/routes_name.dart';

class MyPlayList extends StatelessWidget {
  final String songImage;

  final String name;
  final String popular;
  final VoidCallback onPressed;
  final VoidCallback? onButtonTapped;
  final String? buttonText;
  final String? buttonImage;
  const MyPlayList({
    super.key,
    required this.songImage,
    required this.name,
    required this.popular,
    required this.onPressed,
    this.buttonImage,
    this.buttonText,
    this.onButtonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            width: 74.w,
            height: 74.h,
            padding: const EdgeInsets.all(3),
            decoration: const ShapeDecoration(
                shape: CircleBorder(
              side: BorderSide(width: 1, color: Color(0xFF9E9E9E)),
            )),
            child: Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.white),
                image: songImage == 'null' || songImage == ''
                    ? const DecorationImage(
                        image: AssetImage('assets/icons/app_logo.png'),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image:
                            NetworkImage(NetworkStrings.imageURL + songImage),
                        fit: BoxFit.cover,
                      ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'Shape of you',
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      // 'Funk . ED Sheeran',
                      popular,
                      style: TextStyle(
                        color: Color(0xFF6C6D76),
                        fontSize: 14.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onButtonTapped ?? () {},
            child: Container(
              // width: 90.w,
              height: 30.h,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.10000000149011612),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Visibility(
                  //     visible: buttonText != 'Add',
                  //     child: SvgPicture.asset("assets/icons/playicon.svg")),
                  // SizedBox(width: 10.w),

                  Visibility(
                      replacement: SizedBox(
                          height: 18,
                          width: 18,
                          child: SvgPicture.asset(
                              buttonImage ?? "assets/icons/correct_icon.svg")),
                      visible: buttonText == null,
                      child: SvgPicture.asset("assets/images/add.svg")),

                  // Visibility(
                  //     visible: buttonText != null,
                  //     child: )),

                  SizedBox(
                    width: 8.w,
                  ),

                  Text(
                    buttonText ?? 'Sing',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // SizedBox(width: 3.w),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
