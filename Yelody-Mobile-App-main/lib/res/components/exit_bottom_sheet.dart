import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/utils/text.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyProfile/widgets/drag_handle_custom.dart';
import 'package:yelody_app/view/singMode/controller/songController.dart';

class ExitBottomSheet extends StatelessWidget {
  const ExitBottomSheet({
    super.key,
    required this.onTap,
    this.onTapCancel,
    required this.isCloseSong,
    required this.exit,
  });
  final Function onTap;
  final Function? onTapCancel;
  final bool isCloseSong;
  final Function() exit;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit.call();
        return true;
      },
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              color: AppColor.darkColor,
              borderRadius: BorderRadiusDirectional.horizontal(
                  start: Radius.circular(30), end: Radius.circular(30))),
          width: 1.sw,
          height: .25.sh,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const SizedBox(
                //   height: 5,
                // ),
                const CustomDragHandle(),
                SizedBox(
                  height: .02.sh,
                ),
                MyText.headingText('Quit Singing?'),
                SizedBox(
                  height: .05.sh,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          textColor: AppColor.whiteColor,
                          color: AppColor.secondaryTextColor,
                          onpressed: () {
                            // Get.back();
                            onTapCancel!.call();
                          },
                          text: 'Cancel'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: PrimaryButton(
                          onpressed: () {
                            onTap.call();
                          },
                          text: 'Yes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
