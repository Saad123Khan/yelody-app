import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/custom_textfield.dart';
import 'package:yelody_app/res/components/my_playlist.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/widgets/profile_widget.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

class SeeAllMyPlayListScreen extends StatefulWidget {
  const SeeAllMyPlayListScreen({Key? key}) : super(key: key);

  @override
  State<SeeAllMyPlayListScreen> createState() => _SeeAllMyPlayListScreenState();
}

class _SeeAllMyPlayListScreenState extends State<SeeAllMyPlayListScreen> {
  @override
  void initState() {
    Get.find<HomeController>().filterInsidePlayList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   GetPlayListByUserId().loadGetPlayListByUserId(
    //       context: context,
    //       userId:
    //           Get.find<AuthController>().getAppLoginSession?.data?.userId ?? '',
    //       setProgressBar: () {
    //         AppDialogs.progressAlertDialog(context: context);
    //       });
    //   GetAllPlayListBloc().loadGetAllPlayList(
    //       context: context,
    //       setProgressBar: () {
    //         AppDialogs.progressAlertDialog(context: context);
    //       });
    // });
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              homeController.searchControllerInsideAllPlayList.clear();
              homeController.iSearchingInsidePlayList.value = false;
              Get.back();
            },
            child: Image.asset(
              'assets/icons/back_icon.png',
              scale: 2.5,
            ),
          ),
          backgroundColor: AppColor.darkBackgroundColor,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: InkWell(
                onTap: () {
                  _addNewPlayList();
                },
                child: Image.asset(
                  'assets/images/add_new_playlist.png',
                  scale: 2.5,
                ),
              ),
            ),
          ],
          title: Text.rich(TextSpan(children: [
            TextSpan(
              text: 'All Playlist',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
          ]))),
      body: WillPopScope(
        onWillPop: () {
          homeController.searchControllerInsideAllPlayList.clear();
          homeController.iSearchingInsidePlayList.value = false;
          return Future.value(true);
        },
        child: Obx(
          () => Visibility(
            visible: homeController.getUserplaylist.value?.data != null,
            child: homeController.getUserplaylist.value?.data != null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: CustomTextField(
                          controller:
                              homeController.searchControllerInsideAllPlayList,
                          hint: 'Search Playlist',
                          prefixImage: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SvgPicture.asset(
                                'assets/images/search_icon.svg'),
                          ),
                        ),
                      ),
                      homeController.iSearchingInsidePlayList.value
                          ? Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                // physics: const (),
                                itemCount:
                                    // homeController.getUserplaylist.value!.data.length,
                                    homeController
                                        .filteredPlaylistsInsideAllPlayList
                                        .length,
                                itemBuilder: (context, index) {
                                  final playList = homeController
                                          .filteredPlaylistsInsideAllPlayList[
                                      index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15, right: 15),
                                    child: MyPlayList(
                                      name: homeController
                                          .filteredPlaylistsInsideAllPlayList[
                                              index]
                                          .name
                                          .toString(),
                                      popular:
                                          '${homeController.filteredPlaylistsInsideAllPlayList[index].songs?.length} Songs',
                                      songImage: (playList.songs != null &&
                                              playList.songs!.isNotEmpty)
                                          ? playList.songs!.first.imageFile
                                              .toString()
                                          : '',
                                      onButtonTapped: () {
                                        if (homeController
                                                    .filteredPlaylistsInsideAllPlayList[
                                                        index]
                                                    .songs !=
                                                null &&
                                            homeController
                                                .filteredPlaylistsInsideAllPlayList[
                                                    index]
                                                .songs!
                                                .isNotEmpty) {
                                          final playLis = homeController
                                                  .filteredPlaylistsInsideAllPlayList[
                                              index];

                                          PlayListData newShallowCpoy =
                                              PlayListData.fromJson(playLis
                                                  .toJson(imageHai: true));

                                          Get.toNamed(RouteName.singMode,
                                              arguments: {
                                                'playList': newShallowCpoy,
                                              });
                                        } else {
                                          AppDialogs.showToast(
                                              message:
                                                  'Please Add Songs in this playlist to sing');
                                        }
                                      },
                                      onPressed: () {
                                        homeController.selectedPlayList.value =
                                            homeController.getUserplaylist
                                                .value!.data![index];
                                        Get.toNamed(
                                            RouteName.allSongsInsidePlaylist,
                                            arguments: {
                                              'id': homeController
                                                  .getUserplaylist
                                                  .value!
                                                  .data![index]
                                                  .userPlaylistId,
                                            });
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    // homeController.getUserplaylist.value!.data.length,
                                    homeController
                                        .getUserplaylist.value!.data!.length,
                                itemBuilder: (context, index) {
                                  final playList = homeController
                                      .getUserplaylist.value!.data![index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15, right: 15),
                                    child: MyPlayList(
                                      buttonText: 'Sing',
                                      buttonImage: 'assets/icons/playicon.svg',
                                      name: homeController.getUserplaylist
                                          .value!.data![index].name
                                          .toString(),
                                      popular:
                                          '${homeController.getUserplaylist.value!.data![index].songs?.length} Songs',
                                      songImage: (playList.songs != null &&
                                              playList.songs!.isNotEmpty)
                                          ? playList.songs!.first.imageFile
                                              .toString()
                                          : '',
                                      onButtonTapped: () {
                                        if (homeController
                                                    .getUserplaylist
                                                    .value!
                                                    .data![index]
                                                    .songs !=
                                                null &&
                                            homeController
                                                .getUserplaylist
                                                .value!
                                                .data![index]
                                                .songs!
                                                .isNotEmpty) {
                                          final playLis = homeController
                                              .getUserplaylist
                                              .value!
                                              .data![index];

                                          PlayListData newShallowCpoy =
                                              PlayListData.fromJson(playLis
                                                  .toJson(imageHai: true));

                                          Get.toNamed(RouteName.singMode,
                                              arguments: {
                                                'playList': newShallowCpoy,
                                              });
                                        } else {
                                          AppDialogs.showToast(
                                              message:
                                                  'Please Add Songs in this playlist to sing');
                                        }
                                      },
                                      onPressed: () {
                                        homeController.selectedPlayList.value =
                                            homeController.getUserplaylist
                                                .value!.data![index];
                                        Get.toNamed(
                                            RouteName.allSongsInsidePlaylist,
                                            arguments: {
                                              'id': homeController
                                                  .getUserplaylist
                                                  .value!
                                                  .data![index]
                                                  .userPlaylistId,
                                            });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                      Visibility(
                        visible:
                            homeController.iSearchingInsidePlayList.value &&
                                homeController
                                    .filteredPlaylistsInsideAllPlayList.isEmpty,
                        child: const Expanded(
                          child: Text(
                            'No playlist found.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Color(0xFFF6AD00),
                              fontSize: 20,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }

  _addNewPlayList() {
    final homeController = Get.find<HomeController>();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.darkBackgroundColor,
      builder: (BuildContext context) {
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
                        homeController.createNewPlayList(context, () {});
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
}
