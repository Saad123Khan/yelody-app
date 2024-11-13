import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';
import 'package:yelody_app/models/songs/song_model.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/music_playlist.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';

class PlayListDetailScreen extends StatefulWidget {
  const PlayListDetailScreen({
    super.key,
  });

  @override
  State<PlayListDetailScreen> createState() => _PlayListDetailScreenState();
}

class _PlayListDetailScreenState extends State<PlayListDetailScreen> {
  PlayListData playList = Get.arguments;

  @override
  void initState() {
    // playList.songs = Get.arguments ?? [];
    playList.songs?.sort(((a, b) => a.rank!.compareTo(b.rank!)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AppColor.darkBackgroundColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: GestureDetector(
          onTap: () {
            if (playList.songs != null && playList.songs!.isNotEmpty) {
              // final playList = controller.getSongbyPlaylistId.value?.data;
              PlayListData newShallowCpoy =
                  PlayListData.fromJson(playList.toJson(imageHai: false));

              Get.toNamed(RouteName.singMode, arguments: {
                'playList': newShallowCpoy,
              });
            } else {
              AppDialogs.showToast(message: 'Please Add Songs to sing');
            }
          },
          child: Container(
            height: 56.h,
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            decoration: ShapeDecoration(
              color: AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppColor.darkBackgroundColor,
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
          playList.name ?? '',
          style: TextStyle(
              color: AppColor.whiteColor,
              fontFamily: AppFonts.Urbanist,
              fontSize: 24.sp),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: (playList.songs?.length ?? 0) + 1,
        itemBuilder: (context, index) {
          SongData? song;
          if (index < playList.songs!.length) {
            song = playList.songs?[index];
          }

          return index == playList.songs?.length
              ? const SizedBox(
                  height: 100,
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: MusicPlayList(
                    genre: song?.genre ?? '',
                    name: song?.name ?? '',
                    popular: song?.artistName ?? '',
                    songImage: song?.imageFile ?? '',
                    topNumber: song?.rank ?? 0,
                    onImageTapped: () {
                      Get.toNamed(
                        RouteName.musicPlayDetailsScreen,
                        arguments: {'songData': song, 'singleSong': true},
                      );
                    },
                    onPressed: () {
                      Get.toNamed(
                        RouteName.singMode,
                        arguments: {'songData': song, 'singleSong': true},
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
