import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/my_playlist.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

class AllPlayListsScreen extends StatelessWidget {
  const AllPlayListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: AppColor.darkBackgroundColor,
        title: const Text(
          'All Playlists',
          style: TextStyle(
            fontFamily: AppFonts.Urbanist,
            color: AppColor.whiteColor,
          ),
        ),
      ),
      backgroundColor: AppColor.darkBackgroundColor,
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: homeController.recomdendedPlayList.value!.data!.length,
        itemBuilder: (context, index) {
          final playList =
              homeController.recomdendedPlayList.value!.data![index];
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: MyPlayList(
              buttonText: 'Sing',
              buttonImage: 'assets/icons/playicon.svg',
              name: homeController.recomdendedPlayList.value!.data![index].name
                  .toString(),
              popular:
                  '${homeController.recomdendedPlayList.value!.data![index].songs?.length} Songs',
              songImage: (playList.songs != null && playList.songs!.isNotEmpty)
                  ? playList.songs!.first.imageFile.toString()
                  : '',
              onButtonTapped: () {
                if (homeController
                            .recomdendedPlayList.value!.data![index].songs !=
                        null &&
                    homeController.recomdendedPlayList.value!.data![index]
                        .songs!.isNotEmpty) {
                  final playLis =
                      homeController.recomdendedPlayList.value!.data![index];

                  PlayListData newShallowCpoy =
                      PlayListData.fromJson(playLis.toJson(imageHai: true));

                  Get.toNamed(RouteName.singMode, arguments: {
                    'playList': newShallowCpoy,
                  });
                } else {
                  AppDialogs.showToast(
                      message: 'Please Add Songs in this playlist to sing');
                }
              },
              onPressed: () {
                if (playList.songs!.isNotEmpty) {
                  Get.toNamed(
                    RouteName.playListDetailsScreen,
                    arguments: playList,
                  );
                } else {
                  AppDialogs.showToast(
                      message: 'No songs available in this playlist');
                }
              },
            ),
          );
        },
      ),
    );
  }
}
