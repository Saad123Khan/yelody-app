import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyProfile/widgets/drag_handle_custom.dart';

import '../../../res/colors/app_color.dart';
import '../../../utils/utils.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(File)? setFile;

  const ImagePickerBottomSheet({super.key, this.setFile});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
            color: AppColor.darkBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  12,
                ),
                topRight: Radius.circular(12))),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomDragHandle(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Choose Picture',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Urbanist,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_camera,
                color: AppColor.primaryColor,
              ),
              title: const Text(
                "CAMERA",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.Urbanist,
                ),
                // color: AppColors.BLACK_COLOR,
                // textAlign: TextAlign.start,
                // fontWeight: FontWeight.w500,
              ),
              onTap: () => Utils.openImagePicker(
                source: ImageSource.camera,
                context: context,
                setFile: setFile,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(color: AppColor.primaryColor),
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColor.primaryColor,
              ),
              title: const Text(
                "GALLERY",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.Urbanist,
                ),
                // color: AppColors.BLACK_COLOR,
                // textAlign: TextAlign.start,
                // fontWeight: FontWeight.w500,
              ),
              onTap: () => Utils.openImagePicker(
                source: ImageSource.gallery,
                context: context,
                setFile: setFile,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
