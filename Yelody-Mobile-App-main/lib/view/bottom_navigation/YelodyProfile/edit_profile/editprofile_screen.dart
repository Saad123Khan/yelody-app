import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/general/age_group_bloc.dart';
import 'package:yelody_app/models/age_group/age_group_model.dart';
import 'package:yelody_app/models/genre/genre_model.dart';
import 'package:yelody_app/models/keywords/keyword_model.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/custom_choicechip.dart';
import 'package:yelody_app/res/components/custom_textfield.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/text.dart';
import 'package:yelody_app/utils/validations.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/AddInterest/controller/createProfile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final authCOntroller = Get.find<AuthController>();
  late CompleteProfileCOntroller controller;
  @override
  void initState() {
    controller = Get.find<CompleteProfileCOntroller>();
    final userController = Get.find<AuthController>().profileRes?.value;
    controller.emailController.text =
        userController?.data?.userDetails?.email ?? '';
    controller.nicknameController.text =
        userController?.data?.userDetails?.userName ?? '';
    controller.descriptionController.text =
        userController?.data?.userDetails?.description ?? '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AgeGroupBloc().loaddAllGrenres(
          isEditProfile: true,
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });
    });
    super.initState();
  }

  Widget _buidlKeywordsChips({required KeywordModel keywordModel}) {
    final completeProfileController = Get.find<CompleteProfileCOntroller>();

    return CustomChoiceChip(
      selected:
          completeProfileController.selectedKeywords.contains(keywordModel),
      label: '#${keywordModel.name}',
      onSelected: (bool selected) {
        if (selected) {
          if (keywordModel.keywordId == 'all') {
            completeProfileController.selectedKeywords.clear();
            completeProfileController.selectedKeywords.add(keywordModel);
          } else {
            // Remove 'all' if it's in the list
            completeProfileController.selectedKeywords
                .removeWhere((element) => element.keywordId == 'all');
            // Add the selected genre
            completeProfileController.selectedKeywords.add(keywordModel);
          }
        } else {
          completeProfileController.selectedKeywords.remove(keywordModel);
        }
      },
    );
  }

  Widget _buildAgeGroups({required AgeGroupModel genreModel}) {
    final selectedGroups =
        Get.find<CompleteProfileCOntroller>().selectedAgeGroup;

    return CustomChoiceChip(
      selected: selectedGroups.value?.ageGroupId == genreModel.ageGroupId,
      label: ' ${genreModel.name} ',
      onSelected: (bool selected) {
        if (selected) {
          selectedGroups.value = genreModel;
        } else {
          selectedGroups.value = null;
        }
      },
    );
  }

  Widget _buildGenreChoiceChips({required GenreModel genreModel}) {
    final completeProfileController = Get.find<CompleteProfileCOntroller>();
    return CustomChoiceChip(
      selected: completeProfileController.selectedgenre.contains(genreModel),
      label: '#${genreModel.type}',
      onSelected: (bool selected) {
        if (selected) {
          if (genreModel.genreId == 'all') {
            completeProfileController.selectedgenre.clear();
            completeProfileController.selectedgenre.add(genreModel);
          } else {
            // Remove 'all' if it's in the list
            completeProfileController.selectedgenre
                .removeWhere((element) => element.genreId == 'all');
            // Add the selected genre
            completeProfileController.selectedgenre.add(genreModel);
          }
        } else {
          completeProfileController.selectedgenre.remove(genreModel);
        }
      },
    );
  }

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: AppColor.darkBackgroundColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            'assets/icons/back_icon.png',
            scale: 2.5,
          ),
        ),
        title: Text(
          'Edit Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFE6E0E9),
            fontSize: 24.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Linked with',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: AppFonts.Urbanist,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      authCOntroller
                                  .profileRes?.value?.data?.userDetails?.type ==
                              'guest'
                          ? const Text(
                              'Guest Account',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/google.svg",
                                  width: 13.w,
                                  height: 13.h,
                                ),
                                Text(
                                  ' Google',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  SizedBox(
                    height: authCOntroller
                                .profileRes?.value?.data?.userDetails?.type ==
                            'guest'
                        ? 3.h
                        : 15.h,
                  ),

                  Visibility(
                    visible: authCOntroller
                            .profileRes?.value?.data?.userDetails?.type !=
                        'guest',
                    child: CustomTextField(
                      // validator: ,
                      hint: "connortack@gmail.com",
                      controller: controller.emailController,
                      readOnly: controller.emailController.text.isNotEmpty,
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    hint: 'Nickname',
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    validator: (p0) =>
                        FieldValidator.validateUserName(p0, 'Nickname'),
                    controller: controller.nicknameController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    inputFormatters: [LengthLimitingTextInputFormatter(250)],
                    controller: controller.descriptionController,
                    validator: (v) => FieldValidator.valiadteEmpty(v, 'Bio'),
                    hint: 'Bio',
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Your Interests',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyText.addInterestText("Age Group"),

                  SizedBox(
                    height: 18.h,
                  ),
                  // Single Select chip

                  Obx(() => Wrap(
                        spacing: 20,
                        runSpacing: 10,
                        children: controller.ageGruopList
                            .map((element) =>
                                _buildAgeGroups(genreModel: element))
                            .toList(),
                      )),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroup == 0,
                  //       label: '07-10',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroup = selected ? 0 : -1;
                  //         });
                  //       },
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroup == 1,
                  //       label: '20-29',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroup = selected ? 1 : -1;
                  //         });
                  //       },
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroup == 2,
                  //       label: '30-39',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroup = selected ? 2 : -1;
                  //         });
                  //       },
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroup == 3,
                  //       label: '40-49',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroup = selected ? 3 : -1;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),

                  // SizedBox(
                  //   height: 13.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroup == 4,
                  //       label: '50-59',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroup = selected ? 4 : -1;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),

                  SizedBox(
                    height: 25.h,
                  ),
                  MyText.addInterestText("Genre"),
                  SizedBox(
                    height: 13.h,
                  ),
                  //multi select start
                  Obx(() => Wrap(
                        spacing: 20,
                        runSpacing: 10,
                        children: controller.genreList
                            .map((element) =>
                                _buildGenreChoiceChips(genreModel: element))
                            .toList(),
                      )),
                  SizedBox(
                    height: 25.h,
                  ),

                  // Row(
                  //   children: [
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[0],
                  //       label: '#all',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[0] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[1],
                  //       label: '#Pop music',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[1] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[2],
                  //       label: '#Rock',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[2] = selected;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 13.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[3],
                  //       label: '#Hip hop',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[3] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[4],
                  //       label: '#Rhythm and blues',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[4] = selected;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),

                  // SizedBox(
                  //   height: 8.h,
                  // ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[5],
                  //       label: '#Classical',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[5] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[6],
                  //       label: '#Jazz',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[6] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[7],
                  //       label: '#Electronic',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[7] = selected;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 8.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[8],
                  //       label: '#Christian',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[8] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsMultiple[9],
                  //       label: '#Vocal',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsMultiple[9] = selected;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 25.h,
                  // ),
                  //multi select end

                  MyText.addInterestText("Keywords"),

                  SizedBox(
                    height: 13.h,
                  ),

                  Obx(() => Wrap(
                        spacing: 20,
                        runSpacing: 10,
                        children: controller.keywordList
                            .map((element) =>
                                _buidlKeywordsChips(keywordModel: element))
                            .toList(),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Row(
                  //   children: [
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsKeywords[0],
                  //       label: '#all',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsKeywords[0] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsKeywords[1],
                  //       label: '#Trendy',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsKeywords[1] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsKeywords[2],
                  //       label: '#Calm',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsKeywords[2] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsKeywords[3],
                  //       label: '#Fun',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsKeywords[3] = selected;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 13.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsKeywords[4],
                  //       label: '#Love',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsKeywords[4] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsKeywords[5],
                  //       label: '#Remake',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsKeywords[5] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsKeywords[6],
                  //       label: '#Birthday',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsKeywords[6] = selected;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),

                  // SizedBox(
                  //   height: 8.h,
                  // ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsKeywords[7],
                  //       label: '#Duet',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsKeywords[7] = selected;
                  //         });
                  //       },
                  //     ),
                  //     SizedBox(
                  //       width: 8.w,
                  //     ),
                  //     CustomChoiceChip(
                  //       selected: selectedAgeGroupsKeywords[8],
                  //       label: '#Scream',
                  //       onSelected: (bool selected) {
                  //         setState(() {
                  //           selectedAgeGroupsKeywords[8] = selected;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),

                  SizedBox(
                    height: 30.h,
                  ),

                  PrimaryButton(
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState?.save();
                          controller.updateProfile(context);
                        }

                        // Navigator.pop(context);
                      },
                      text: "Update"),

                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
