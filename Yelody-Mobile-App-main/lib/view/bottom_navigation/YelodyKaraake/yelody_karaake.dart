import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/playlist/get_recomended_playlist_bloc.dart';
import 'package:yelody_app/blocs/playlist/getall_playlist_bloc.dart';
import 'package:yelody_app/blocs/playlist/getplaylist_byuserid_bloc.dart';
import 'package:yelody_app/blocs/song/getrecommandedsongs_byuserid.dart';
import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/custom_textfield.dart';
import 'package:yelody_app/res/components/music_playlist.dart';
import 'package:yelody_app/res/components/my_playlist.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/AccountProfile/widgets/profile_widget.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

class KaraakeView extends StatefulWidget {
  const KaraakeView({super.key});

  @override
  State<KaraakeView> createState() => _KaraakeViewState();
}

class _KaraakeViewState extends State<KaraakeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetPlayListByUserId().loadGetPlayListByUserId(
          context: context,
          userId:
              Get.find<AuthController>().getAppLoginSession?.data?.userId ?? '',
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });

      GetRecomendedPlayList().loadGetPlayListByUserId(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });

      // GetAllPlayListBloc().loadGetAllPlayList(
      //     context: context,
      //     setProgressBar: () {
      //       AppDialogs.progressAlertDialog(context: context);
      //     });
      GetRecommandedSongByUserId().loadGetRecommandedSongByUserId(
          context: context,
          userId:
              Get.find<AuthController>().getAppLoginSession?.data?.userId ?? '',
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 50,
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColor.darkBackgroundColor,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 0, top: 12, bottom: 10),
          child: Image.asset("assets/icons/app_logo.png"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: AppColor.darkBackgroundColor,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          width: double.infinity,
                          // height: 150.h,
                          height: .6.sh,
                          decoration: ShapeDecoration(
                            color: AppColor.darkBackgroundColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.w, color: const Color(0xFF2A2B39)),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
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
                                    profileImage: homeController
                                        .playListImagePciked.value,
                                    size: 120.h,
                                    setFile: (p0) {
                                      homeController.playListImagePciked.value =
                                          p0;
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
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20)
                                  ],
                                  controller: homeController.nameController,
                                ),

                                SizedBox(
                                  height: 40.h,
                                ),
                                PrimaryButton(
                                    onpressed: () {
                                      homeController.createNewPlayList(
                                          context, () {});
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
                },
                child: SvgPicture.asset(
                    // "assets/icons/appbar_filtericon.svg"
                    "assets/icons/plusicon.svg")),
          ),
        ],
        title: Text(
          'Karaoke',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFE6E0E9),
            fontSize: 22.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              Obx(
                () => Visibility(
                  visible: homeController.getUserplaylist.value?.data != null,
                  child: homeController.getUserplaylist.value?.data != null
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              prefixImage: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: SvgPicture.asset(
                                    'assets/images/search_icon.svg'),
                              ),
                              hint: 'Search Playlist',
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11)
                              ],
                              controller: homeController.searchController,
                              onchange: (searchText) {
                                homeController.filterPlaylists(searchText);
                              },
                            ),
                            const SizedBox(height: 22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'My Playlists',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        RouteName.seeAllmyplaylistscreen);
                                  },
                                  child: Text(
                                    'See All',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: const Color(0xFFF6AD00),
                                      fontSize: 16.sp,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            homeController.iSearching.value
                                ? homeController.filteredPlaylists.isEmpty
                                    ? const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
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
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: homeController
                                                    .filteredPlaylists.length >
                                                5
                                            ? 5
                                            : homeController
                                                .filteredPlaylists.length,
                                        itemBuilder: (context, index) {
                                          final playlist = homeController
                                              .getUserplaylist
                                              .value!
                                              .data![index];
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: MyPlayList(
                                              name: homeController
                                                      .filteredPlaylists[index]
                                                      .name ??
                                                  '',
                                              popular:
                                                  '${homeController.filteredPlaylists[index].songs?.length} Songs',
                                              songImage:
                                                  (playlist.songs != null &&
                                                          playlist.songs!
                                                              .isNotEmpty)
                                                      ? playlist.songs!.first
                                                          .imageFile
                                                          .toString()
                                                      : '',
                                              onButtonTapped: () {
                                                if (homeController
                                                    .filteredPlaylists[index]
                                                    .songs!
                                                    .isNotEmpty) {
                                                  final playList = homeController
                                                      .filteredPlaylists[index];

                                                  PlayListData newShallowCpoy =
                                                      PlayListData.fromJson(
                                                          playList.toJson(
                                                              imageHai: true));

                                                  Get.toNamed(
                                                      RouteName.singMode,
                                                      arguments: {
                                                        'playList':
                                                            newShallowCpoy,
                                                      });
                                                } else {
                                                  AppDialogs.showToast(
                                                      message:
                                                          'Please Add Some Songs to Sing');
                                                }
                                              },
                                              onPressed: () {
                                                homeController.selectedPlayList
                                                        .value =
                                                    homeController
                                                            .filteredPlaylists[
                                                        index];
                                                Get.toNamed(
                                                    RouteName
                                                        .allSongsInsidePlaylist,
                                                    arguments: {
                                                      'id': homeController
                                                          .filteredPlaylists[
                                                              index]
                                                          .userPlaylistId,
                                                    });
                                              },
                                              buttonText: 'Sing',
                                              buttonImage:
                                                  'assets/icons/playicon.svg',
                                            ),
                                          );
                                        },
                                      )
                                : homeController.getUserplaylist.value!.data !=
                                            null &&
                                        homeController.getUserplaylist.value!
                                            .data!.isEmpty
                                    ? const Center(
                                        child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Text("No Playlists Found"),
                                      ))
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: homeController
                                                    .getUserplaylist
                                                    .value!
                                                    .data!
                                                    .length >
                                                5
                                            ? 5
                                            : homeController.getUserplaylist
                                                .value!.data!.length,
                                        itemBuilder: (context, index) {
                                          final playlist = homeController
                                              .getUserplaylist
                                              .value!
                                              .data![index];
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: MyPlayList(
                                              name: homeController
                                                  .getUserplaylist
                                                  .value!
                                                  .data![index]
                                                  .name
                                                  .toString(),
                                              popular:
                                                  '${homeController.getUserplaylist.value!.data?[index].songs?.length} Songs',
                                              songImage:
                                                  (playlist.songs != null &&
                                                          playlist.songs!
                                                              .isNotEmpty)
                                                      ? playlist.songs!.first
                                                          .imageFile
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
                                                      PlayListData.fromJson(
                                                          playLis.toJson(
                                                              imageHai: false));

                                                  Get.toNamed(
                                                      RouteName.singMode,
                                                      arguments: {
                                                        'playList':
                                                            newShallowCpoy,
                                                      });
                                                } else {
                                                  AppDialogs.showToast(
                                                      message:
                                                          'Please Add Songs in this playlist to sing');
                                                }
                                              },
                                              onPressed: () {
                                                homeController.selectedPlayList
                                                        .value =
                                                    homeController
                                                        .getUserplaylist
                                                        .value!
                                                        .data![index];
                                                Get.toNamed(
                                                    RouteName
                                                        .allSongsInsidePlaylist,
                                                    arguments: {
                                                      'id': homeController
                                                          .getUserplaylist
                                                          .value!
                                                          .data![index]
                                                          .userPlaylistId,
                                                    });
                                              },
                                              buttonText: 'Sing',
                                              buttonImage:
                                                  'assets/icons/playicon.svg',
                                            ),
                                          );
                                        },
                                      ),
                          ],
                        )
                      : const Center(
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
              ),

              SizedBox(
                height: Platform.isAndroid ? 20 : 0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.toNamed(RouteName.seeAllPlaylist);
                      // Get.toNamed(RouteName.seeAllmyplaylistscreen);
                      Get.toNamed(
                        RouteName.recomendedPlayListsScreen,
                      );
                    },
                    child: Text(
                      'See All',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: const Color(0xFFF6AD00),
                        fontSize: 16.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              Obx(
                () => Visibility(
                  visible:
                      homeController.recomdendedPlayList.value?.data != null,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (homeController
                                    .recomdendedPlayList.value?.data?.length ??
                                0) >
                            5
                        ? 5
                        : homeController
                                .recomdendedPlayList.value?.data?.length ??
                            0,
                    itemBuilder: (context, index) {
                      final playlist = homeController
                          .recomdendedPlayList.value!.data![index];

                      return Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: MyPlayList(
                          buttonText: 'Sing',
                          buttonImage: 'assets/icons/playicon.svg',
                          name: playlist.name.toString(),
                          popular: '${playlist.songs?.length} Songs',
                          songImage: (playlist.songs != null &&
                                  playlist.songs!.isNotEmpty)
                              ? playlist.songs!.first.imageFile.toString()
                              : '',
                          onButtonTapped: () {
                            if (playlist.songs != null &&
                                playlist.songs!.isNotEmpty) {
                              final playLis = homeController
                                  .recomdendedPlayList.value!.data![index];

                              PlayListData newShallowCpoy =
                                  PlayListData.fromJson(
                                      playLis.toJson(imageHai: false));

                              Get.toNamed(RouteName.singMode, arguments: {
                                'playList': newShallowCpoy,
                              });
                            } else {
                              AppDialogs.showToast(
                                  message:
                                      'Please Add Songs in this playlist to sing');
                            }
                          },
                          onPressed: () {
                            if (playlist.songs!.isNotEmpty) {
                              Get.toNamed(
                                RouteName.playListDetailsScreen,
                                arguments: homeController
                                    .recomdendedPlayList.value!.data![index],
                              );
                            } else {
                              AppDialogs.showToast(
                                  message:
                                      'No songs available in this playlist');
                            }
                            // homeController.selectedPlayList.value =
                            //     homeController
                            //         .getUserplaylist.value!.data![index];
                            // Get.toNamed(RouteName.allSongsInsidePlaylist,
                            //     arguments: {
                            //       'id': homeController.getUserplaylist.value!
                            //           .data![index].userPlaylistId,
                            //     });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(
                height: 18.h,
              ),

              // MyPlayList(
              //   name: 'Dance playlists',
              //   popular: '76 Songs',
              //   songImage: "assets/images/dance_avatar.png",
              //   onPressed: () {
              //     Get.to(() => AllSongsInsidePlaylist());
              //   },
              // ),
              // SizedBox(
              //   height: 6.h,
              // ),
              // MyPlayList(
              //   name: 'Romantic playlist ',
              //   popular: '36 Songs',
              //   songImage: "assets/images/romentic_avatar.png",
              //   onPressed: () {
              //     Get.to(() => AllSongsInsidePlaylist());
              //   },
              // ),
              // SizedBox(
              //   height: 6.h,
              // ),
              // MyPlayList(
              //   name: 'Mc the Max Best',
              //   popular: '124 Songs',
              //   songImage: "assets/images/max_avatar.png",
              //   onPressed: () {
              //     Get.to(() => AllSongsInsidePlaylist());
              //   },
              // )

              // Expanded(
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
              //           // Get.toNamed(RouteName.featureClicked);
              //         },
              //         child: MyPlayList(
              //           name: playlist.name,
              //           popular: playlist.popular,
              //           songImage: playlist.songImage, onPressed: () {  },

              //         ),
              //       );
              //     },
              //     itemCount: playlists.length,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextfield extends StatelessWidget {
  // final TextEditingController controller;
  final String hintText;
  const CustomTextfield({
    super.key,
    required this.hintText,
    // required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56.h,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF3A3B43),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: TextField(
          // controller: controller,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            // 'connortack@gmail.com',
            hintStyle: const TextStyle(color: Color(0xFF6C6D76)),
          ),
        ),
      ),
    );
  }
}
