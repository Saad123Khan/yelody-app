import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/agree_terms_condition.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/validations.dart';
import 'package:yelody_app/view/AccountProfile/controller/account_profile_controller.dart';
import 'package:yelody_app/view/AccountProfile/widgets/profile_widget.dart';
import '../../res/components/custom_textfield.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountProfileController());

    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Get.offAllNamed(RouteName.loginScreen);
          },
          child: Image.asset(
            'assets/icons/back_icon.png',
            scale: 2.5,
          ),
        ),
        backgroundColor: AppColor.darkBackgroundColor,
        title: Text(
          'Fill Your Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFE6E0E9),
            fontSize: 24.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(RouteName.loginScreen);
          return false;
        },
        child: SafeArea(
          bottom: true,
          top: false,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: controller.formKey,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50.h,
                              ),
                              Obx(
                                () => ProfilePictureWidget(
                                  borderWidth: 0,
                                  // size: 110.sp,
                                  profileImage: controller.imagePicked.value,
                                  size: 130.h,

                                  setFile: (p0) {
                                    controller.imagePicked.value = p0;
                                  },
                                  is_pickImage: true,
                                  upload_icon: true,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Visibility(
                                visible: controller.isGuest == false,
                                child: CustomTextField(
                                  validator: (v) =>
                                      FieldValidator.validateEmail(v!),
                                  readOnly: controller.email.isNotEmpty,
                                  hint: 'Email',
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(50)
                                  ],
                                  controller: controller.emailController,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              CustomTextField(
                                hint: 'Nickname',
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(15)
                                ],
                                validator: (p0) =>
                                    FieldValidator.validateUserName(
                                        p0, 'Nickname'),
                                controller: controller.nicknameController,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              CustomTextField(
                                lines: 1,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(270)
                                ],
                                validator: (p0) => FieldValidator.valiadteEmpty(
                                    p0, 'Description'),
                                hint: 'Description of yourself',
                                controller: controller.descriptionController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // reDetector(

                  // const Spacer(),
                  Expanded(
                      child: Column(
                    children: [
                      const AgreeTermsAndCondition(),
                      SizedBox(
                        height: 18.h,
                      ),
                      PrimaryButton(
                          onpressed: () {
                            controller.validateForm(context);
                          },
                          text: "Continue"),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ))
                ],
              ),
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
