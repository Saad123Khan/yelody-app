import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/utils/text.dart';

class HeadSetDialog extends StatelessWidget {
  const HeadSetDialog({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 200,
            width: 1.sw,
            child: SvgPicture.asset('assets/images/singing_image.svg')),
        MyText.headingText('Use headsets!', color: AppColor.primaryColor),
        MyText.headingText('For Better Recodings', fontSize: 20.sp),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PrimaryButton(
              onpressed: () {
                onTap?.call();
              },
              text: 'Start with setting'),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
