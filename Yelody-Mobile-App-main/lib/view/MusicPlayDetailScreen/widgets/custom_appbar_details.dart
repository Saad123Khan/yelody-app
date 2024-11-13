import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yelody_app/res/colors/app_color.dart';

PreferredSizeWidget? CustomAppBar(
    {required BuildContext context,
    final String? title,
    final String? isLeading,
    void Function()? onclickLead,
    final String? isAction,
    void Function()? onclickAction,
    bool? isRegistration,
    Widget? actionWidget}) {
  return AppBar(
    leadingWidth: 48.sp,
    toolbarHeight: kToolbarHeight,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    titleSpacing: 5,
    title: Text(
      title ?? "",
      style: TextStyle(
        color: Colors.white,
        fontSize: 22.sp,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: false,
    leading: isLeading != null
        ? Builder(builder: (context) {
            return GestureDetector(
              onTap: onclickLead,
              child: Image.asset(
                isLeading,
                alignment: Alignment.center,
                scale: 2.5,
              ),
            );
          })
        : const SizedBox(),
    actions: [
      actionWidget ??
          (isAction != null
              ? Padding(
                  padding:
                      EdgeInsets.only(top: 0.023.sh, right: 15, bottom: 15),
                  child: InkWell(
                    onTap: onclickAction,
                    child: Image.asset(isAction,
                        scale: 3, alignment: Alignment.center),
                  ),
                )
              : const SizedBox())
    ],
  );
}
