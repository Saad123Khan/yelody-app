import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class AppDialogs {
  //! ============> Flutter Custom Toast
  static void showToast({
    String? message,
    Toast? toastLength,
    int? timeInSecForIosWeb,
  }) {
    Fluttertoast.showToast(
      msg: message ?? "",
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: timeInSecForIosWeb ?? 1,
    );
  }

  //! ============> Spinkit for API call
  static void progressAlertDialog(
      {required BuildContext context, String loadingText = ''}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return Future.value(false);
          },
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColor.whiteColor,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  loadingText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.sp, color: AppColor.whiteColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
