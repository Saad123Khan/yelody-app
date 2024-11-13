import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/text.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyProfile/widgets/drag_handle_custom.dart';
import 'package:yelody_app/view/singMode/controller/songController.dart';

class MoveToNextSheet extends StatelessWidget {
  const MoveToNextSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SongController>();
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            color: AppColor.darkColor,
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(30), topEnd: Radius.circular(30))),
        width: 1.sw,
        height: .25.sh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomDragHandle(),
              SizedBox(
                height: .02.sh,
              ),
              MyText.headingText('Moving to Next Song'),
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
                          Get.back();
                        },
                        text: 'Cancel'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: PrimaryButton(
                        onpressed: () {
                          if (controller.playlistModel.value != null) {
                            if (controller.currentSongIndex.value + 1 <
                                controller.playlistModel.value!.songs!.length) {
                              Get.back();

                              controller.playlistModel.value?.songs
                                  ?.removeAt(controller.currentSongIndex.value);

                              controller.refreshController(
                                  Get.context!,
                                  controller.playlistModel.value!.songs![
                                      controller.currentSongIndex.value],
                                  controller.currentSongIndex.value);
                            } else {
                              Get.back();
                              AppDialogs.showToast(
                                  message: 'No More Songs Next ');
                            }
                          } else {
                            Get.back();
                            AppDialogs.showToast(
                                message: 'No More Songs Next ');
                          }
                          // Get.back();
                        },
                        text: 'Ok'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
