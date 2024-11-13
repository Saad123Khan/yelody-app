import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/song/getall_songs_bloc.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/music_playlist.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

class NewSongListScreen extends StatefulWidget {
  const NewSongListScreen({Key? key}) : super(key: key);

  @override
  State<NewSongListScreen> createState() => _NewSongListScreenState();
}

class _NewSongListScreenState extends State<NewSongListScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetAllSongsBloc().loadAllSongs(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });

      ////
    });
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.darkBackgroundColor,
          centerTitle: false,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              'assets/icons/back_icon.png',
              scale: 2.5,
            ),
          ),
          title: Text.rich(TextSpan(children: [
            TextSpan(
              text: 'New Songs',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            // TextSpan(
            //   text: '#hiphop',
            //   style: TextStyle(
            //     color: AppColor.primaryColor,
            //     fontSize: 20.sp,
            //     fontFamily: 'Urbanist',
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            // TextSpan(
            //   text: ' rankings!',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 20.sp,
            //     fontFamily: 'Urbanist',
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
          ]))),
      body:

          // ListView.separated(
          //   scrollDirection : Axis.vertical,
          //   separatorBuilder: (context, index) {
          //     return const SizedBox(
          //       height: 15,
          //     );
          //   },
          //   itemBuilder: (context, index) {
          //        final playlist = playlists[index];
          //     return GestureDetector(
          //       onTap: (){
          //         Get.toNamed(RouteName.musicPlayDetailsScreen);
          //       },
          //       child: Padding(
          //          padding: const EdgeInsets.symmetric(horizontal: 15),
          //         child: MusicPlayList(
          //             name: playlist.name,
          //             popular: playlist.popular,
          //             songImage: playlist.songImage,
          //             topNumber: playlist.topNumber,
          //           ),
          //       ),
          //     );
          //   },
          //   itemCount: playlists.length,
          // ),

          Obx(
        () => Visibility(
          visible: homeController.songs.value?.data != null,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: homeController.songs.value?.data?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: MusicPlayList(
                  genre: homeController.songs.value!.data![index].genre ?? '',
                  name: homeController.songs.value!.data![index].name!,
                  popular: homeController.songs.value!.data![index].artistName!,
                  songImage:
                      homeController.songs.value!.data![index].imageFile!,
                  topNumber: homeController.songs.value!.data![index].rank!,
                  onImageTapped: () {
                    Get.toNamed(
                      RouteName.musicPlayDetailsScreen,
                      arguments: {
                        'songData': homeController.songs.value!.data![index],
                        'singleSong': true
                      },
                    );
                  },
                  onPressed: () {
                    Get.toNamed(
                      RouteName.singMode,
                      arguments: {
                        'songData': homeController.songs.value!.data![index],
                        'singleSong': true
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
