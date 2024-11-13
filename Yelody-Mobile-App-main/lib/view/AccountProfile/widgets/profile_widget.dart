import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../res/colors/app_color.dart';
import '../../../utils/utils.dart';

class ProfilePictureWidget extends StatelessWidget {
  final File? profileImage;
  final Function(File)? setFile;
  Function()? onTap;
  final String? profileImageUrl;
  bool? is_pickImage, upload_icon;
  Color? borderColor;
  double? size, borderWidth;
  String? assetPath;
  double? topPadding;
  double? leftPadding;

  ProfilePictureWidget({
    this.profileImage,
    this.setFile,
    this.profileImageUrl,
    this.is_pickImage = false,
    this.borderColor,
    this.assetPath,
    this.onTap,
    this.upload_icon = false,
    this.borderWidth,
    this.size,
    this.topPadding,
    this.leftPadding,
  });

  @override
  Widget build(BuildContext context) {
    return _getImage(context);
  }

  Widget _getImage(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => is_pickImage == true
              ? Utils.showImageSourceSheet(context: context, setFile: setFile)
              : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _cameraIcon(),
          is_pickImage == true
              ? profileImage != null
                  ? const SizedBox.shrink()
                  : Image.asset(
                      'assets/images/profile_avatar.png',
                      scale: 3,
                    )
              : const SizedBox.shrink(),
          upload_icon == true
              ? Padding(
                  padding: EdgeInsets.only(
                      left: leftPadding ?? 0.27.sw, top: topPadding ?? .12.sh),
                  child: GestureDetector(
                      // onTap: () => Utils.showImageSourceSheet(
                      //     context: context, setFile: setFile),
                      child: Container(

                          // radius: 12,
                          // backgroundColor: AppColor.primaryColor,
                          child: SvgPicture.asset("assets/icons/edit.svg"))),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _cameraIcon() {
    return Container(
      // height: size ?? 100.h,
      // width: size ?? 100.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        // border: Border.all(
        //     color: borderColor ?? AppColor.blackColor, width: borderWidth ?? 0),
      ),
      child: Container(
        height: size ?? 100.h,
        width: size ?? 100.w,
        decoration: BoxDecoration(
            // color: AppColor.blackColor,
            shape: BoxShape.circle,
            image: profileImage != null
                ? DecorationImage(
                    image: FileImage(profileImage!),
                    fit: BoxFit.cover,
                  )
                : profileImageUrl != null
                    ? DecorationImage(
                        image: ExtendedNetworkImageProvider(profileImageUrl!),
                        fit: BoxFit.cover,
                      )
                    : assetPath != null
                        ? DecorationImage(
                            image: AssetImage(assetPath!),
                            fit: BoxFit.cover,
                          )
                        : null),
      ),
    );
  }
}
