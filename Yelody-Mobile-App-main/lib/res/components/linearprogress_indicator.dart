import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: LinearProgressIndicator(
        color: AppColor.linearProgressColor,
        backgroundColor: AppColor.linearProgressIndicator,

        minHeight: 10.0.h,
        // borderRadius: BorderRadius.circular(32),
      ),
    );
  }
}
