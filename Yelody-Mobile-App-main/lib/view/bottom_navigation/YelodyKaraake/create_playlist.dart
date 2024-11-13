import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/agree_terms_condition.dart';
import 'package:yelody_app/res/components/custom_textfield.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/utils/validations.dart';
import 'package:yelody_app/view/AccountProfile/controller/account_profile_controller.dart';
import 'package:yelody_app/view/AccountProfile/widgets/profile_widget.dart';

class CreatePlaylist extends StatelessWidget {
  const CreatePlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountProfileController());
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Create Playlist',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFE6E0E9),
            fontSize: 22.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),

                Obx(
                  () => ProfilePictureWidget(
                    // size: 110.sp,
                    profileImage: controller.imagePicked.value,
                    size: 120.h,
                    setFile: (p0) {
                      controller.imagePicked.value = p0;
                    },
                    is_pickImage: true,
                    upload_icon: true,
                  ),
                ),

                SizedBox(
                  height: 50.h,
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        validator: (v) => FieldValidator.validateEmail(v!),
                        readOnly: controller.email.isNotEmpty,
                        hint: 'Playlist Name',
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        controller: controller.emailController,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                        hint: 'Artist Name',
                        inputFormatters: [LengthLimitingTextInputFormatter(15)],
                        validator: (p0) =>
                            FieldValidator.validateUserName(p0, 'Nickname'),
                        controller: controller.nicknameController,
                      ),  
                      // SizedBox(
                      //   height: 16.h,
                      // ),
                      // CustomTextField(
                      //   lines: 3,
                      //   inputFormatters: [
                      //     LengthLimitingTextInputFormatter(270)
                      //   ],
                      //   validator: (p0) =>
                      //       FieldValidator.valiadteEmpty(p0, 'Description'),
                      //   hint: 'Description of yourself',
                      //   controller: controller.descriptionController,
                      // ),
                      // SizedBox(
                      //   height: 55.h,
                      // ),
                      // const AgreeTermsAndCondition(),
                      SizedBox(
                        height: 40.h,
                      ),

                      
                      PrimaryButton(
                          onpressed: () {
                            // controller.validateForm();
                            Navigator.pop(context);
                          },
                          text: "Create Playlist"),
                    ],
                  ),
                )
                //              GestureDetector(

                //       onTap:(){
                // Get.toNamed(RouteName.addInterestsScreen);},
                //     child: Container(
                //           width: double.infinity,
                //           height: 56.h,
                //           decoration: ShapeDecoration(
                //             color:
                //           (areFieldsFilledAndValidated()) ?
                //             AppColor.primaryColor:
                //              Color(0xff514716),
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(28),
                //             ),
                //           ),
                //           child: Center(child: MyText.PrimaryBtnText("Continue")

                //           )),
                //     )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContinueWithContainer extends StatelessWidget {
  final String imageIcon;
  final String text;
  const ContinueWithContainer({
    super.key,
    required this.imageIcon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56.h,
      decoration: ShapeDecoration(
        color: Color(0xFF23252F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            // "assets/icons/fb.svg",
            imageIcon,

            width: 21.w,
            height: 21.h,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Continue with',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text:
                      // ' Apple',
                      " ${text}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginRichText extends StatelessWidget {
  const LoginRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Log in to ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.h,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: 'Yelody',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 30.h,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
