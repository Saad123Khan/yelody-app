import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/routes/routes_name.dart';

class MyPlayListtoAddSong extends StatelessWidget {
  final String songImage;

  final String name;
  final String popular;
  final VoidCallback onPressed;
  final VoidCallback onPressedAdd;
  final String? text;
  const MyPlayListtoAddSong({
    super.key,
    required this.songImage,
    required this.name,
    required this.popular,
    this.text,
    required this.onPressed,
    required this.onPressedAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            width: 74.w,
            height: 74.h,
            decoration: ShapeDecoration(
                shape: CircleBorder(
              side: BorderSide(width: 4.w, color: Color(0xFF5D5E73)),
            )),
            child: Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(NetworkStrings.imageURL + songImage),
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
          // GestureDetector(
          //   onTap: () {
          //     Get.toNamed(RouteName.singMode);
          //   },
          //   child: Container(
          //     width: 90.w,
          //     height: 35.h,
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          //     decoration: ShapeDecoration(
          //       color: Colors.white.withOpacity(0.10000000149011612),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(100),
          //       ),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         SvgPicture.asset("assets/icons/playicon.svg"),
          //         Text(
          //           'Sing',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 14.sp,
          //             fontFamily: 'Urbanist',
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )

          GestureDetector(
            onTap: onPressedAdd,
            child: Container(
              width: 90.w,
              height: 35.h,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.10000000149011612),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Center(
                child: Text(
                  text ?? 'Add',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
