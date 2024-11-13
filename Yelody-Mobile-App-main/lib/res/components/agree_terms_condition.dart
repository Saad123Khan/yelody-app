import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/models/login/widgets/checkbox_with_title.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/view/AccountProfile/controller/account_profile_controller.dart';

class AgreeTermsAndCondition extends StatelessWidget {
  const AgreeTermsAndCondition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountProfileController>();
    return Row(
      children: [
        // SvgPicture.asset("assets/icons/correct_icon.svg"),

        CheckBoxWidget(
          isChecked: controller.isChecked.value,
          onCheckBoxStateChanged: (v) {
            controller.isChecked.value = v!;
          },
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'I agree with our ',
                    style: TextStyle(
                      color: Color(0xFF6C6D76),
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms of Service,',
                    style: TextStyle(
                      color: Color(0xFFF6AD00),
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: ' and',
                    style: TextStyle(
                      color: Color(0xFF6C6D76),
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Privacy Policy',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 14.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
