import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/playlist/getplaylist_byuserid_bloc.dart';
import 'package:yelody_app/blocs/playlist/getsongs_byplaylistid_bloc.dart';
import 'package:yelody_app/blocs/playlist/postSong_palylist_block.dart';
import 'package:yelody_app/blocs/song/getall_songs_bloc.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

import '../../YelodyProfile/widgets/drag_handle_custom.dart';
import '../musicplaylist_songadd.dart';

class AllSongsBottomSheet extends StatefulWidget {
  const AllSongsBottomSheet(
      {super.key, required this.currentSelectedPlayListID});
  final String currentSelectedPlayListID;

  @override
  State<AllSongsBottomSheet> createState() => _AllSongsBottomSheetState();
}

class _AllSongsBottomSheetState extends State<AllSongsBottomSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        GetAllSongsBloc().loadAllSongs(
            applyFilter: false,
            context: context,
            setProgressBar: () {
              AppDialogs.progressAlertDialog(context: context);
            });

        ////
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return StatefulBuilder(builder: (context, innitState) {
      return Container(
        width: double.infinity,
        height: 600.h,
        decoration: const ShapeDecoration(
          color: Color(0xFF1A1B22),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
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
            children: [
              const CustomDragHandle(),
              SizedBox(
                height: 20.h,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/images/back.svg")),
                  const Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      'Songs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 15),
              //     child: Row(
              //       children: [

              //         SizedBox(
              //           width: 10,
              //         ),
              //         buildContainer('Songs', 0, context),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         buildContainer('Artists', 1, context),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         buildContainer('All Songs', 2, context),
              //         SizedBox(
              //           width: 10,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20.h,
              ),

              Obx(
                () => Visibility(
                  replacement: Column(
                    children: [
                      Image.asset("assets/images/notfound.png"),
                      Center(
                        child: Text(
                          'No Data to Search\n Please change country filter and try again.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColor.primaryColor,
                              fontFamily: AppFonts.Urbanist,
                              fontWeight: FontWeight.w900,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                  visible: homeController.songs.value?.data != null,
                  child: Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeController.songs.value?.data?.length,
                      itemBuilder: (context, index) {
                        bool added = homeController.getUserplaylist.value?.data
                                ?.where((element) =>
                                    element.userPlaylistId ==
                                    widget.currentSelectedPlayListID)
                                .firstOrNull
                                ?.songs
                                ?.any((element) =>
                                    element.songId ==
                                    homeController
                                        .songs.value!.data![index].songId) ==
                            true;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: MusicPlayListSongADD(
                            genre: homeController
                                    .songs.value!.data![index].genre ??
                                '',
                            buttonWidth: 85.w,
                            onImageTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteName.musicPlayDetailsScreen,
                                arguments: {
                                  'songData':
                                      homeController.songs.value!.data![index],
                                  'singleSong': true,
                                  'isMyPlaylist': true
                                },
                              );
                            },
                            text: added ? 'Added' : null,
                            name:
                                homeController.songs.value!.data![index].name!,
                            popular: homeController
                                .songs.value!.data![index].artistName!,
                            songImage: homeController
                                .songs.value!.data![index].imageFile!,
                            topNumber:
                                homeController.songs.value!.data![index].rank!,
                            onPressed: () {
                              // selectplaylisttoaddSongBottomsheet(
                              //   context,
                              //   homeController
                              //       .songs.value!.data![index].songId!,
                              // );

                              if (added) {
                                return;
                              } else {
                                PostSongPlaylistBloc()
                                    .createPostSongPlaylistMethod(
                                        context: Get.context!,
                                        songId: homeController
                                            .songs.value!.data![index].songId!,
                                        playlistId:
                                            widget.currentSelectedPlayListID,
                                        onSuccessCalled: () {
                                          homeController
                                              .selectedPlayList.value?.songs
                                              ?.add(homeController
                                                  .songs.value!.data![index]);
                                          GetSongsByPlayListIdBloc()
                                              .loadGetSongsByPlayListId(
                                                  context: context,
                                                  id: widget
                                                      .currentSelectedPlayListID,
                                                  setProgressBar: () {
                                                    AppDialogs
                                                        .progressAlertDialog(
                                                            context: context);
                                                  });

                                          GetPlayListByUserId()
                                              .loadGetPlayListByUserId(
                                                  selectedID: widget
                                                      .currentSelectedPlayListID,
                                                  context: context,
                                                  userId: Get.find<
                                                              AuthController>()
                                                          .getAppLoginSession
                                                          ?.data
                                                          ?.userId ??
                                                      '',
                                                  setProgressBar: () {
                                                    AppDialogs
                                                        .progressAlertDialog(
                                                            context: context);
                                                  });

                                          innitState(() {});
                                        },
                                        setProgressBar: () {
                                          AppDialogs.progressAlertDialog(
                                              context: Get.context!);
                                        });
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
