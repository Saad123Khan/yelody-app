import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yelody_app/blocs/charts/chart_bloc.dart';
import 'package:yelody_app/blocs/charts/getsongs%20_bychartid_bloc.dart';
import 'package:yelody_app/blocs/playlist/delete_playlist.dart';
import 'package:yelody_app/blocs/playlist/getplaylist_byuserid_bloc.dart';
import 'package:yelody_app/blocs/playlist/getsongs_byplaylistid_bloc.dart';
import 'package:yelody_app/blocs/playlist/postSong_palylist_block.dart';
import 'package:yelody_app/blocs/song/delete_song_from_playlist.dart';
import 'package:yelody_app/blocs/song/getall_songs_bloc.dart';
import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:yelody_app/res/components/custom_textfield.dart';
import 'package:yelody_app/res/components/music_playlist.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/utils.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/musicplaylist_songadd.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/myplaylist_addsong.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/searchsong_bilboard.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/songsnot_found.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/widgets/all_songs_bottom_sheet.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/widgets/reordable_item.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyProfile/widgets/drag_handle_custom.dart';

import 'recent_searh_widget.dart';

class AllSongsInsidePlaylist extends StatefulWidget {
  const AllSongsInsidePlaylist({super.key});

  @override
  State<AllSongsInsidePlaylist> createState() => _AllSongsInsidePlaylistState();
}

class _AllSongsInsidePlaylistState extends State<AllSongsInsidePlaylist> {
  // String? selectedCountry;

  String currentSelectedPlayListID = "";

