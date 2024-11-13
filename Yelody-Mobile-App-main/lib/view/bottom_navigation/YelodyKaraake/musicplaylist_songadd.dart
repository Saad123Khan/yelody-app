import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class MusicPlayListSongADD extends StatelessWidget {
  final String songImage;
  final int topNumber;
  final String name;
  final String popular;
  final VoidCallback onPressed;
  final String genre;
  final Function() onImageTap;
  final String? text;
  final double? buttonWidth;
  const MusicPlayListSongADD({
    super.key,
    required this.songImage,
    required this.topNumber,
    required this.name,
    required this.popular,
    required this.genre,
    required this.onPressed,
    required this.onImageTap,
    this.buttonWidth,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onImageTap,
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: ShapeDecoration(
              color: Colors.grey,
              image:
                  //  DecorationImage(
                  //   image:

                  //       // AssetImage("assets/images/divide.png"),
                  //       AssetImage(songImage),
                  //   fit: BoxFit.fill,
                  // ),
                  DecorationImage(
                image: ExtendedNetworkImageProvider(
                    NetworkStrings.imageURL + songImage),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
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
                      'Top #${topNumber}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      width: .4.sw,
                      child: Text(
                        // 'Shape of you',
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      width: .44.sw,
                      child: Row(
                        children: [
                          Text(
                            genre,
                            style: TextStyle(
                              color: const Color(0xFF6C6D76),
                              fontSize: 12.sp,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            height: 3,
                            width: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade800),
                          ),
                          Expanded(
                            child: Text(
                              // 'Funk . ED Sheeran',
                              popular,
                              style: TextStyle(
                                color: const Color(0xFF6C6D76),
                                fontSize: 12.sp,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: buttonWidth ?? 76.w,
              height: 35.h,
              padding: text == null
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 6)
                  : EdgeInsets.zero,
              decoration: ShapeDecoration(
                color: AppColor.linearProgressIndicator,
                // color: text != null
                //     ? AppColor.primaryColor
                //     : Colors.white.withOpacity(0.10000000149011612),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: text != null
                          ? AppColor.primaryColor
                          : AppColor.darkBackgroundColor),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: text == null,
                      child: SvgPicture.asset("assets/images/add.svg")),
                  Visibility(
                      visible: text != null,
                      child: SizedBox(
                          height: 15,
                          width: 12,
                          child: SvgPicture.asset(
                              "assets/icons/correct_icon.svg"))),
                  SizedBox(
                    width: 8.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text(
                      text ?? 'Add',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

          // GestureDetector(
          //   onTap: onPressed,
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
        ],
      ),
    );
  }
}
