import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/exit_bottom_sheet.dart';
import 'package:yelody_app/res/components/move_to_next_sheet.dart';

import '../view/AccountProfile/widgets/image_picker_sheet.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.blackColor,
      textColor: AppColor.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.blackColor,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: AppColor.whiteColor,
    );
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }

  static void showImageSourceSheet({
    BuildContext? context,
    final Function(File)? setFile,
  }) {
    showModalBottomSheet(
      context: context!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ImagePickerBottomSheet(setFile: setFile);
      },
    );
  }

  static void showExitSheet({
    BuildContext? context,
    required Function() onTap,
    required Function() onTapCancel,
    required bool isCloseSong,
  }) {
    showModalBottomSheet(
      context: context!,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ExitBottomSheet(
          onTap: onTap,
          exit: onTapCancel,
          onTapCancel: onTapCancel,
          isCloseSong: isCloseSong,
        );
      },
    );
  }

  static void moveToNextSheet({BuildContext? context, Function()? onTapNext}) {
    showModalBottomSheet(
      context: context!,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const MoveToNextSheet();
      },
    );
  }

  static void showBottomSheetCustom({
    BuildContext? context,
    required Widget child,
    bool isScrolledControlled = true,
  }) {
    Get.bottomSheet(
      child,
      // context: context!,
      // useSafeArea: false,
      elevation: 0.0,
      ignoreSafeArea: true,
      isScrollControlled: isScrolledControlled,
      shape: const RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      backgroundColor: Colors.transparent,
      // builder: (BuildContext context) {
      //   return child;
      // },
    );
  }

  static void showAppDialog({
    required BuildContext context,
    required Widget child,
    Function()? onBackTap,
    Function()? onWIllPop,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(.4),
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              onWIllPop?.call();
              return Future.value(true);
            },
            child: Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 30),
              backgroundColor: AppColor.darkBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        padding: EdgeInsets.all(18.sp),
                        onPressed: () {
                          Get.back();
                          if (onBackTap != null) {
                            onBackTap.call();
                          }
                        },
                        icon: Icon(
                          Icons.close,
                          color: AppColor.whiteColor,
                          size: 24.sp,
                        )),
                  ),
                  child,
                ],
              ),
            ),
          );
        });
  }

  static Future openImagePicker({
    ImageSource? source,
    BuildContext? context,
    Function(File)? setFile,
    bool action = true,
  }) async {
    FocusScope.of(context!).unfocus();
    action == true ? Get.back() : null;
    try {
      final image =
          await ImagePicker().pickImage(source: source!, imageQuality: 50);
      if (image != null) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print(image.path);
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        setFile!(File(image.path));
        // cropImage(image: image.path, setFile: setFile, context: context);
      }
    } catch (e) {
      print(e.toString() + "5455555555555555555555555555555555555555555");
    }
  }
}
