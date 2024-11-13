import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/utils/text.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onpressed;
  final Color? color;
  final String? image;
  final Color? textColor;
  final String text;
  final double?  height;
  const PrimaryButton({
    super.key,
    required this.onpressed,
    required this.text,
    this.image,
    this.color,
    this.textColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
          width: double.infinity,
          height: height ?? 56.h,
          decoration: ShapeDecoration(
            color: color ?? AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          child: image != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      image!,
                      scale: 3,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MyText.PrimaryBtnText(text, textColor: textColor),
                  ],
                )
              : Center(
                  child: MyText.PrimaryBtnText(text, textColor: textColor))),
    );
  }
}
