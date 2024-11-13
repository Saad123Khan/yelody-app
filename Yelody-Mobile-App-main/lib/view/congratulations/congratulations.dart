import 'package:confetti/confetti.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';
import 'package:yelody_app/models/songs/song_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/text.dart';

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({
    super.key,
    this.score,
    required this.isSingleSongs,
    this.playListData,
    this.currentIndex = 0,
  });
  final String? score;
  final bool isSingleSongs;
  final PlayListData? playListData;
  final int currentIndex;

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  late ConfettiController _controllerCenter;
  SongData? nextSong;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      calculateNextSong();
    });
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 20));
    _controllerCenter.play();
    super.initState();
  }

  calculateNextSong() {
    if (widget.playListData != null) {
      print("Cuurent Index" + widget.currentIndex.toString());
      if (widget.currentIndex + 1 <= widget.playListData!.songs!.length) {
        final next = widget.playListData?.songs?[widget.currentIndex + 1];

        if (next?.songId !=
            widget.playListData!.songs![widget.currentIndex].songId) {
          print("Current Song Removed From List");
          nextSong = next;
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(true);
        },
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              'assets/images/singmode_songbg.png',
              fit: BoxFit.cover,
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality
                        .explosive, // don't specify a direction, blast randomly
                    shouldLoop:
                        true, // start again as soon as the animation is finished
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ], // manually specify the colors to be used
                  ),
                ),
                SizedBox(
                  height: .3.sh,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        MyText.headingText('Score'),
                        MyText.headingText(
                          widget.score ?? '0',
                          height: 1.1,
                          fontSize: 80.sp,
                          color: AppColor.primaryColor,
                        ),
                        MyText.headingText('Congratulations!', height: .9),
                        SizedBox(
                          height: .3.sh,
                        ),
                      ],
                    )),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  height: .5.sh,
                  width: 1.sw,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: PrimaryButton(
                            height: 60,
                            color: AppColor.secondaryTextColor,
                            textColor: AppColor.whiteColor,
                            onpressed: () {
                              Get.back();
                              // Get.back();
                            },
                            text: 'Okay')),
                    SizedBox(
                      width: nextSong != null ? 20 : 0,
                    ),
                    nextSong == null
                        ? const SizedBox()
                        : Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                // Get.removeRoute(RouteName.singMode);

                                // int nextIndex = widget.currentIndex + 1;
                                widget.playListData?.songs
                                    ?.removeAt(widget.currentIndex);
                                Get.offNamed(RouteName.singMode, arguments: {
                                  'playList': widget.playListData,
                                  'currentIndex': widget.currentIndex,
                                });
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(90)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage:
                                            ExtendedNetworkImageProvider(
                                                NetworkStrings.imageURL +
                                                    nextSong!.imageFile!),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Next Song',
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                overflow: TextOverflow.ellipsis,
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                            SizedBox(
                                              // flex: 1,
                                              width: 105,
                                              child: Text(
                                                nextSong?.name ?? '',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: AppColor.blackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 22,
                                          // weight: 100,
                                          color: AppColor.secondaryTextColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  Get.offAllNamed(RouteName.bottomNavigation,
                      arguments: {'index': 3});
                },
                child: Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  width: .9.sw,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColor.primaryColor,
                          child: Icon(
                            Icons.check,
                            size: 15,
                            color: Colors.brown.shade400,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          'You can check your score at Profile Tab',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontFamily: AppFonts.Urbanist,
                              fontSize: 11.sp),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
