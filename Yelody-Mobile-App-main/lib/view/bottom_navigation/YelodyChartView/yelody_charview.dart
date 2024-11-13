import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/charts/chart_bloc.dart';
import 'package:yelody_app/models/charts/chart_list_res.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/music_playlist.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

import '../../../blocs/charts/getsongs _bychartid_bloc.dart';

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        backgroundColor: AppColor.darkBackgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 50,
          backgroundColor: AppColor.darkBackgroundColor,
          leading: Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 0, top: 12, bottom: 10),
            child: Image.asset("assets/icons/app_logo.png"),
          ),
          centerTitle: false,
          title: Text(
            'Charts',
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
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  height: 0.12.sh,
                  child:

                      //  Obx(() => controller.charts.value != null
                      //     ? ListView.separated(
                      //         scrollDirection: Axis.horizontal,
                      //         itemBuilder: (context, index) {
                      //           return ChartBillBaordWidget(
                      //             chartData: controller.charts.value!.data![index],
                      //             onChartCardTap: () {
                      //               GetSongChartById().loadGetSongChartById(
                      //                   context: context,
                      //                   id: controller
                      //                       .charts.value!.data![index].chartId
                      //                       .toString(),
                      //                   setProgressBar: () {
                      //                     AppDialogs.progressAlertDialog(
                      //                         context: context);
                      //                   });
                      //               // GetChartById().loadGetChartById(
                      //               //   context: context,
                      //               // id: controller.charts.value!.data![index].chartId.toString(),
                      //               //   setProgressBar: () {
                      //               //     AppDialogs.progressAlertDialog(
                      //               //         context: context);
                      //               //   },
                      //               // );
                      //             },
                      //           );
                      //         },
                      //         separatorBuilder: (context, index) {
                      //           return const SizedBox(
                      //             height: 50,
                      //           );
                      //         },
                      //         itemCount: controller.charts.value?.data!.length ?? 0)
                      //     : const SizedBox()),

                      Obx(() {
                    if (controller.charts.value != null &&
                        controller.charts.value!.data != null &&
                        controller.charts.value!.data!.isNotEmpty) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return index == controller.charts.value!.data!.length
                              ? const SizedBox(
                                  height: 120,
                                )
                              : ChartBillBaordWidget(
                                  chartData:
                                      controller.charts.value!.data![index],
                                  onChartCardTap: () {
                                    controller.selectedChartID.value =
                                        controller.charts.value!.data![index]
                                            .chartId!;
                                    GetSongChartById().loadGetSongChartById(
                                      context: context,
                                      id: controller
                                          .charts.value!.data![index].chartId
                                          .toString(),
                                      setProgressBar: () {
                                        AppDialogs.progressAlertDialog(
                                            context: context);
                                      },
                                    );
                                  },
                                );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: controller.charts.value!.data!.length + 1,
                      );
                    } else {
                      return const Center(
                        child: Text("Charts Not found"),
                      );
                    }
                  }),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(() => controller.chartsSongsById.value != null
                    //  homeController.chartsSongsById.value!.data
                    ? Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Top ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text:
                                  // '#Billboard',
                                  // controller.chartsSongsById.value!.data!.name.toString(),
                                  '#${controller.chartsSongsById.value!.data!.name}',
                              //  homeController.chartsSongsById.value!.data

                              style: TextStyle(
                                color: const Color(0xFFF6AD00),
                                fontSize: 24.sp,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: ' Rankings!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox()),
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(
                () {
                  final songs = controller.chartsSongsById.value?.data?.songs;

                  return songs != null && songs.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          // padding: EdgeInsets.zero,
                          // physics: const BouncingScrollPhysics(),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: MusicPlayList(
                                genre: songs[index].genre ?? '',
                                name: songs[index].name.toString(),
                                popular: songs[index].artistName.toString(),
                                songImage: songs[index].imageFile.toString(),
                                topNumber: songs[index].rank!.toInt(),
                                onImageTapped: () {
                                  Get.toNamed(
                                    RouteName.musicPlayDetailsScreen,
                                    arguments: {
                                      'songData': songs[index],
                                      'singleSong': true
                                    },
                                  );
                                },
                                onPressed: () {
                                  Get.toNamed(
                                    RouteName.singMode,
                                    arguments: {
                                      'songData': songs[index],
                                      'singleSong': true
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : const SizedBox(
                          child: Center(
                              child: Text(
                          'Songs Not Found!',
                        )));
                },
              ),
            ]),
          ),
        ));
  }
}

class ChartBillBaordWidget extends StatelessWidget {
  const ChartBillBaordWidget({
    super.key,
    required this.chartData,
    required this.onChartCardTap,
  });

  final ChartData chartData;
  final VoidCallback onChartCardTap;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2.4,
              color: Get.find<HomeController>().selectedChartID.value ==
                      chartData.chartId
                  ? AppColor.primaryColor
                  : Colors.transparent,
            )),
        child: GestureDetector(
          onTap: onChartCardTap,
          child: Stack(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: chartData.image != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              NetworkStrings.imageURL + chartData.image!))
                      : null,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(.5)),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        chartData.name ?? '',
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        chartData.title ?? '',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
