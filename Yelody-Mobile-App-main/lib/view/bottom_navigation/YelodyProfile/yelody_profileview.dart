import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/general/age_group_bloc.dart';
import 'package:yelody_app/blocs/profile/getsing_history_byuserid_bloc.dart';
import 'package:yelody_app/blocs/profile/my_profile_bloc.dart';
import 'package:yelody_app/models/profile/getsing_historybyid_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/custom_choicechip.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/utils.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/AccountProfile/widgets/profile_widget.dart';
import 'package:yelody_app/view/AddInterest/controller/createProfile_controller.dart';

import 'widgets/drag_handle_custom.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final profileController = Get.put(CompleteProfileCOntroller());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      MyProfileBoc().loadMyProfile(
          context: context,
          sucesss: () {
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            AgeGroupBloc().loaddAllGrenres(
                isEditProfile: true,
                context: context,
                onSuucess: () {
                  checkForProfileInfo();
                },
                setProgressBar: () {
                  AppDialogs.progressAlertDialog(context: context);
                });
            // });
          },
          setProgressBar: () {
            AppDialogs.progressAlertDialog(
              context: context,
            );
          });

      GetSingHistoryById().loadSingHistoryById(
          context: context,
          userId:
              Get.find<AuthController>().getAppLoginSession?.data?.userId ?? '',
          setProgressBar: () {
            AppDialogs.progressAlertDialog(
              context: context,
            );
          });
    });

    super.initState();
  }

  checkForProfileInfo() {
    final controller = Get.find<AuthController>();
    final kwordsSelected = controller.profileRes?.value?.data?.genre ?? [];

    profileController.selectedgenre.assignAll(profileController.genreList
        .where((keyword) => kwordsSelected.contains(keyword)));

    if (profileController.selectedgenre.length ==
        profileController.genreList.length - 1) {
      profileController.selectedgenre.clear();
      profileController.selectedgenre.add(profileController.genreList.first);
    }
  }

  // List<MusicPlaylist> playlists = [
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
        backgroundColor: AppColor.darkBackgroundColor,
        appBar: AppBar(
          leadingWidth: 50,
          elevation: 0,
          backgroundColor: AppColor.darkBackgroundColor,
          leading: Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 0, top: 12, bottom: 10),
            child: Image.asset("assets/icons/app_logo.png"),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.put(CompleteProfileCOntroller());
                  Get.toNamed(RouteName.editProfileScreen);
                },
                child: SvgPicture.asset("assets/icons/edit_icon.svg")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                  onTap: () {
                    Utils.showBottomSheetCustom(
                        context: context,
                        child: Container(
                          width: double.infinity,
                          height: 140.h,
                          decoration: const ShapeDecoration(
                            color: AppColor.darkBackgroundColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFF2A2B39)),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CustomDragHandle(),
                                SizedBox(
                                  height: 30.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(RouteName.settingScreen);
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/setting_icon.svg"),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        'Settings',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/icons/information_icon.svg"),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      'Information Center',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));

                    // showModalBottomSheet(
                    //   backgroundColor: AppColor.darkBackgroundColor,
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return

                    //   },
                    //   useSafeArea: false,
                    //   elevation: 0.0,
                    //   shape: RoundedRectangleBorder(
                    //     side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(18),
                    //       topRight: Radius.circular(18),
                    //     ),
                    //   ),
                    // );
                  },
                  child: SvgPicture.asset("assets/icons/chat_icon.svg")),
            ),
          ],
          title: Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE6E0E9),
              fontSize: 22.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          // primary: true,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  // Stack(
                  //   children: [
                  //     controller.getAppLoginSession?.data?.image != null
                  //         ? Image.network(NetworkStrings.imageURL +
                  //             controller.getAppLoginSession!.data!.image!)
                  //         : Image.asset(
                  //             "assets/images/john_Doe.png",
                  //             width: 140.w,
                  //             height: 140.h,
                  //           ),
                  //     Positioned(
                  //         top: 93.h,
                  //         right: 10.w,
                  //         child: SvgPicture.asset("assets/icons/edit.svg"))
                  //   ],
                  // ),

                  Obx(() =>

                          //  controller.getAppLoginSession?.data?.image != null
                          //     ?

                          ProfilePictureWidget(
                              is_pickImage: false,
                              leftPadding: 0.22.sw,
                              topPadding: .10.sh,
                              // borderWidth: 0,
                              // borderColor: Colors.transparent,
                              // size: 100.h,
                              // setFile: (p0) {
                              //   controller.imagePicked.value = p0;
                              // },
                              profileImage: controller.imagePicked.value,
                              upload_icon: true,
                              onTap: () {
                                Utils.showImageSourceSheet(
                                  context: context,
                                  setFile: (p0) {
                                    controller.imagePicked.value = p0;
                                    controller.updateProfileImage(context);
                                  },
                                );
                              },
                              assetPath:
                                  controller.getAppLoginSession?.data?.image ==
                                          null
                                      ? 'assets/images/profile_avatar.png'
                                      : null,
                              profileImageUrl:
                                  controller.getAppLoginSession?.data?.image ==
                                          null
                                      ? null
                                      : NetworkStrings.imageURL +
                                          controller
                                              .getAppLoginSession!.data!.image!)
                      // : ProfilePictureWidget(
                      //     profileImage: controller.imagePicked.value,
                      //     is_pickImage: false,
                      //     assetPath: 'assets/images/.png',
                      //     upload_icon: true,
                      //   ),

                      ),

                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          controller.profileRes?.value?.data?.userDetails
                                  ?.userName ??
                              'Guest',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),

                  Obx(() => controller.profileRes?.value?.data != null
                      ? Wrap(
                          runSpacing: 5,
                          spacing: 8,
                          children: profileController
                                      .selectedgenre.isNotEmpty &&
                                  profileController.selectedgenre[0].genreId ==
                                      'all'
                              ? [
                                  CustomChoiceChip(
                                    selected: false,
                                    label: ' #all ',
                                    onSelected: (bool selected) {},
                                  ),
                                ]
                              : [
                                  ...List.generate(
                                    (controller.profileRes?.value?.data?.genre!
                                                    .length ??
                                                0) >
                                            3
                                        ? controller.profileRes!.value!.data!
                                            .genre!.length
                                        : controller.profileRes!.value!.data!
                                            .genre!.length,
                                    (index) => CustomChoiceChip(
                                      selected: false,
                                      label:
                                          '#${controller.profileRes?.value?.data?.genre?[index].type ?? ''}',
                                      onSelected: (bool selected) {},
                                    ),
                                  )
                                ],
                        )
                      : const SizedBox()),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     // CustomChoiceChip(
                  //     //   selected: false,
                  //     //   label: '#Rhythm and blues',
                  //     //   onSelected: (bool selected) {},
                  //     // ),
                  //     // SizedBox(
                  //     //   width: 8.w,
                  //     // ),
                  //     // CustomChoiceChip(
                  //     //   selected: false,
                  //     //   label: '#Vocal',
                  //     //   onSelected: (bool selected) {},
                  //     // ),

                  //     ...List.generate(length, (index) => null)
                  //   ],
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(
                    () => controller.profileRes?.value?.data?.userDetails
                                ?.description !=
                            null
                        ? Text(
                            controller.profileRes!.value!.data!.userDetails!
                                        .description!.length >
                                    200
                                ? controller.profileRes!.value!.data!
                                    .userDetails!.description!
                                    .substring(0, 200)
                                : controller.profileRes!.value!.data!
                                    .userDetails!.description!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFB4B5BF),
                              fontSize: 14.sp,
                              height: 1.5,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : SizedBox(),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                      width: double.infinity,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFF2A2B39),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.5,
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.vertical,
                  //     separatorBuilder: (context, index) {
                  //       return const SizedBox(
                  //         height: 15,
                  //       );
                  //     },
                  //     itemBuilder: (context, index) {
                  //       final playlist = playlists[index];
                  //       return GestureDetector(
                  //         onTap: () {
                  //           Get.toNamed(RouteName.musicPlayDetailsScreen);
                  //         },
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 15),
                  //           child: MusicPlayList(
                  //             name: playlist.name,
                  //             popular: playlist.popular,
                  //             songImage: playlist.songImage,
                  //             topNumber: playlist.topNumber,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     itemCount: playlists.length,
                  //   ),
                  // ),

                  // MusicPlayList(data: SongHistoryData()),

                  Obx(() => controller.getSingHistory.value?.data != null
                      ? controller.getSingHistory.value!.data!.isEmpty
                          ? const Text(
                              'No History Available Yet',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                              ),
                            )
                          : Column(
                              children: [
                                ...List.generate(
                                    controller.getSingHistory.value?.data
                                            ?.length ??
                                        0,
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: MusicPlayList(
                                              data: controller.getSingHistory
                                                  .value?.data![index]),
                                        ))
                              ],
                            )
                      : SizedBox()),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
        ));
  }
}

class MusicPlayList extends StatelessWidget {
  // final String songImage;
  // final int topNumber;
  // final String name;
  // final String popular;

  final SongHistoryData? data;
  const MusicPlayList({
    super.key,
    required this.data,
    // required this.songImage,
    // required this.topNumber,
    // required this.name,
    // required this.popular,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // width: 70.w,
          // height: 70.h,
          width: 75,
          height: 75,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: data?.songs?.imageFile == null
                  ? const AssetImage('assets/images/playBtn.png')
                      as ImageProvider
                  : ExtendedNetworkImageProvider(
                      NetworkStrings.imageURL + data!.songs!.imageFile!),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 'Shape of you',
                    data?.songs?.name ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    // 'Funk . ED Sheeran',
                    (data?.songs?.genre ?? '') +
                        ' . ' +
                        (data?.songs?.artistName ?? ''),
                    style: TextStyle(
                      color: const Color(0xFF6C6D76),
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          width: 40,
          // padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: AppColor.primaryColor, shape: BoxShape.circle),
          child: Center(
            child: Text(
              data?.score == null ? '0' : data!.score!.toInt().toString(),
              // '100',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
