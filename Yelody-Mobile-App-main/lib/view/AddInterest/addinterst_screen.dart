import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/models/age_group/age_group_model.dart';
import 'package:yelody_app/models/genre/genre_model.dart';
import 'package:yelody_app/models/keywords/keyword_model.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/custom_alertdialog.dart';
import 'package:yelody_app/res/components/custom_choicechip.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/services/shared_prefernces.dart';
import 'package:yelody_app/utils/text.dart';
import 'package:yelody_app/view/AddInterest/controller/createProfile_controller.dart';

class AddInterestsScreen extends StatefulWidget {
  const AddInterestsScreen({Key? key}) : super(key: key);

  @override
  State<AddInterestsScreen> createState() => _AddInterestsScreenState();
}

class _AddInterestsScreenState extends State<AddInterestsScreen> {
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
    final completeProfileController = Get.find<CompleteProfileCOntroller>();

    return CustomChoiceChip(
      selected: completeProfileController.selectedAgeGroup.value?.ageGroupId ==
          genreModel.ageGroupId,
      label: ' ${genreModel.name} ',
      onSelected: (bool selected) {
        if (selected) {
          completeProfileController.selectedAgeGroup.value = genreModel;
        } else {
          completeProfileController.selectedAgeGroup.value = null;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompleteProfileCOntroller());
    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: PrimaryButton(
            onpressed: () {
              controller.updatePrefrences(context);
            },
            text: "Continue"),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColor.darkBackgroundColor,
        // leading: InkWell(
        //   onTap: () {
        //     SharedPreference().clear();
        //     Get.back();
        //     Get.back();
        //   },
        //   child: Image.asset(
        //     'assets/icons/back_icon.png',
        //     scale: 2.5,
        //   ),
        // ),
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Add your Interests',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFE6E0E9),
              fontSize: 24.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        titleSpacing: 0,
        actions: [
          InkWell(
            onTap: () async {
              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(onpressed: () {
                    Get.offAllNamed(RouteName.bottomNavigation);
                  });
                },
              );
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text("Skip",
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontFamily: AppFonts.Urbanist,
                        fontSize: 18.sp)),
              ),
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          // Get.back();
          // Get.back();
          // SharedPreference().clear();
          return Future.value(false);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: MyText.addInterestText("Age Group")),

                    SizedBox(
                      height: 15.h,
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

                    SizedBox(
                      height: 25.h,
                    ),
                    MyText.addInterestText("Genre"),
                    SizedBox(
                      height: 15.h,
                    ),

                    // _genereList(),

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

                    // //multi select end

                    MyText.addInterestText("Keywords"),

                    SizedBox(
                      height: 15.h,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
