import 'dart:developer';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yelody_app/blocs/playlist/getplaylist_byuserid_bloc.dart';
import 'package:yelody_app/blocs/playlist/postSong_palylist_block.dart';
import 'package:yelody_app/blocs/song/load_lyrics.dart';
import 'package:yelody_app/models/songs/song_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/custom_textfield.dart';
import 'package:yelody_app/res/components/my_playlist.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/services/permission_manager_service.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/text.dart';
import 'package:yelody_app/utils/utils.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/AccountProfile/widgets/profile_widget.dart';
import 'package:yelody_app/view/MusicPlayDetailScreen/widgets/custom_appbar_details.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyProfile/widgets/drag_handle_custom.dart';

class MusicPlayDetailScreen extends StatefulWidget {
  const MusicPlayDetailScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayDetailScreen> createState() => _MusicPlayDetailScreenState();
}

class _MusicPlayDetailScreenState extends State<MusicPlayDetailScreen> {
  final SongData songId = Get.arguments?['songData'];

  final bool singleSong = Get.arguments?['singleSong'] ?? false;

  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().currentLyrics.value = "";
    log("Charts ${songId.toJson()}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (songId.lyricsTxt != null) {
        LoadLyricsBloc().getLyrics(
            context: context,
            lyricFile: songId.lyricsTxt!,
            setProgressBar: () =>
                AppDialogs.progressAlertDialog(context: context));
      }
    });
  }

  _addPlayListSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.darkBackgroundColor,
      builder: (BuildContext context) {
        final homeController = Get.find<HomeController>();
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            // height: 150.h,
            height: .6.sh,
            decoration: ShapeDecoration(
              color: AppColor.darkBackgroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: const Color(0xFF2A2B39)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // SizedBox(
                  //   height: 20.h,

                  SizedBox(
                    height: 10.h,
                  ),
                  // ),
                  const Text(
                    'Create Playlist',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(
                    height: 30.h,
                  ),
                  Obx(
                    () => ProfilePictureWidget(
                      // size: 110.sp,
                      profileImage: homeController.playListImagePciked.value,
                      size: 120.h,
                      setFile: (p0) {
                        homeController.playListImagePciked.value = p0;
                      },
                      is_pickImage: true,
                      upload_icon: true,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    hint: 'Playlist Name',
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    controller: homeController.nameController,
                  ),

                  SizedBox(
                    height: 40.h,
                  ),
                  PrimaryButton(
                      onpressed: () {
                        homeController.createNewPlayList(context, () {
                          // Navigator.pop(context);
                          print("Success Calledd");
                          _playListSheet(context);
                        });
                      },
                      text: "Done"),

                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.w,
          color: AppColor.darkBackgroundColor,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  _playListSheet(BuildContext context) {
    Utils.showBottomSheetCustom(
        context: context,
        child: StatefulBuilder(builder: (context, innerState) {
          final homeController = Get.find<HomeController>();
          return Container(
            height: .7.sh,
            decoration: const BoxDecoration(
                color: AppColor.darkBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const CustomDragHandle(),
                    SizedBox(
                      height: 20.h,
                    ),
                    const Text(
                      'Select Playlist',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Obx(
                      () => homeController.getUserplaylist.value != null
                          ? SizedBox(
                              height: .61.sh,
                              child: ListView.builder(
                                shrinkWrap: true,
                                // physics: const BouncingScrollPhysics(),
                                // physics: const (),
                                itemCount:
                                    // homeController.getUserplaylist.value!.data.length,
                                    homeController
                                        .getUserplaylist.value!.data!.length,
                                itemBuilder: (context, index) {
                                  final playList = homeController
                                      .getUserplaylist.value!.data?[index];
                                  // bool added = homeController
                                  //         .getUserplaylist.value?.data
                                  //         ?.where((element) =>
                                  //             element.userPlaylistId ==
                                  //             currentSelectedPlayListID)
                                  //         .firstOrNull
                                  //         ?.songs
                                  //         ?.any((element) =>
                                  //             element.songId ==
                                  //             homeController.songs.value!
                                  //                 .data![index].songId) ==
                                  //     true;

                                  final added = homeController.getUserplaylist
                                      .value!.data![index].songs!
                                      .any(
                                    (element) =>
                                        element.songId == songId.songId,
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: MyPlayList(
                                      onPressed: () {},
                                      buttonText: added ? 'Added' : 'Add',
                                      buttonImage: added
                                          ? 'assets/icons/correct_icon.svg'
                                          : 'assets/icons/addition.svg',
                                      name:
                                          //  'Christmas List',
                                          homeController.getUserplaylist.value!
                                              .data![index].name
                                              .toString(),
                                      popular: homeController.getUserplaylist
                                          .value!.data![index].name
                                          .toString(),
                                      songImage: (playList?.songs != null &&
                                              playList!.songs!.isNotEmpty)
                                          ? playList.songs!.first.imageFile
                                              .toString()
                                          : '',
                                      onButtonTapped: () {
                                        if (added) {
                                          return;
                                        } else {
                                          PostSongPlaylistBloc()
                                              .createPostSongPlaylistMethod(
                                                  onSuccessCalled: () {
                                                    Get.back();
                                                    innerState(() {});
                                                  },
                                                  context: Get.context!,
                                                  songId: songId.songId!,
                                                  playlistId: homeController
                                                      .getUserplaylist
                                                      .value!
                                                      .data![index]
                                                      .userPlaylistId
                                                      .toString(),
                                                  setProgressBar: () {
                                                    AppDialogs
                                                        .progressAlertDialog(
                                                            context:
                                                                Get.context!);
                                                  });
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    bool isMyPlayList = Get.arguments?['isMyPlaylist'] ?? false;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: !isMyPlayList
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        checkPermissions();
                      },
                      child: const SingBtn(
                        text: "Sing Now",
                        buttonColor: AppColor.secondaryTextColor,
                      )),
                  SizedBox(width: 8.w), // Use ScreenUtil for spacing
                  GestureDetector(
                      onTap: () {
                        GetPlayListByUserId().loadGetPlayListByUserId(
                            context: context,
                            sucess: () {
                              final homeController = Get.find<HomeController>();
                              if (homeController.getUserplaylist.value?.data !=
                                      null &&
                                  homeController
                                      .getUserplaylist.value!.data!.isEmpty) {
                                _addPlayListSheet();
                              } else {
                                _playListSheet(context);
                              }
                            },
                            userId: Get.find<AuthController>()
                                    .getAppLoginSession
                                    ?.data
                                    ?.userId ??
                                '',
                            setProgressBar: () {
                              AppDialogs.progressAlertDialog(context: context);
                            });
                      },
                      child: const SingBtn(
                        text: "Add Song",
                        buttonColor: AppColor.secondaryTextColor,
                        image: 'assets/icons/add.png',
                      )),
                ],
              )
            : GestureDetector(
                onTap: () async {
                  checkPermissions();
                },
                child: SizedBox(
                  width: .8.sw,
                  child: const SingBtn(
                    text: "Sing Now",
                    buttonColor: AppColor.secondaryTextColor,
                  ),
                )),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.darkBackgroundColor,
      appBar: CustomAppBar(
        context: context,
        title: '${songId.name} ${songId.artistName}',
        isLeading: 'assets/icons/back_icon.png',
        onclickLead: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.5.sh,
              child: Stack(
                children: [
                  // Image.asset("assets/images/musicplaydetail_background.png"),
                  songId.imageFile != null
                      ? Blur(
                          blur: 10,
                          colorOpacity: .3,
                          blurColor: AppColor.blackColor,
                          child: SizedBox(
                            width: 1.sw,
                            height: .35.sh,
                            child: Image.network(
                              NetworkStrings.imageURL + songId.imageFile!,
                              fit: BoxFit.cover,
                              colorBlendMode: BlendMode.colorBurn,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 1.sw,
                          height: .35.sh,
                          child: Image.asset(
                            "assets/images/musicplaydetail_background.png",
                            fit: BoxFit.cover,
                          ),
                        ),

                  Positioned(
                    top: 0.2.sh, // Use ScreenUtil for positioning
                    left: 0, // Use ScreenUtil for positioning
                    right: 0,
                    child: Container(
                      width: 200.w, // Use ScreenUtil for sizing
                      height: 200.h, // Use ScreenUtil for sizing
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              // AssetImage("assets/images/circleavatar.png"),
                              songId.imageFile != null
                                  ? NetworkImage(NetworkStrings.imageURL +
                                      songId.imageFile!)
                                  : const AssetImage(
                                          "assets/images/circleavatar.png")
                                      as ImageProvider,
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              // 'Dance ',
              songId.genre ?? '',

              style: TextStyle(
                color: const Color(0xFF95969F),
                fontSize: 14.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              songId.name ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              songId.artistName ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.w), // Use ScreenUtil for padding
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    Obx(
                      () => MyText.lyricsText(
                        Get.find<HomeController>().currentLyrics.value,
                      ),
                    )

                    //  Text(  NetworkStrings.imageURL +controller.musicDetails.value!.data!.lyricsTxt.toString(),)
                    // MyText.lyricsText('Girl, you know I want your love '),
                    // MyText.lyricsText(
                    //     'Your love was hand made for Somebody Like me '),
                    // MyText.lyricsText(
                    //     'Come on now, I may be crazy, don\'t mind me '),
                    // MyText.lyricsText('Say,Girl, you know I want your love '),
                    // MyText.lyricsText(
                    //     'Your love was hand made for Somebody Like me'),
                    // MyText.lyricsText(
                    //     'Come on now, I may be crazy, don\'t mind me '),
                    // MyText.lyricsText(' Say,Girl, you know I want your love'),
                    // MyText.lyricsText(
                    //     'Your love was hand made for Somebody Like me'),
                    // MyText.lyricsText(
                    //     'Come on now, I may be crazy, don\'t mind me'),
                    // MyText.lyricsText('Say,Girl, you know I want your love'),
                    // MyText.lyricsText(
                    //     'Your love was hand made for Somebody Like me'),
                    // MyText.lyricsText(
                    //     'Come on now, I may be crazy, don\'t mind me Say,'),
                    // Text(
                    //   '''Girl, you know I want your love
                    //   Your love was hand made for Somebody Like me
                    //   Come on now, I may be crazy, don't mind me
                    //   Say,Girl, you know I want your love
                    //   Your love was hand made for Somebody Like me
                    //   Come on now, I may be crazy, don't mind me
                    //   Say,Girl, you know I want your love
                    //   Your love was hand made for Somebody Like me
                    //   Come on now, I may be crazy, don't mind me
                    //   Say,Girl, you know I want your love
                    //   Your love was hand made for Somebody Like me
                    //   Come on now, I may be crazy, don't mind me Say,''',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     color: Color(0xFF95969F),
                    //     fontSize: 12.sp,
                    //     fontFamily: 'Urbanist',
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  void _navigateToSingMode() {
    Get.toNamed(RouteName.singMode,
        arguments: {'songData': songId, 'singleSong': singleSong});
  }

  checkPermissions() async {
    final storagePermissionStatus =
        await PermissionManager.checkStoragePermission();
    final audioPermissionStatus =
        await PermissionManager.checkAudioPermission();

    print("Storage Permission ${storagePermissionStatus.name}");
    print("Audio Permission ${audioPermissionStatus.name}");

    if (storagePermissionStatus == PermissionStatusResult.granted &&
        audioPermissionStatus == PermissionStatusResult.granted) {
      // Both storage and audio permissions are already granted

      print('Naviagting To Sing Mode');
      _navigateToSingMode();
    } else {
      print('CHecking Permissionm');

      final storagePermissionStatus =
          await PermissionManager.checkStoragePermission();
      final audioPermissionStatus =
          await PermissionManager.checkAudioPermission();

      print("Storage Permission ${storagePermissionStatus.name}");
      print("Audio Permission ${audioPermissionStatus.name}");

      if (storagePermissionStatus == PermissionStatusResult.granted &&
          audioPermissionStatus == PermissionStatusResult.granted) {
        // Both storage and audio permissions are already granted

        print('Naviagting To Sing Mode');
        _navigateToSingMode();

        // final permissionRequestResult =
        //     await PermissionManager.requestAllPermissions();

        // switch (permissionRequestResult) {
        //   case PermissionStatusResult.granted:
        //     // Both storage and audio permissions granted after request
        //     _navigateToSingMode();
        //     break;
        //   case PermissionStatusResult.denied:
        //     PermissionManager.requestAudioPermission();
        //     checkPermissions();
        //     // Handle the case where permissions are denied (but not permanently)
        //     break;
        //   case PermissionStatusResult.permanentlyDenied:
        //     // Handle the case where permissions are permanently denied
        //     Fluttertoast.showToast(
        //         msg:
        //             'Please Allow the Sound and Storage Permssion to Continue Reocding');
        //     openAppSettings();
        //     break;
        // }
      } else if (storagePermissionStatus ==
              PermissionStatusResult.permanentlyDenied ||
          audioPermissionStatus == PermissionStatusResult.permanentlyDenied) {
        Fluttertoast.showToast(
            msg:
                'Please Allow the Sound and Storage Permssion to Continue Reocding');
        openAppSettings();
      }
    }
  }
}

class SingBtn extends StatelessWidget {
  final String text;
  final String? image;
  final Color? buttonColor;
  const SingBtn({
    Key? key,
    this.buttonColor,
    required this.text,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 158.w, // Use ScreenUtil for sizing
      height: 36.h, // Use ScreenUtil for sizing
      decoration: BoxDecoration(
        color: buttonColor ?? Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image != null
              ? Image.asset(
                  image!,
                  scale: 3,
                )
              : SvgPicture.asset("assets/icons/playicon.svg"),
          SizedBox(width: 8.w), // Use ScreenUtil for spacing
          Text(
            // 'Sing',
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