  @override
  void initState() {
    log("ID PLAY LIST $currentSelectedPlayListID");

    currentSelectedPlayListID =
        Get.find<HomeController>().selectedPlayList.value!.userPlaylistId!;

    Get.find<HomeController>().editingPlayList.value = false;
    Get.find<HomeController>().editedSelected.clear();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetSongsByPlayListIdBloc().loadGetSongsByPlayListId(
          context: context,
          id: Get.find<HomeController>()
              .selectedPlayList
              .value!
              .userPlaylistId!,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });
    });
    Get.find<HomeController>().filterSongs();

    super.initState();
  }

  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
        backgroundColor: AppColor.darkBackgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomInset: false,
        floatingActionButton: Obx(
          () => controller.editingPlayList.value &&
                  controller.editedSelected.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: PrimaryButton(
                    image: 'assets/icons/delete.png',
                    onpressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            height: 150.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF1A1B22),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CustomDragHandle(),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    'Delete Songs?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 56.h,
                                            padding: const EdgeInsets.all(16),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF3A3B43),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(28),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Cancel',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: PrimaryButton(
                                            onpressed: () async {
                                              final idsToBeDeleted = controller
                                                  .editedSelected
                                                  .map((element) =>
                                                      element.songId!)
                                                  .toList();
                                              DeleteSongFromPlayList()
                                                  .postSongToQue(
                                                      successCall: () {
                                                        controller
                                                            .editedSelected
                                                            .clear();

                                                        GetSongsByPlayListIdBloc()
                                                            .loadGetSongsByPlayListId(
                                                                context:
                                                                    context,
                                                                id:
                                                                    currentSelectedPlayListID,
                                                                setProgressBar:
                                                                    () {
                                                                  AppDialogs.progressAlertDialog(
                                                                      context:
                                                                          context);
                                                                });
                                                        GetPlayListByUserId()
                                                            .loadGetPlayListByUserId(
                                                                sucess: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  // Navigator.pop(
                                                                  //     context);
                                                                },
                                                                selectedID:
                                                                    currentSelectedPlayListID,
                                                                context:
                                                                    context,
                                                                userId: Get.find<
                                                                            AuthController>()
                                                                        .getAppLoginSession
                                                                        ?.data
                                                                        ?.userId ??
                                                                    '',
                                                                setProgressBar:
                                                                    () {
                                                                  AppDialogs.progressAlertDialog(
                                                                      context:
                                                                          context);
                                                                });
                                                      },
                                                      context: context,
                                                      songId: idsToBeDeleted,
                                                      playListID:
                                                          currentSelectedPlayListID,
                                                      setProgressBar: () {
                                                        AppDialogs
                                                            .progressAlertDialog(
                                                                context:
                                                                    context);
                                                      });

                                              // Navigator.pop(
                                              //     context);
                                            },
                                            text: "Yes"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        useSafeArea: false,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.w, color: const Color(0xFF2A2B39)),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                        ),
                      );
                    },
                    text: 'Delete (${controller.editedSelected.length})',
                  ),
                )
              : const SizedBox(),
        ),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: kTextTabBarHeight + 25,
          backgroundColor: AppColor.darkBackgroundColor,
          titleSpacing: 0,
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              'assets/icons/back_icon.png',
              scale: 2.5,
            ),
          ),
          title: Row(
            children: [
              Obx(() => controller.getSongbyPlaylistId.value?.data != null
                  ? DropdownButtonHideUnderline(
                      child: DropdownButton2<PlayListData>(
                          menuItemStyleData:
                              const MenuItemStyleData(height: 52),
                          // buttonStyleData: ButtonStyleData(height: 200),
                          value: controller.selectedPlayList.value,
                          dropdownStyleData: const DropdownStyleData(
                            // maxHeight: 20,
                            padding: EdgeInsets.only(top: 5),
                            // padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                color: AppColor.dropdownBackgroundColor),
                            // maxHeight: 400,
                          ),
                          selectedItemBuilder: (BuildContext context) {
                            return controller.getUserplaylist.value!.data!
                                .map<Widget>((PlayListData item) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: SizedBox(
                                  width: 160,
                                  child: Text(
                                    item.name ?? '',
                                    style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 23.sp,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          items: controller.getUserplaylist.value?.data!
                              .asMap()
                              .map((index, PlayListData item) {
                                return MapEntry(
                                  index,
                                  DropdownMenuItem<PlayListData>(
                                    value: item,
                                    onTap: () {
                                      controller.selectedPlayList.value = item;
                                      currentSelectedPlayListID =
                                          item.userPlaylistId!;

                                      print(
                                          "ONN CHANGED${item.userPlaylistId!}");

                                      controller.editingPlayList.value = false;
                                      controller.editedSelected.clear();

                                      controller.iSearchingInsidePlayList
                                          .value = false;
                                      controller.filteredPlayListSongs.clear();
                                      controller.searchControllerPlayList
                                          .clear();

                                      GetSongsByPlayListIdBloc()
                                          .loadGetSongsByPlayListId(
                                              context: context,
                                              id: item.userPlaylistId!,
                                              setProgressBar: () {
                                                AppDialogs.progressAlertDialog(
                                                    context: context);
                                              });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name ?? '',
                                                style: TextStyle(
                                                    // fontSize: 22,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.whiteColor,
                                                    fontFamily:
                                                        AppFonts.Urbanist),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          index !=
                                                  controller.getUserplaylist
                                                          .value!.data!.length -
                                                      1
                                              ? Divider(
                                                  color: Colors.grey
                                                      .withOpacity(.5),
                                                )
                                              : const Center(
                                                  child: SizedBox(
                                                    width: 30,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                    // Assuming PlayListData has a 'name' property for display
                                  ),
                                );
                              })
                              .values
                              .toList(),
                          iconStyleData: IconStyleData(
                              icon: SvgPicture.asset(
                                  'assets/icons/dropdown.svg')),
                          onChanged: (PlayListData? newValue) {
                            controller.selectedPlayList.value = newValue;
                          }),
                    )
                  : const SizedBox())
            ],
          ),
          actions: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: controller.editingPlayList.value
                    ? Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: InkWell(
                          onTap: () {
                            controller.editingPlayList.value = false;
                            controller.editedSelected.clear();
                          },
                          child: Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                songSheetWithCharts(context);
                              },
                              child:
                                  // SvgPicture.asset("assets/icons/pen_icon.svg")
                                  SvgPicture.asset(
                                      "assets/icons/plusicon.svg")),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
              ),
            )
          ],
        ),
        body: Obx(
          () => controller.editingPlayList.value
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (controller.editedSelected.length ==
                                    controller.getSongbyPlaylistId.value?.data
                                        ?.songs?.length) {
                                  controller.editedSelected.clear();
                                } else {
                                  controller.editedSelected.assignAll(controller
                                      .getSongbyPlaylistId.value!.data!.songs!);
                                }
                              },
                              child: Text(
                                controller.editedSelected.length ==
                                        controller.getSongbyPlaylistId.value
                                            ?.data?.songs?.length
                                    ? controller.editedSelected.isEmpty
                                        ? 'Select All'
                                        : 'Deselect All'
                                    : 'Select All',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: AppFonts.Urbanist,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: double.infinity,
                                      height: 150.h,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF1A1B22),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1.w,
                                              color: const Color(0xFF2A2B39)),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const CustomDragHandle(),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text(
                                              'Delete Playlist?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.sp,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 56.h,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: const Color(
                                                            0xFF3A3B43),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(28),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Cancel',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: PrimaryButton(
                                                      onpressed: () async {
                                                        DeletePlayListBloc()
                                                            .deletePlayListByID(
                                                                context:
                                                                    context,
                                                                playListID:
                                                                    currentSelectedPlayListID,
                                                                setProgressBar:
                                                                    () {
                                                                  AppDialogs.progressAlertDialog(
                                                                      context:
                                                                          context);
                                                                });
                                                        // Navigator.pop(
                                                        //     context);
                                                      },
                                                      text: "Yes"),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  useSafeArea: false,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.w,
                                        color: const Color(0xFF2A2B39)),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Delete playlist',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: AppFonts.Urbanist,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // MusicPlayListEditing(songImage: songImage, name: name, popular: popular, onChanged: onChanged, checkboxValue: checkboxValue)
                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                            height: .82.sh,
                            child: ReorderableEditingList(
                              songs: controller
                                      .getSongbyPlaylistId.value?.data?.songs ??
                                  [],
                            ))

                        // Obx(
                        //   () => SizedBox(
                        //     height: .82.sh,
                        //     child: ReorderableListView.builder(
                        //       onReorder: (oldIndex, newIndex) {},
                        //       // scrollDirection: Axis.vertical,
                        //       shrinkWrap: true,
                        //       // physics: NeverScrollableScrollPhysics(),
                        //       physics: const BouncingScrollPhysics(),
                        //       itemCount: (controller.getSongbyPlaylistId.value
                        //               ?.data!.songs!.length ??
                        //           0),
                        //       itemBuilder: (context, index) {
                        //         // Check if it's the last index
                        //         // if (index ==
                        //         //     controller.getSongbyPlaylistId.value?.data!
                        //         //         .songs!.length) {
                        //         //   // Return SizedBox for the last index
                        //         //   return const SizedBox(
                        //         //       height:
                        //         //           80); // You can adjust the height as needed
                        //         // }

                        //         // Your existing GestureDetector for other items
                        //         return ReorderableItem(
                        //           key: Key(controller.getSongbyPlaylistId.value!
                        //               .data!.songs![index].songId!),
                        //           childBuilder: (context, state) {
                        //             return GestureDetector(
                        //               child: Padding(
                        //                 padding: const EdgeInsets.symmetric(
                        //                   vertical: 10,
                        //                 ),
                        //                 child:
                        //
                        // MusicPlayListEditing(
                        //                   checkboxValue: controller
                        //                       .editedSelected
                        //                       .contains(controller
                        //                           .getSongbyPlaylistId
                        //                           .value!
                        //                           .data!
                        //                           .songs![index]),
                        //                   onChanged: (onChanged) {
                        //                     if (onChanged == true) {
                        //                       controller.editedSelected.add(
                        //                           controller
                        //                               .getSongbyPlaylistId
                        //                               .value!
                        //                               .data!
                        //                               .songs![index]);
                        //                     } else {
                        //                       controller.editedSelected.remove(
                        //                           controller
                        //                               .getSongbyPlaylistId
                        //                               .value!
                        //                               .data!
                        //                               .songs![index]);
                        //                     }
                        //                   },
                        //                   name: controller.getSongbyPlaylistId
                        //                       .value!.data!.songs![index].name
                        //                       .toString(),
                        //                   popular: controller
                        //                       .getSongbyPlaylistId
                        //                       .value!
                        //                       .data!
                        //                       .songs![index]
                        //                       .artistName
                        //                       .toString(),
                        //                   songImage: controller
                        //                       .getSongbyPlaylistId
                        //                       .value!
                        //                       .data!
                        //                       .songs![index]
                        //                       .imageFile
                        //                       .toString(),
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: CustomTextField(
                                controller: controller.searchControllerPlayList,
                                onchange: (p0) {
                                  controller.filterPlayListSongs(p0);
                                },
                                hint: 'Search Songs',
                                prefixImage: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: SvgPicture.asset(
                                      'assets/images/search_icon.svg'),
                                ),
                              )),
                              // const Expanded(
                              //     child:
                              //         CustomSearchTextField(hintText: "Search Songs")),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.editingPlayList.value = true;
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 17),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color:
                                              AppColor.linearProgressIndicator),
                                      child: SizedBox(
                                        height: 25,
                                        width: 30,
                                        child: SvgPicture.asset(
                                            "assets/icons/pen_icon.svg"),
                                      )))
                            ],
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          Obx(() {
                            final songs = controller
                                .getSongbyPlaylistId.value?.data?.songs;

                            if (songs != null && songs.isNotEmpty) {
                              return controller.iSearchingInsidePlayList.value
                                  ? controller.filteredPlayListSongs.isEmpty
                                      ? Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.w),
                                            child: Column(children: [
                                              SizedBox(
                                                height: .15.sh,
                                              ),
                                              Center(
                                                  child: Image.asset(
                                                      "assets/images/notfound.png")),
                                              const Center(
                                                child: Text(
                                                  'Song Not Found!',
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    color: Color(0xFFF6AD00),
                                                    fontSize: 32,
                                                    // height: 1.5,
                                                    fontFamily: 'Urbanist',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Try searching again using different keyword. ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.sp,
                                                  height: 1.5,
                                                  // letterSpacing: 0,
                                                  fontFamily: AppFonts.Urbanist,
                                                  // fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ]),
                                          ),
                                        )
                                      : SizedBox(
                                          height: .75.sh,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: controller
                                                    .filteredPlayListSongs
                                                    .length +
                                                1,
                                            itemBuilder: (context, index) {
                                              // Check if it's the last index
                                              if (index ==
                                                  controller
                                                      .filteredPlayListSongs
                                                      .length) {
                                                // Return SizedBox for the last index
                                                return const SizedBox(
                                                    height:
                                                        80); // Adjust the height as needed
                                              }

                                              // Your existing GestureDetector for other items
                                              return GestureDetector(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: MusicPlayList(
                                                    hideRank: true,
                                                    genre: controller
                                                            .filteredPlayListSongs[
                                                                index]
                                                            .genre ??
                                                        '',
                                                    onImageTapped: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        RouteName
                                                            .musicPlayDetailsScreen,
                                                        arguments: {
                                                          'songData': controller
                                                                  .filteredPlayListSongs[
                                                              index],
                                                          'singleSong': true,
                                                          'isMyPlaylist': true
                                                        },
                                                      );
                                                    },
                                                    name: controller
                                                        .filteredPlayListSongs[
                                                            index]
                                                        .name
                                                        .toString(),
                                                    popular: controller
                                                        .filteredPlayListSongs[
                                                            index]
                                                        .artistName
                                                        .toString(),
                                                    songImage: controller
                                                        .filteredPlayListSongs[
                                                            index]
                                                        .imageFile
                                                        .toString(),
                                                    topNumber: controller
                                                        .filteredPlayListSongs[
                                                            index]
                                                        .rank!
                                                        .toInt(),
                                                    onPressed: () {
                                                      Get.toNamed(
                                                        RouteName.singMode,
                                                        arguments: {
                                                          'songData': controller
                                                                  .filteredPlayListSongs[
                                                              index],
                                                          'singleSong': true
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                  : SizedBox(
                                      height: .75.sh,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: (controller
                                                    .getSongbyPlaylistId
                                                    .value
                                                    ?.data!
                                                    .songs!
                                                    .length ??
                                                0) +
                                            1,
                                        itemBuilder: (context, index) {
                                          // Check if it's the last index
                                          if (index ==
                                              controller.getSongbyPlaylistId
                                                  .value?.data!.songs!.length) {
                                            // Return SizedBox for the last index
                                            return const SizedBox(
                                                height:
                                                    80); // Adjust the height as needed
                                          }

                                          // Your existing GestureDetector for other items
                                          return GestureDetector(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: MusicPlayList(
                                                hideRank: true,
                                                genre: controller
                                                        .getSongbyPlaylistId
                                                        .value!
                                                        .data!
                                                        .songs![index]
                                                        .genre ??
                                                    '',
                                                onImageTapped: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    RouteName
                                                        .musicPlayDetailsScreen,
                                                    arguments: {
                                                      'songData': controller
                                                          .getSongbyPlaylistId
                                                          .value!
                                                          .data!
                                                          .songs![index],
                                                      'singleSong': true,
                                                      'isMyPlaylist': true,
                                                    },
                                                  );
                                                },
                                                name: controller
                                                    .getSongbyPlaylistId
                                                    .value!
                                                    .data!
                                                    .songs![index]
                                                    .name
                                                    .toString(),
                                                popular: controller
                                                    .getSongbyPlaylistId
                                                    .value!
                                                    .data!
                                                    .songs![index]
                                                    .artistName
                                                    .toString(),
                                                songImage: controller
                                                    .getSongbyPlaylistId
                                                    .value!
                                                    .data!
                                                    .songs![index]
                                                    .imageFile
                                                    .toString(),
                                                topNumber: controller
                                                    .getSongbyPlaylistId
                                                    .value!
                                                    .data!
                                                    .songs![index]
                                                    .rank!
                                                    .toInt(),
                                                onPressed: () {
                                                  Get.toNamed(
                                                    RouteName.singMode,
                                                    arguments: {
                                                      'songData': controller
                                                          .getSongbyPlaylistId
                                                          .value!
                                                          .data!
                                                          .songs![index],
                                                      'singleSong': true,
                                                      'isMyPlaylist': true
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                            } else {
                              // Display a message when no songs are found
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: .25.sh,
                                  ),
                                  Text(
                                    'It\’s Empty!',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: const Color(0xFFF6AD00),
                                      fontSize: 32.sp,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      songSheetWithCharts(context);
                                    },
                                    child: Container(
                                      width: 120.w,
                                      height: 32.h,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 6),
                                      decoration: ShapeDecoration(
                                        color: Colors.white
                                            .withOpacity(0.10000000149011612),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '+ Add song',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Obx(
                          () => controller.iSearchingInsidePlayList.value
                              ? const SizedBox()
                              : Visibility(
                                  visible: controller.getSongbyPlaylistId.value
                                              ?.data?.songs !=
                                          null &&
                                      controller.getSongbyPlaylistId.value!
                                          .data!.songs!.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (controller.getSongbyPlaylistId.value
                                                    ?.data?.songs !=
                                                null &&
                                            controller
                                                .getSongbyPlaylistId
                                                .value!
                                                .data!
                                                .songs!
                                                .isNotEmpty) {
                                          final playList = controller
                                              .getSongbyPlaylistId.value?.data;
                                          PlayListData newShallowCpoy =
                                              PlayListData.fromJson(playList!
                                                  .toJson(imageHai: false));

                                          Get.toNamed(RouteName.singMode,
                                              arguments: {
                                                'playList': newShallowCpoy,
                                              });
                                        } else {
                                          AppDialogs.showToast(
                                              message:
                                                  'Please Add Songs to sing');
                                        }
                                      },
                                      child: Container(
                                        height: 56.h,
                                        padding: const EdgeInsets.symmetric(
                                                horizontal: 16)
                                            .r,
                                        decoration: ShapeDecoration(
                                          color: AppColor.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // const SizedBox(
                                            //   width: 8,
                                            // ),
                                            SizedBox(
                                              height: 40,
                                              width: 30,
                                              child: SvgPicture.asset(
                                                "assets/icons/play_btn.svg",
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(
                                              'Start Singing Now',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFF3A3B43),
                                                fontSize: 16.sp,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ))
                  ],
                ),
        ));
  }

  Future<dynamic> bottomSheetArtist(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        final controller = Get.find<HomeController>();
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
          child: Column(
            children: [
              const CustomDragHandle(),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                              child:
                                  SvgPicture.asset("assets/images/back.svg")),
                          const Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Text(
                              'Gredfen day',
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
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 15),
                      //     child: Row(
                      //       children: [
                      //         Obx(
                      //           () => Container(
                      //             height: 40,
                      //             width: 80,
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white
                      //                   .withOpacity(0.10000000149011612),
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(100),
                      //               ),
                      //             ),
                      //             child: DropdownButtonHideUnderline(
                      //               child: DropdownButton2<CountryModel>(
                      //                 // hint: Text(
                      //                 //   style: TextStyle(
                      //                 //     color: Colors.white,
                      //                 //     fontSize: 22.sp,
                      //                 //     fontFamily: 'Urbanist',
                      //                 //     fontWeight: FontWeight.w600,
                      //                 //   ),
                      //                 // ),
                      //                 items: [
                      //                   ...List.generate(
                      //                       controller.allCountryes.length,
                      //                       (index) => DropdownMenuItem(
                      //                           child: Column())),
                      //                 ],
                      //                 value: controller
                      //                     .currentSelectedCountryDropdown.value,
                      //                 onChanged: (CountryModel? value) {
                      //                   controller.currentSelectedCountry
                      //                       .value = value!.country;
                      //                   controller
                      //                       .currentSelectedCountryDropdown
                      //                       .value = value;
                      //                   print("Country Selected" +
                      //                       value.toString());

                      //                   GetAllSongsBloc().loadAllSongs(
                      //                       applyFilter: true,
                      //                       context: context,
                      //                       setProgressBar: () {
                      //                         AppDialogs.progressAlertDialog(
                      //                             context: context);
                      //                       });
                      //                 },

                      //                 dropdownStyleData:
                      //                     const DropdownStyleData(
                      //                   // maxHeight: 200,
                      //                   padding: EdgeInsets.zero,

                      //                   // width: 200.w,

                      //                   decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.only(
                      //                       bottomLeft: Radius.circular(14),
                      //                       bottomRight: Radius.circular(14),
                      //                     ),
                      //                     color: Color(0xFF23252F),
                      //                   ),
                      //                 ),

                      //                 menuItemStyleData:
                      //                     const MenuItemStyleData(
                      //                   height: 20,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //         buildContainer('Songs', 0, context),
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //         buildContainer('Artists', 1, context),
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //         buildContainer('All Songs', 2, context),
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: 20.h,
                      ),
                      Center(child: Image.asset("assets/images/notfound.png")),
                      const Center(
                        child: Text(
                          'Song Not Found!',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color(0xFFF6AD00),
                            fontSize: 32,
                            // height: 1.5,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Center(
                        child: Text(
                          'Try searching again using different keyword.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            height: 1.5,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  void bottomSheetSong(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetAllSongsBloc().loadAllSongs(
          applyFilter: true,
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });

      ////
    });
    final homeController = Get.find<HomeController>();
    Utils.showBottomSheetCustom(
        child: StatefulBuilder(builder: (context, innitState) {
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
                                    currentSelectedPlayListID)
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
                              // Get.clearRouteTree();

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
                                        playlistId: currentSelectedPlayListID,
                                        onSuccessCalled: () {
                                          homeController
                                              .selectedPlayList.value?.songs
                                              ?.add(homeController
                                                  .songs.value!.data![index]);
                                          GetSongsByPlayListIdBloc()
                                              .loadGetSongsByPlayListId(
                                                  context: context,
                                                  id: currentSelectedPlayListID,
                                                  setProgressBar: () {
                                                    AppDialogs
                                                        .progressAlertDialog(
                                                            context: context);
                                                  });

                                          GetPlayListByUserId()
                                              .loadGetPlayListByUserId(
                                                  selectedID:
                                                      currentSelectedPlayListID,
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
    }));
  }

  Future<List<String>> loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recentSearches') ?? [];
  }

  Future<void> addSearch(String newSearch) async {
    List<String> recentSearches = await loadRecentSearches();
    if (!recentSearches.contains(newSearch)) {
      recentSearches.insert(
          0, newSearch); // Add new search at the beginning of the list
      if (recentSearches.length > 10) {
        // Optional: limit the number of searches stored
        recentSearches.removeLast();
      }
      await saveRecentSearches(recentSearches);
      setState(() {
        recentSearchesFuture = Future.value(recentSearches);
      });
    }
  }

  late Future<List<String>> recentSearchesFuture;

  Future<void> saveRecentSearches(List<String> searches) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentSearches', searches);
  }

  void delayedSave(String item) {
    // Cancel any existing timer
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    // Set a new timer
    _debounce = Timer(const Duration(seconds: 2), () {
      // Perform the save operation here
      saveItem(item);
    });
  }

  void saveItem(String item) {
    print("Savving ITEEM");
    if (item.isNotEmpty) {
      addSearch(item);
    }
    // Logic to save the item
    // For example, saving to a database, sending to a server, etc.
  }

  Timer? _debounce;

  Future<dynamic> bottomSheetSearch(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   GetPlayListByUserId().loadGetPlayListByUserId(
    //       context: context,
    //       userId:
    //           Get.find<AuthController>().getAppLoginSession?.data?.userId ?? '',
    //       setProgressBar: () {
    //         AppDialogs.progressAlertDialog(context: context);
    //       });
    // });

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   GetAllSongsBloc().loadAllSongs(
    //       context: context,
    //       setProgressBar: () {
    //         AppDialogs.progressAlertDialog(context: context);
    //       });
    // });

    final homeController = Get.find<HomeController>();
    FocusNode focusNode = FocusNode();

    print("REBUILLLDLDDINGGG");

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            homeController.searchInBottomSheet.value = false;
            homeController.searchSongsController.clear();
            homeController.filteredSongs.clear();
            return Future.value(true);
          },
          child: StatefulBuilder(builder: (context, innerState) {
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
                        visible:
                            // homeController.getUserplaylist.value?.data != null,
                            homeController.songs.value?.data != null,
                        child:
                            //  homeController.getUserplaylist.value?.data != null
                            homeController.songs.value?.data != null
                                ? Column(
                                    children: [
                                      CustomTextField(
                                        focusNode: focusNode,
                                        textInputAction: TextInputAction.search,
                                        keyboardType: TextInputType.text,
                                        prefixImage: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: SvgPicture.asset(
                                              'assets/images/search_icon.svg'),
                                        ),
                                        hint: 'Search songs',
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(30)
                                        ],
                                        controller: homeController
                                            .searchSongsController,
                                        onchange: (searchText) {
                                          delayedSave(searchText);
                                        },
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      homeController.searchSongsController.text
                                              .isEmpty
                                          ? SizedBox(
                                              height: .4.sh,
                                              child: RecentSearchesWidget(
                                                focusNode: focusNode,
                                                controller: homeController
                                                    .searchSongsController,
                                              ))
                                          : homeController.searchInBottomSheet
                                                      .value &&
                                                  homeController
                                                      .filteredSongs.isEmpty
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30.w),
                                                  child: Column(children: [
                                                    SizedBox(
                                                      height: .0.sh,
                                                    ),
                                                    Center(
                                                        child: Image.asset(
                                                            "assets/images/notfound.png")),
                                                    const Center(
                                                      child: Text(
                                                        'Song Not Found!',
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                          // height: 1.5,
                                                          color:
                                                              Color(0xFFF6AD00),
                                                          fontSize: 32,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Try searching again using different keyword. ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.sp,
                                                        height: 1.5,
                                                        // letterSpacing: 0,
                                                        fontFamily:
                                                            AppFonts.Urbanist,
                                                        // fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ]),
                                                )
                                              : SizedBox(
                                                  height: 480.h,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount: homeController
                                                        .filteredSongs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final bool added = homeController
                                                              .getUserplaylist
                                                              .value
                                                              ?.data
                                                              ?.where((element) =>
                                                                  element
                                                                      .userPlaylistId ==
                                                                  currentSelectedPlayListID)
                                                              .firstOrNull
                                                              ?.songs
                                                              ?.any((element) =>
                                                                  element
                                                                      .songId ==
                                                                  homeController
                                                                      .filteredSongs[
                                                                          index]
                                                                      .songId) ==
                                                          true;
                                                      return Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 5),
                                                          child:
                                                              MusicPlayListSongADD(
                                                                  genre: homeController.filteredSongs[index].genre ??
                                                                      '',
                                                                  onImageTap:
                                                                      () {
                                                                    Navigator
                                                                        .pushNamed(
                                                                      context,
                                                                      RouteName
                                                                          .musicPlayDetailsScreen,
                                                                      arguments: {
                                                                        'songData':
                                                                            homeController.filteredSongs[index],
                                                                        'singleSong':
                                                                            true,
                                                                        'isMyPlaylist':
                                                                            true
                                                                      },
                                                                    );
                                                                  },
                                                                  topNumber: homeController
                                                                          .filteredSongs[
                                                                              index]
                                                                          .rank ??
                                                                      0,
                                                                  text: added
                                                                      ? 'Added'
                                                                      : null,
                                                                  name: homeController
                                                                          .filteredSongs[
                                                                              index]
                                                                          .name ??
                                                                      '',
                                                                  popular: homeController
                                                                          .filteredSongs[
                                                                              index]
                                                                          .artistName ??
                                                                      '',
                                                                  songImage: homeController
                                                                          .filteredSongs[
                                                                              index]
                                                                          .imageFile ??
                                                                      '',
                                                                  onPressed:
                                                                      () {
                                                                    if (added) {
                                                                      return;
                                                                    } else {
                                                                      PostSongPlaylistBloc().createPostSongPlaylistMethod(
                                                                          setProgressBar: () {
                                                                            AppDialogs.progressAlertDialog(context: context);
                                                                          },
                                                                          context: Get.context!,
                                                                          songId: homeController.filteredSongs[index].songId!,
                                                                          playlistId: currentSelectedPlayListID,
                                                                          onSuccessCalled: () {
                                                                            homeController.selectedPlayList.value?.songs?.add(homeController.filteredSongs[index]);
                                                                            GetSongsByPlayListIdBloc().loadGetSongsByPlayListId(
                                                                                context: context,
                                                                                id: currentSelectedPlayListID,
                                                                                setProgressBar: () {
                                                                                  AppDialogs.progressAlertDialog(context: context);
                                                                                });

                                                                            GetPlayListByUserId().loadGetPlayListByUserId(
                                                                                selectedID: currentSelectedPlayListID,
                                                                                context: context,
                                                                                userId: Get.find<AuthController>().getAppLoginSession?.data?.userId ?? '',
                                                                                setProgressBar: () {
                                                                                  AppDialogs.progressAlertDialog(context: context);
                                                                                });

                                                                            innerState(() {});
                                                                          });
                                                                    }
                                                                  }));
                                                    },
                                                  ),
                                                ),
                                    ],
                                  )
                                : const SizedBox(),
                      ),
                    ),

                    // CustomSearchTextField(
                    //   hintText: "Search songs",
                    // ),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Recent Searches',
                    //       style: TextStyl

                    //         color: Colors.white,
                    //         fontSize: 18,
                    //         fontFamily: 'Urbanist',
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     Text(
                    //       'Clear All',
                    //       textAlign: TextAlign.right,
                    //       style: TextStyle(
                    //         color: Color(0xFFF6AD00),
                    //         fontSize: 16,
                    //         fontFamily: 'Urbanist',
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // Divider(
                    //   thickness: 1,
                    //   color: Color(0xFF23252F),
                    // ),
                    // SizedBox(
                    //   height: 18.h,
                    // ),
                    // searchresult(
                    //   text: 'Ariana Grande',
                    // ),
                    // SizedBox(
                    //   height: 18.h,
                    // ),
                    // searchresult(
                    //   text: 'Morgan Wallen',
                    // ),
                    // SizedBox(
                    //   height: 18.h,
                    // ),
                    // searchresult(
                    //   text: 'Justin Bieber',
                    // ),
                    // SizedBox(
                    //   height: 18.h,
                    // ),
                    // searchresult(
                    //   text: 'Drake',
                    // ),
                    // SizedBox(
                    //   height: 18.h,
                    // ),
                    // searchresult(
                    //   text: 'Olivia Rodrigo',
                    // ),
                    // SizedBox(
                    //   height: 18.h,
                    // ),
                  ],
                ),
              ),
            );
          }),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> bottoSheetOnChatTap(BuildContext context, String chartId) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetSongChartById().loadGetSongChartById(
          context: context,
          applyFilter: true,
          id: chartId,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });
    });
    final homeController = Get.find<HomeController>();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, innserState) {
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
            child: SingleChildScrollView(
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
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Obx(
                            () => homeController.chartsSongsById.value?.data !=
                                    null
                                ? Text(
                                    // 'All Songs ',
                                    homeController
                                        .chartsSongsById.value!.data!.name
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    Obx(
                      () {
                        final songs =
                            homeController.chartsSongsById.value?.data?.songs;

                        return songs != null && songs.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                // padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: songs.length,
                                itemBuilder: (context, index) {
                                  final added = homeController
                                          .getUserplaylist.value?.data
                                          ?.where((element) =>
                                              element.userPlaylistId ==
                                              currentSelectedPlayListID)
                                          .firstOrNull
                                          ?.songs
                                          ?.any(
                                            (element) =>
                                                element.songId ==
                                                songs[index].songId.toString(),
                                          ) ==
                                      true;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 2),
                                    child: MusicPlayListSongADD(
                                        genre: songs[index].genre ?? '',
                                        onImageTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            RouteName.musicPlayDetailsScreen,
                                            arguments: {
                                              'songData': songs[index],
                                              'singleSong': true,
                                              'isMyPlaylist': true
                                            },
                                          );
                                        },
                                        text: added ? 'Added' : null,
                                        name: songs[index].name.toString(),
                                        popular:
                                            songs[index].artistName.toString(),
                                        songImage:
                                            songs[index].imageFile.toString(),
                                        topNumber: songs[index].rank!.toInt(),
                                        onPressed: () {
                                          // Get.toNamed(
                                          // // RouteName.musicPlayDetailsScreen,
                                          // arguments: {
                                          //   'songId': songs[index].songId,
                                          // },
                                          // );

                                          // selectplaylisttoaddSongBottomsheet(
                                          //   context,
                                          //   songs[index].songId.toString(),
                                          // );

                                          if (added) {
                                            return;
                                          } else {
                                            PostSongPlaylistBloc()
                                                .createPostSongPlaylistMethod(
                                                    context: Get.context!,
                                                    songId:
                                                        songs[index].songId!,
                                                    playlistId:
                                                        currentSelectedPlayListID,
                                                    onSuccessCalled: () {
                                                      homeController
                                                          .selectedPlayList
                                                          .value
                                                          ?.songs
                                                          ?.add(songs[index]);
                                                      GetSongsByPlayListIdBloc()
                                                          .loadGetSongsByPlayListId(
                                                              context: context,
                                                              id:
                                                                  currentSelectedPlayListID,
                                                              setProgressBar:
                                                                  () {
                                                                AppDialogs
                                                                    .progressAlertDialog(
                                                                        context:
                                                                            context);
                                                              });

                                                      GetPlayListByUserId()
                                                          .loadGetPlayListByUserId(
                                                              selectedID:
                                                                  currentSelectedPlayListID,
                                                              context: context,
                                                              userId: Get.find<
                                                                          AuthController>()
                                                                      .getAppLoginSession
                                                                      ?.data
                                                                      ?.userId ??
                                                                  '',
                                                              setProgressBar:
                                                                  () {
                                                                AppDialogs
                                                                    .progressAlertDialog(
                                                                        context:
                                                                            context);
                                                              });

                                                      innserState(() {});
                                                    },
                                                    setProgressBar: () {
                                                      AppDialogs
                                                          .progressAlertDialog(
                                                              context:
                                                                  Get.context!);
                                                    });
                                          }
                                        }),
                                  );
                                },
                              )
                            : const SizedBox(
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: SongsNotFound(),
                                )),
                              );
                      },
                    ),

                    // Obx(
                    //   () => homeController.chartsSongsById.value!.data!.songs != null
                    //       ? ListView.builder(
                    //           scrollDirection: Axis.vertical,
                    //           shrinkWrap: true,
                    //           physics: NeverScrollableScrollPhysics(),
                    //           itemCount: homeController
                    //               .chartsSongsById.value?.data?.songs?.length,
                    //           itemBuilder: (context, index) {
                    //             return Padding(
                    //               padding: const EdgeInsets.symmetric(
                    //                   vertical: 10, horizontal: 15),
                    //               child: MusicPlayList(
                    //                 name: homeController.chartsSongsById.value!
                    //                     .data!.songs![index].name
                    //                     .toString(),
                    //                 popular: homeController.chartsSongsById.value!
                    //                     .data!.songs![index].artistName
                    //                     .toString(),
                    //                 songImage: homeController.chartsSongsById
                    //                     .value!.data!.songs![index].imageFile
                    //                     .toString(),
                    //                 topNumber: homeController.chartsSongsById
                    //                     .value!.data!.songs![index].rank!
                    //                     .toInt(),
                    //                 onPressed: () {
                    //                   Get.toNamed(
                    //                     RouteName.musicPlayDetailsScreen,
                    //                     arguments: {
                    //                       'songId':
                    //                           // homeController.songs.value!.data![index].songId!,
                    //                           homeController
                    //                               .chartsSongsById
                    //                               .value!
                    //                               .data!
                    //                               .songs![index]
                    //                               .songId,
                    //                     },
                    //                   );
                    //                 },
                    //               ),
                    //             );
                    //           },
                    //         )
                    //       : SizedBox(

                    //         child: Container(color: Colors.green,

                    //         child: Text("nO SONGS FOUND",
                    //         style: TextStyle(
                    //           fontSize: 30
                    //         ),),
                    //         ),
                    //       ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> selectplaylisttoaddSongBottomsheet(
      BuildContext context, String songId) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   GetPlayListByUserId().loadGetPlayListByUserId(
    //       context: context,
    //       userId:
    //           Get.find<AuthController>().getAppLoginSession?.data?.userId ?? '',
    //       setProgressBar: () {
    //         AppDialogs.progressAlertDialog(context: context);
    //       });
    // });
    final homeController = Get.find<HomeController>();

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          // height: 360.h,
          height: 600.h,
          decoration: ShapeDecoration(
            color: const Color(0xFF1A1B22),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.w, color: const Color(0xFF2A2B39)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomDragHandle(),
                SizedBox(
                  height: 20.h,
                ),
                // Text(songId),
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
                SizedBox(
                  height: 20.h,
                ),

                Obx(
                  () => Visibility(
                    visible: homeController.getUserplaylist.value?.data != null,
                    child: homeController.getUserplaylist.value?.data != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount:
                                // homeController.getUserplaylist.value!.data.length,
                                homeController
                                    .getUserplaylist.value!.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child:
                                    // Text(
                                    //   homeController
                                    //       .getUserplaylist.value!.data![index].name
                                    //       .toString(),
                                    // )
                                    MyPlayListtoAddSong(
                                  name:
                                      //  'Christmas List',
                                      homeController.getUserplaylist.value!
                                          .data![index].name
                                          .toString(),
                                  popular: homeController
                                      .getUserplaylist.value!.data![index].name
                                      .toString(),
                                  songImage: homeController
                                      .getUserplaylist.value!.data![index].image
                                      .toString(),
                                  onPressed: () {
                                    // Get.toNamed(
                                    //   RouteName.allSongsInsidePlaylist,
                                    //   arguments: {
                                    //     'id': homeController.getUserplaylist
                                    //         .value!.data![index].userPlaylistId,
                                    //   },
                                    // );
                                  },
                                  onPressedAdd: () {
                                    print('testing print');
                                    print(
                                      homeController.getUserplaylist.value!
                                          .data![index].userPlaylistId
                                          .toString(),
                                    );
                                    print(songId);
                                    print('testing print');

                                    PostSongPlaylistBloc()
                                        .createPostSongPlaylistMethod(
                                            context: Get.context!,
                                            songId: songId,
                                            playlistId: homeController
                                                .getUserplaylist
                                                .value!
                                                .data![index]
                                                .userPlaylistId
                                                .toString(),
                                            setProgressBar: () {
                                              AppDialogs.progressAlertDialog(
                                                  context: Get.context!);
                                            });
                                  },
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.w, color: const Color(0xFF2A2B39)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> songSheetWithCharts(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ChartsBloc().loadCharts(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });

      // GetChartById().loadGetChartById(
      //     context: context,
      //     id: '5d13cc1c-85b2-44c3-8dc3-509781e6da7e',
      //     setProgressBar: () {
      //       AppDialogs.progressAlertDialog(context: context);
      //     });
    });
    final controller = Get.find<HomeController>();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 590.h,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDragHandle(),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Search Songs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    //   child: Text(
                    //     'X',
                    //     style: TextStyle(
                    //       color: AppColor.primaryColor,
                    //       fontSize: 20.sp,
                    //       fontFamily: 'Urbanist',
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //   ),
                    // ),

                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          'assets/images/close.png',
                          color: AppColor.primaryColor,
                          scale: 4,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: GestureDetector(
              //       onTap: () {
              //         bottomSheetSearch(context);
              //       },
              //       child: SearchFieldDesigin(
              //         hintText: "Search song",
              //       )),
              // ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomTextField(
                  readOnly: true,
                  hint: 'Search song',
                  prefixImage: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset('assets/images/search_icon.svg'),
                  ),
                  onTap: () {
                    bottomSheetSearch(context);
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Obx(() => Container(
                                height: 38,
                                // width: 120,
                                // padding: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    color: AppColor.linearProgressIndicator,
                                    borderRadius: BorderRadius.circular(35)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<CountryModel>(
                                      buttonStyleData: const ButtonStyleData(
                                          width: 130,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12)),
                                      value: controller
                                          .currentSelectedCountryDropdown.value,
                                      dropdownStyleData:
                                          const DropdownStyleData(
                                        padding: EdgeInsets.only(top: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(25),
                                              bottomRight: Radius.circular(25)),
                                          color:
                                              AppColor.dropdownBackgroundColor,
                                        ),
                                        // maxHeight: 400,
                                      ),
                                      selectedItemBuilder:
                                          (BuildContext context) {
                                        return controller.allCountryes
                                            .map<Widget>((CountryModel item) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child:
                                                      Image.asset(item.flag)),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              Text(
                                                item.country,
                                                style: TextStyle(
                                                    // fontSize: 22,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.whiteColor,
                                                    fontFamily:
                                                        AppFonts.Urbanist),
                                              ),
                                            ],
                                          );
                                        }).toList();
                                      },
                                      items: controller.allCountryes
                                          .asMap()
                                          .map((index, CountryModel item) {
                                            return MapEntry(
                                              index,
                                              DropdownMenuItem<CountryModel>(
                                                value: item,
                                                onTap: () {
                                                  controller
                                                      .currentSelectedCountry
                                                      .value = item.country;

                                                  print("Calue " +
                                                      controller
                                                          .currentSelectedCountry
                                                          .value);
                                                  controller
                                                      .currentSelectedCountryDropdown
                                                      .value = item;
                                                  print("'Calue Stted'");
                                                  // controller.selectedPlayList
                                                  //     .value = item;
                                                  // currentSelectedPlayListID =
                                                  //     item.userPlaylistId!;

                                                  // print(
                                                  //     "ONN CHANGED${item.userPlaylistId!}");

                                                  // controller.editingPlayList
                                                  //     .value = false;
                                                  // controller.editedSelected
                                                  //     .clear();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // const SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child: Image
                                                                  .asset(item
                                                                      .flag)),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            item.country,
                                                            style: TextStyle(
                                                                // fontSize: 22,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColor
                                                                    .whiteColor,
                                                                fontFamily:
                                                                    AppFonts
                                                                        .Urbanist),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      index !=
                                                              controller
                                                                      .allCountryes
                                                                      .length -
                                                                  1
                                                          ? Divider(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      .5),
                                                            )
                                                          : const Center(
                                                              child: SizedBox(
                                                                width: 30,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ), // Assuming PlayListData has a 'name' property for display
                                              ),
                                            );
                                          })
                                          .values
                                          .toList(),
                                      iconStyleData: IconStyleData(
                                          icon: SizedBox(
                                        // height: 20,
                                        // width: 20,
                                        child: Image.asset(
                                          'assets/images/dropdown_icon.png',
                                          scale: 2,
                                        ),
                                      )),
                                      onChanged: (CountryModel? newValue) {
                                        print("ONCHAGEDD ");
                                        controller
                                            .currentSelectedCountryDropdown
                                            .value = newValue;
                                      }),
                                ),
                              )

                          // Container(
                          //     height: 40,
                          //     padding: const EdgeInsets.symmetric(horizontal: 5),
                          //     decoration: BoxDecoration(
                          //         color: AppColor.linearProgressIndicator,
                          //         borderRadius: BorderRadius.circular(80)),
                          //     child: DropdownButton2<String>(
                          //       value: controller.currentSelectedCountry.value,
                          //       items: controller.dropdownItems,

                          //       // customButton: Padding(
                          //       //   padding: const EdgeInsets.onlx(left: 3),
                          //       //   child: Image.asset(
                          //       //     'assets/images/dropdown_icon.png',
                          //       //     scale: 2,
                          //       //   ),
                          //       dropdownStyleData: const DropdownStyleData(
                          //           decoration: BoxDecoration(
                          //               color: AppColor.darkBackgroundColor)),
                          //       iconStyleData: IconStyleData(
                          //         icon: Padding(
                          //           padding:
                          //               const EdgeInsets.only(left: 3, right: 8),
                          //           child: Image.asset(
                          //             'assets/images/dropdown_icon.png',
                          //             scale: 2,
                          //           ),
                          //         ),
                          //       ),

                          //       onChanged: (newValue) {
                          //         controller.currentSelectedCountry.value =
                          //             newValue!;

                          //         // innerState(() {
                          //         //   int selectedIndex = dropdownItems.indexWhere(
                          //         //       (item) => item.value == newValue);
                          //         //   int previousIndex = dropdownItems.indexWhere(
                          //         //       (item) => item.value == selectedValue);
                          //         //   DropdownMenuItem<String>
                          //         //       selectedDropdownItem =
                          //         //       dropdownItems[selectedIndex];
                          //         //   dropdownItems[selectedIndex] =
                          //         //       dropdownItems[previousIndex];
                          //         //   dropdownItems[previousIndex] =
                          //         //       selectedDropdownItem;
                          //         //   selectedValue = newValue!;
                          //         // });

                          //         GetAllSongsBloc().loadAllSongs(
                          //             applyFilter: true,
                          //             context: context,
                          //             setProgressBar: () {
                          //               AppDialogs.progressAlertDialog(
                          //                   context: context);
                          //             });
                          //       },

                          //       style: const TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 16,
                          //         fontFamily: 'Urbanist',
                          //         fontWeight: FontWeight.w600,
                          //       ),
                          //       underline: const SizedBox(),
                          //       // dropdownColor: Color.fromARGB(255, 24, 22, 22)),
                          //     )),

                          ),
                      const SizedBox(
                        width: 10,
                      ),
                      buildContainer('Songs', 0, context),
                      const SizedBox(
                        width: 10,
                      ),
                      buildContainer('Artists', 1, context),
                      const SizedBox(
                        width: 10,
                      ),
                      buildContainer('All Songs', 2, context),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => controller.charts.value != null
                    ?
                    // Text("data")
                    Expanded(
                        child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            primary: false,
                            shrinkWrap: true,
                            // scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 1.56,
                                    crossAxisSpacing: 20),
                            itemCount:
                                controller.charts.value?.data!.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return SearchSongChartBillBaordWidget(
                                chartData:
                                    controller.charts.value!.data![index],
                                onChartCardTap: () {
                                  bottoSheetOnChatTap(
                                    context,
                                    controller
                                        .charts.value!.data![index].chartId
                                        .toString(),
                                  );
                                },
                              );
                            }),
                      )
                    : const SizedBox(),
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Widget buildContainer(String text, int index, BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => GestureDetector(
        onTap: () {
          // bottomSheetSong(context);

          switch (index) {
            case 0:
              controller.currentSelectedTabIndex.value = 0;
              bottomSheetSong(context);
              break;
            case 1:
              controller.currentSelectedTabIndex.value = 1;
              bottomSheetSong(context);
              break;

            case 2:
              controller.currentSelectedTabIndex.value = 2;
              Utils.showBottomSheetCustom(
                  context: context,
                  child: AllSongsBottomSheet(
                      currentSelectedPlayListID: currentSelectedPlayListID));
          }
        },

        // bottomSheet(context);
        // Open a new bottom sheArtistet based on the selected index
        //   switch (index) {
        //     case 0:
        //       // bottomSheetSongs(context);
        //       bottomSheetSong(context);
        //       break;
        //     case 1:
        //       // Add code to handle the second container tap
        //       // bottomSheetArtist(context);
        //       bottomSheetSong(context);

        //       break;
        //     case 2:
        //       // Add code to handle the third container tap
        //       // var controller;
        //       // bottomSheetAllSong(
        //       //   context,
        //       //   controller.charts.value!.data![index].chartId.toString(),
        //       // );
        //       bottomSheetSong(context);

        //       break;
        //   }
        // },
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: ShapeDecoration(
            color: AppColor.linearProgressIndicator,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: controller.currentSelectedTabIndex.value == index
                    ? const Color(0xFFF6AD00)
                    : AppColor.linearProgressIndicator,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: controller.currentSelectedTabIndex.value == index
                  ? const Color(0xFFF6AD00)
                  : Colors.white,
              fontSize: 16,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
