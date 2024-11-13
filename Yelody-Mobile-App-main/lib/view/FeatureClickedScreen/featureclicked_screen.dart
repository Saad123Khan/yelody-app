import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/charts/getchart%20_byid_bloc.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/agree_terms_condition.dart';
import 'package:yelody_app/res/components/custom_textfield.dart';
import 'package:yelody_app/res/components/music_playlist.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/FeatureClickedScreen/widgets/musicplay_class.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

class FeatureClicked extends StatefulWidget {
  const FeatureClicked({Key? key}) : super(key: key);

  @override
  State<FeatureClicked> createState() => _FeatureClickedState();
}

class _FeatureClickedState extends State<FeatureClicked> {
  List<MusicPlaylist> playlists = [
    MusicPlaylist(
        name: 'Shape of you',
        popular: 'Funk . ED Sheeran',
        songImage: 'assets/images/divide.png',
        topNumber: 1),
    MusicPlaylist(
        name: 'Starboy',
        popular: 'Dance .ED music',
        songImage: 'assets/images/starboy.png',
        topNumber: 2),
    MusicPlaylist(
        name: 'Positions',
        popular: 'Pop .ED Ariana ',
        songImage: 'assets/images/position.png',
        topNumber: 3),
    MusicPlaylist(
        name: 'Shape of you',
        popular: 'Funk . ED Sheeran',
        songImage: 'assets/images/divide.png',
        topNumber: 1),
    MusicPlaylist(
        name: 'Starboy',
        popular: 'Dance .ED music',
        songImage: 'assets/images/starboy.png',
        topNumber: 2),
    MusicPlaylist(
        name: 'Positions',
        popular: 'Pop .ED Ariana ',
        songImage: 'assets/images/position.png',
        topNumber: 3),
    MusicPlaylist(
        name: 'Shape of you',
        popular: 'Funk . ED Sheeran',
        songImage: 'assets/images/divide.png',
        topNumber: 1),
    MusicPlaylist(
        name: 'Starboy',
        popular: 'Dance .ED music',
        songImage: 'assets/images/starboy.png',
        topNumber: 2),
    MusicPlaylist(
        name: 'Positions',
        popular: 'Pop .ED Ariana ',
        songImage: 'assets/images/position.png',
        topNumber: 3),
    MusicPlaylist(
        name: 'Shape of you',
        popular: 'Funk . ED Sheeran',
        songImage: 'assets/images/divide.png',
        topNumber: 1),
    MusicPlaylist(
        name: 'Starboy',
        popular: 'Dance .ED music',
        songImage: 'assets/images/starboy.png',
        topNumber: 2),
    MusicPlaylist(
        name: 'Positions',
        popular: 'Pop .ED Ariana ',
        songImage: 'assets/images/position.png',
        topNumber: 3),
    MusicPlaylist(
        name: 'Starboy',
        popular: 'Dance .ED music',
        songImage: 'assets/images/starboy.png',
        topNumber: 2),
    MusicPlaylist(
        name: 'Positions',
        popular: 'Pop .ED Ariana ',
        songImage: 'assets/images/position.png',
        topNumber: 3),
    MusicPlaylist(
        name: 'Shape of you',
        popular: 'Funk . ED Sheeran',
        songImage: 'assets/images/divide.png',
        topNumber: 1),
    MusicPlaylist(
        name: 'Starboy',
        popular: 'Dance .ED music',
        songImage: 'assets/images/starboy.png',
        topNumber: 2),
    MusicPlaylist(
        name: 'Positions',
        popular: 'Pop .ED Ariana ',
        songImage: 'assets/images/position.png',
        topNumber: 3),
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final String chartId = args?['chartId'] ?? '';

    print("***************************************");
    print(chartId);
    print("***************************************");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ChartsBloc().loadCharts(
      //     context: context,
      //     setProgressBar: () {
      //       AppDialogs.progressAlertDialog(context: context);
      //     });

      GetChartById().loadGetChartById(
          context: context,
          id: chartId,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });
    });
    final controller = Get.find<HomeController>();

    return Scaffold(
        backgroundColor: AppColor.darkBackgroundColor,
        appBar: AppBar(
            elevation: 0,
            centerTitle: false,
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
            titleSpacing: 0,
            title: Obx(
              () => controller.chartsById.value != null
                  ? Text.rich(TextSpan(children: [
                      TextSpan(
                        text: 'Top ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text:
                            controller.chartsById.value!.data!.name.toString(),
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 20.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' rankings!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]))
                  : const SizedBox(),
            )),
        body: Column(
          children: [
            Obx(() => controller.chartsById.value != null
                ? GestureDetector(
                    onTap: () {
                      // Get.toNamed(RouteName.musicPlayDetailsScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: MusicPlayList(
                        genre: '',
                        name:
                            controller.chartsById.value!.data!.name.toString(),
                        popular: controller.chartsById.value!.data!.description
                            .toString(),
                        songImage:
                            controller.chartsById.value!.data!.image.toString(),
                        topNumber:
                            controller.chartsById.value!.data!.rank!.toInt(),
                        onPressed: () {},
                      ),
                    ),
                  )
                : const SizedBox())
          ],
        )
        //  Obx(
        //         ()=>

        //         controller.chartsById.value != null?
        //          GestureDetector(
        //                 onTap: () {
        //                   Get.toNamed(RouteName.musicPlayDetailsScreen);
        //                 },
        //                 child: Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 15),
        //                   child: MusicPlayList(
        //                     name: controller.chartsById.value!.data!.name.toString(),
        //                     popular: controller.chartsById.value!.data!.description.toString(),

        //                     songImage: controller.chartsById.value!.data!.image.toString(),
        //                     topNumber: controller.chartsById.value!.data!.rank!.toInt(), onPressed: () {  },
        //                   ),
        //                 ),
        //               )
        //               :
        //               SizedBox()
        //       )

        );
  }
}
