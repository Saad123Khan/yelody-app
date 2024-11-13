import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class MusicPlayList extends StatelessWidget {
  final String songImage;
  final int topNumber;
  final String name;
  final String popular;
  final VoidCallback onPressed;
  final Function()? onImageTapped;
  final String? buttonText;
  final bool hideRank;
  final String genre;
  const MusicPlayList({
    super.key,
    required this.songImage,
    required this.topNumber,
    required this.name,
    required this.popular,
    required this.onPressed,
    this.buttonText,
    this.onImageTapped,
    required this.genre,
    this.hideRank = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onImageTapped,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: ShapeDecoration(
              // color: const Color.fromARGB(255, 53, 53, 53),
              color: Colors.white.withOpacity(0.10000000149011612),
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
                borderRadius: BorderRadius.circular(14),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !hideRank,
                      child: Text(
                        'Top #${topNumber}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
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
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: .47.sw,
                      child: Row(
                        children: [
                          SizedBox(
                            child: Text(
                              // 'Funk . ED Sheeran',
                              genre,
                              style: TextStyle(
                                  color: const Color(0xFF6C6D76),
                                  fontSize: 14.sp,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          // Container(
                          //   height: 3,
                          //   width: 3,
                          //   margin: const EdgeInsets.symmetric(horizontal: 5),
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: Colors.grey.shade800),
                          // ),
                          Container(
                            height: 3,
                            width: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade800),
                          ),
                          Expanded(
                            // width: 100,
                            child: Text(
                              // 'Funk . ED Sheeran',
                              popular,
                              style: TextStyle(
                                  color: const Color(0xFF6C6D76),
                                  fontSize: 14.sp,
                                  fontFamily: 'Urbanist',
                                  // overflow: TextOverflow.ellipsis
                                  // fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis),
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
          InkWell(
            onTap: onPressed,
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
                  SizedBox(
                      height: 18,
                      width: 18,
                      child: SvgPicture.asset("assets/icons/playicon.svg")),
                  SizedBox(width: 8.w),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MusicPlayListEditing extends StatelessWidget {
  final String songImage;
  final String name;
  final String popular;
  final String? buttonText;
  final bool hideRank;
  final Function(bool? onChanged) onChanged;
  final bool checkboxValue;

  const MusicPlayListEditing({
    super.key,
    required this.songImage,
    required this.name,
    required this.popular,
    this.buttonText,
    required this.onChanged,
    this.hideRank = false,
    required this.checkboxValue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: ShapeDecoration(
              // color: const Color.fromARGB(255, 53, 53, 53),
              color: Colors.white.withOpacity(0.10000000149011612),
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
                borderRadius: BorderRadius.circular(14),
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
                    SizedBox(
                      height: 3.h,
                    ),
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
                      height: 3.h,
                    ),
                    SizedBox(
                      width: .4.sw,
                      child: Text(
                        // 'Funk . ED Sheeran',
                        popular,
                        style: TextStyle(
                          color: const Color(0xFF6C6D76),
                          fontSize: 14.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // widget.checkboxValue.value = !widget.checkboxValue.value;
              if (checkboxValue) {
                onChanged(false);
              } else {
                onChanged(true);
              }
            },
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.primaryColor, width: 3),
                borderRadius: BorderRadius.circular(5.0),
                color:
                    checkboxValue ? AppColor.primaryColor : Colors.transparent,
              ),
              child: checkboxValue
                  ? const Icon(
                      Icons.check,
                      size: 14.0,
                      color: Colors.black,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
