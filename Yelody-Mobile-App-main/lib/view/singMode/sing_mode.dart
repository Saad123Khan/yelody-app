import 'dart:developer';
// import 'package:audioplayers/audioplayers.dart';
import 'package:blur/blur.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yelody_app/blocs/auth/upload_song.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'dart:async';
import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:yelody_app/res/components/music_playlist.dart';
import 'package:yelody_app/services/permission_manager_service.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/text.dart';
import 'package:yelody_app/utils/utils.dart';
import 'package:yelody_app/view/MusicPlayDetailScreen/widgets/head_set_dialog.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyProfile/widgets/drag_handle_custom.dart';
import 'package:yelody_app/view/singMode/controller/songController.dart';
import 'package:yelody_app/view/singMode/custom_equilizer.dart';

class SingModeScreen extends StatefulWidget {
  const SingModeScreen({super.key});

  @override
  State<SingModeScreen> createState() => _SingModeScreenState();
}

class _SingModeScreenState extends State<SingModeScreen> {
  late final SongController controller;

  checkPermissions() async {
    final storagePermissionStatus =
        await PermissionManager.checkStoragePermission();
    final audioPermissionStatus =
        await PermissionManager.checkAudioPermission();

    print("Storage Permission ${storagePermissionStatus.name}");
    print("Audio Permission ${audioPermissionStatus.name}");

    if (storagePermissionStatus == PermissionStatusResult.granted &&
        audioPermissionStatus == PermissionStatusResult.granted) {
      // Both storage and audio permissions are already granted
      // _navigateToSingMode();
      showSOngPopup();
    } else {
      final permissionRequestResult =
          await PermissionManager.requestAllPermissions();

      switch (permissionRequestResult) {
        case PermissionStatusResult.granted:
          // Both storage and audio permissions granted after request
          // _navigateToSingMode();
          showSOngPopup();
          break;
        case PermissionStatusResult.denied:
          PermissionManager.requestAudioPermission();
          checkPermissions();
          // Handle the case where permissions are denied (but not permanently)
          break;
        case PermissionStatusResult.permanentlyDenied:
          // Handle the case where permissions are permanently denied
          Fluttertoast.showToast(
              msg:
                  'Please Allow the Sound and Storage Permssion to Continue Reocding');
          openAppSettings();
          break;
      }
    }
  }

  showSOngPopup() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // ""60c4fb44-96d7-4c4c-ad27-755c2dd02d05"";
      Utils.showAppDialog(
          context: context,
          onBackTap: () {
            Get.back();
            // Get.back();
          },
          onWIllPop: () {
            Get.close(2);
          },
          child: HeadSetDialog(
            onTap: () {
              Navigator.pop(context);
              controller.loadSongByID(controller.songData.value?.songId ?? '',
                  context, controller.songData.value?.lyricsXml ?? '');
            },
          ));
    });
  }

  @override
  void initState() {
    Get.delete<SongController>();
    controller = Get.put(SongController());
    checkPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Utils.showExitSheet(
            context: context,
            onTap: () async {
              await controller.audioRecordService.dispose();
              await controller.audioPlayer?.stop();
              Get.delete<SongController>();
              Get.back();
              Get.back();
            },
            isCloseSong: controller.isCloseSong.value,
            onTapCancel: () {
              // isCloseSong:
              controller.isCloseSong.value = false;
              Get.back();
            });
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.secondaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Obx(
            () => controller.playlistModel.value != null &&
                    controller.currentSongIndex.value <
                        controller.playlistModel.value!.songs!.length - 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///THIS IS FOR PLAYLISTs
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 36.h,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.4000000059604645),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.w,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: const Color(0x339E9E9E),
                              ),
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Container(
                              //   width: 24.w,
                              //   height: 24.h,
                              //   decoration: const ShapeDecoration(
                              //     image: DecorationImage(
                              //       image:
                              //           AssetImage("assets/images/divide_appbar.png"),
                              //       fit: BoxFit.fill,
                              //     ),
                              //     shape: OvalBorder(),
                              //   ),
                              // ),

                              CircleAvatar(
                                radius: 13,
                                backgroundImage: controller
                                            .playlistModel
                                            .value!
                                            .songs?[controller
                                                    .currentSongIndex.value +
                                                1]
                                            .imageFile !=
                                        null
                                    ? ExtendedNetworkImageProvider(
                                        NetworkStrings.imageURL +
                                            controller
                                                .playlistModel
                                                .value!
                                                .songs![controller
                                                        .currentSongIndex
                                                        .value +
                                                    1]
                                                .imageFile
                                                .toString())
                                    : null,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'Next ',
                                style: TextStyle(
                                  color: const Color(0xFFF6AD00),
                                  fontSize: 12.sp,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Obx(
                                () => Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: controller
                                            .playlistModel
                                            .value!
                                            .songs?[controller
                                                    .currentSongIndex.value +
                                                1]
                                            .name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          // overflow: TextOverflow.ellipsis,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '  by ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: controller
                                            .playlistModel
                                            .value!
                                            .songs?[controller
                                                    .currentSongIndex.value +
                                                1]
                                            .artistName,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            // Get.find<SongController>().dispose();
                            // Get.back();

                            Utils.showExitSheet(
                                context: context,
                                onTap: () async {
                                  await controller.audioRecordService.dispose();
                                  await controller.audioPlayer?.stop();

                                  Get.delete<SongController>();
                                  Get.back();
                                  Get.back();
                                },
                                isCloseSong: controller.isCloseSong.value =
                                    true,
                                onTapCancel: () {
                                  // isCloseSong:
                                  controller.isCloseSong.value = false;
                                  Get.back();
                                });
                          },
                          child: Image.asset(
                            'assets/images/close.png',
                            scale: 3,
                          )),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 36.h,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.4000000059604645),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.w,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: const Color(0x339E9E9E),
                              ),
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Container(
                              //   width: 24.w,
                              //   height: 24.h,
                              //   decoration: const ShapeDecoration(
                              //     image: DecorationImage(
                              //       image:
                              //           AssetImage("assets/images/divide_appbar.png"),
                              //       fit: BoxFit.fill,
                              //     ),
                              //     shape: OvalBorder(),
                              //   ),
                              // ),

                              CircleAvatar(
                                radius: 13,
                                backgroundImage:
                                    controller.songData.value?.imageFile != null
                                        ? ExtendedNetworkImageProvider(
                                            NetworkStrings.imageURL +
                                                controller
                                                    .songData.value!.imageFile!)
                                        : null,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              // Text(
                              //   'Next   ',
                              //   style: TextStyle(
                              //     color: const Color(0xFFF6AD00),
                              //     fontSize: 12.sp,
                              //     fontFamily: 'Urbanist',
                              //     fontWeight: FontWeight.w700,
                              //   ),
                              // ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Obx(
                                () => Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: controller.songData.value?.name ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '  by ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: controller
                                                .songData.value?.artistName ??
                                            '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.isCloseSong.value = true;
                          Utils.showExitSheet(

                              // add this sheet open is true   controller.isCloseSong.value = true;
                              context: context,
                              onTap: () async {
                                await controller.audioRecordService.dispose();
                                await controller.audioPlayer?.stop();

                                Get.delete<SongController>();
                                Get.back();
                                Get.back();
                              },
                              isCloseSong: controller.isCloseSong.value = true,
                              onTapCancel: () {
                                controller.isCloseSong.value = false;
                                Get.back();
                              });
                        },
                        child: Image.asset(
                          'assets/images/close.png',
                          scale: 3,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Obx(
                () => SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: Center(
                    child: Image.network(
                      NetworkStrings.imageURL +
                          controller.songData.value!.imageFile.toString(),
                      fit: BoxFit.cover,
                      height: 1.sh,
                      width: 1.sw,
                    ).blurred(
                        colorOpacity: .5,
                        blur: 40,
                        blurColor: Colors.black.withOpacity(.4)),
                  ),
                ),
              ),

              // Blur(
              //   blur: 100,
              //   blurColor: Theme.of(context).primaryColor,
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: controller.songData?.imageFile != null
              //             ? ExtendedNetworkImageProvider(
              //                 NetworkStrings.imageURL +
              //                     controller.songData!.imageFile!,
              //               )
              //             : const AssetImage(
              //                 "assets/images/singmode_songbg.png",
              //               ) as ImageProvider,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),

              Obx(
                () => Padding(
                    padding: EdgeInsets.only(top: 135),
                    child: controller.isCloseSong.value
                        ? Obx(
                            () => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                // color: Colors.red,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        "assets/images/singing_logo.svg"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                // 'Electronic',
                                                controller.songData.value
                                                        ?.genre ??
                                                    '',
                                                style: TextStyle(
                                                  color: Color(0xFF9E9E9E),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                // 'Starboy',
                                                controller
                                                        .songData.value?.name ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24.sp,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                // 'weekend',
                                                controller.songData.value
                                                        ?.artistName ??
                                                    '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.sp,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox()
                    // Container(
                    //   height: 100,
                    //   width: 100,
                    //   color: Colors.yellow,
                    //   child: Text(
                    //     isClose ? 'click' : 'no click',
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    // ),
                    ),
              ),

              Obx(
                () => controller.lyricsInitilazied.value
                    ? Padding(
                        padding: EdgeInsets.only(bottom: .06.sh),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Expanded(child: )

                            // if (controller.sliderProgress <
                            //     controller.maxValue.value)
                            //   Padding(
                            //     padding:
                            //         const EdgeInsets.only(left: 12, right: 12),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Align(
                            //           alignment: Alignment.topLeft,
                            //           child: Text(
                            //             controller.playProgress.value == 0002
                            //                 ? ''
                            //                 : (controller.playProgress.value /
                            //                         60000)
                            //                     .toStringAsFixed(2),
                            //             style: const TextStyle(
                            //               fontSize: 12,
                            //               color: Colors.green,
                            //             ),
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Slider(
                            //             min: 0,
                            //             max: controller.maxValue.value,
                            //             label: controller.sliderProgress
                            //                 .toString(),
                            //             value: controller.sliderProgress.value,
                            //             activeColor: Colors.white,
                            //             inactiveColor: Colors.amber,
                            //             onChanged: (double value) {
                            //               // setState(() {
                            //               controller.sliderProgress.value =
                            //                   value;
                            //               // });
                            //             },
                            //             onChangeStart: (double value) {
                            //               controller.isTap.value = true;
                            //             },
                            //             onChangeEnd: (double value) {
                            //               controller.isTap.value = false;
                            //               // setState(() {
                            //               controller.playProgress.value =
                            //                   value.toInt();

                            //               controller.audioPlayer?.seek(Duration(
                            //                   milliseconds: value.toInt()));
                            //             },
                            //           ),
                            //         ),
                            //         Text(
                            //           controller.maxValue.value == 11111
                            //               ? ''
                            //               : (controller.maxValue / 60000)
                            //                   .toStringAsFixed(2),
                            //           style: const TextStyle(
                            //             fontSize: 12,
                            //             color: Colors.green,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ToneBtn(context);
                                    },
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/tone_icon.svg"),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        const Text(
                                          'Tone',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Utils.showBottomSheetCustom(
                                          child: EqualizerBottomSheet(),
                                          context: context);
                                      // Equilizer(context);
                                      // try {
                                      //   await EqualizerFlutter.init(1);
                                      //   // await EqualizerFlutter.open(2);
                                      // } on PlatformException catch (e) {
                                      //   final snackBar = SnackBar(
                                      //     behavior: SnackBarBehavior.floating,
                                      //     content:
                                      //         Text('${e.message}\n${e.details}'),
                                      //   );

                                      //   print("EQ is Not Found $e");

                                      //   AppDialogs.showToast(
                                      //       message: 'Equalizer Not Found');

                                      //   // Scaffold.of(context).showSnackBar(snackBar);
                                      // }
                                    },
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/equilizer.svg"),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        const Text(
                                          'Equalizer',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => InkWell(
                                      onTap: () async {
                                        // Initialize the audio player if not already done

                                        if (controller.playing.value) {
                                          print("AUDIO PLAYSTATE PLAYING");
                                          await controller.audioRecordService
                                              .pauseRecording();
                                          await controller.audioPlayer?.pause();
                                        } else {
                                          if (controller.audioPlayer == null) {
                                            print("AUDIO PLAYER IS NULL");

                                            controller.audioPlayer =
                                                AudioPlayer();
                                            await controller.audioPlayer
                                                ?.setFilePath(controller
                                                        .musicFile
                                                        .value
                                                        ?.path ??
                                                    '');

                                            controller
                                                .audioPlayer?.durationStream
                                                .listen((event) {
                                              controller.maxValue.value = event!
                                                  .inMilliseconds
                                                  .toDouble();
                                            });

                                            controller
                                                .audioPlayer?.playerStateStream
                                                .listen((event) async {
                                              bool isPlaying = event.playing;
                                              final processingState =
                                                  event.processingState;

                                              if (processingState ==
                                                  ProcessingState.completed) {
                                                final path = await controller
                                                    .audioRecordService
                                                    .stopAudioAndSaveFile();

                                                print("COMPLETED");

                                                // ignore: use_build_context_synchronously
                                                UploadSong()
                                                    .uploadSongForResult(
                                                        playListData: controller
                                                            .playlistModel
                                                            .value,
                                                        singleSong: Get
                                                                    .arguments?[
                                                                'singleSong'] ??
                                                            false,
                                                        context: context,
                                                        setProgressBar: () {
                                                          AppDialogs
                                                              .progressAlertDialog(
                                                                  context:
                                                                      context,
                                                                  loadingText:
                                                                      'We are generating your score \nPlease wait...');
                                                        },
                                                        songID: controller
                                                            .songData
                                                            .value!
                                                            .songId!,
                                                        songPath: path!,
                                                        fileUrl: controller
                                                            .songData
                                                            .value!
                                                            .lyricsTxt!);
                                              }
                                              controller.playing.value =
                                                  isPlaying;
                                            });

                                            controller
                                                .audioPlayer?.positionStream
                                                .listen((event) {
                                              controller.sliderProgress.value =
                                                  event.inMilliseconds
                                                      .toDouble();
                                              controller.playProgress.value =
                                                  event.inMilliseconds;
                                            });
                                            await controller.audioRecordService
                                                .startAudioRecording();
                                            await controller.audioPlayer
                                                ?.play();
                                          } else {
                                            print(
                                                "AUDIO PLAYER IS RESUMING NO NULL");
                                            await controller.audioRecordService
                                                .resumeRecoding();
                                            await controller.audioPlayer
                                                ?.play();
                                          }
                                        }

                                        // if (controller.audioPlayer == null) {
                                        //   controller.audioPlayer = AudioPlayer();
                                        //   await controller.audioPlayer
                                        //       ?.setFilePath(controller
                                        //               .musicFile.value?.path ??
                                        //           '');

                                        //   controller
                                        //       .audioPlayer?.playerStateStream
                                        //       .listen((state) async {
                                        //     bool isPlaying = state.playing;
                                        //     ProcessingState processingState =
                                        //         state.processingState;

                                        //     if (processingState ==
                                        //         ProcessingState.completed) {
                                        //       final path = await controller
                                        //           .audioRecordService
                                        //           .stopAudioAndSaveFile();

                                        //       print("File Paht $path");

                                        //       // ignore: use_build_context_synchronously
                                        //       //
                                        //     }

                                        //     // Update playing state
                                        //     controller.playing.value = isPlaying;
                                        //   });

                                        //   controller.audioPlayer?.durationStream
                                        //       .listen((event) {
                                        //     controller.sliderProgress.value =
                                        //         event!.inMilliseconds.toDouble();
                                        //     controller.playProgress.value =
                                        //         event.inMilliseconds;
                                        //   });

                                        //   if (!controller.audioPlayer!.playing) {
                                        //     await controller.audioPlayer?.play();
                                        //     await controller.audioRecordService
                                        //         .startAudioRecording();
                                        //   }
                                        //   log("Audio Recoding Started");

                                        //   // Subscribe to player state changes

                                        // }

                                        // else {
                                        // if (controller.audioPlayer!.playing) {
                                        //   log("Pausing a Played Audio");
                                        //   await controller.audioPlayer?.pause();
                                        //   await controller.audioRecordService
                                        //       .pauseRecording();
                                        // } else {
                                        //   log("Plaaying a Paused Audio");
                                        //   await controller.audioPlayer
                                        //       ?.play(); // This resumes playback if the player is paused
                                        //   await controller.audioRecordService
                                        //       .resumeRecoding();
                                        // }
                                        // }

                                        // Play or pause based on current state
                                        // if (controller.playing.value) {
                                        //   await controller.audioPlayer?.pause();
                                        //   await controller.audioRecordService
                                        //       .pauseRecording();
                                        //   log("Paused Song");
                                        // } else {
                                        //   print("NOT PLAYING");
                                        //   if (controller
                                        //           .audioPlayer?.processingState ==
                                        //       ProcessingState.idle) {
                                        //     await controller.audioPlayer?.play();
                                        //     await controller.audioRecordService
                                        //         .startAudioRecording();
                                        //     log("Started AUdio Recoding Song");
                                        //   } else {
                                        //     await controller.audioPlayer
                                        //         ?.play(); // This resumes playback if the player is paused
                                        //     await controller.audioRecordService
                                        //         .resumeRecoding();
                                        //     log("Resumed Song");
                                        //   }
                                        // }
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF6AD00),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(42),
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            controller.playing.value
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: AppColor.darkBackgroundColor,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Utils.moveToNextSheet(context: context);

                                      // if (controller.playing.value) {
                                      //   if (controller.playProgress.value <
                                      //       10000) {
                                      //     controller.showSkipIntro.value = true;
                                      //     Future.delayed(
                                      //         const Duration(seconds: 2), () {
                                      //       controller.showSkipIntro.value =
                                      //           false;
                                      //     });
                                      //   }
                                      //   controller.playProgress.value +=
                                      //       3000; // Skip 3 seconds

                                      //   controller.audioPlayer?.seek(
                                      //     Duration(
                                      //         milliseconds: controller
                                      //             .playProgress.value
                                      //             .toInt()),
                                      //   );
                                      // }
                                      controller.skipIntro();
                                    },
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/skip.svg"),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'Skip',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      QueueBtn(context,
                                          controller.songData.value!.songId!);
                                    },
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/queue.svg"),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        const Text(
                                          'Queue',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              )

              //   SingleChildScrollView(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 15),
              //       child: Column(
              //         children: [
              //           SizedBox(
              //             height: MediaQuery.of(context).size.height * 0.38,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              //  Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             ToneBtn(context);
              //           },
              //           child: Column(
              //             children: [
              //               SvgPicture.asset("assets/icons/tone_icon.svg"),
              //               const SizedBox(
              //                 height: 3,
              //               ),
              //               const Text(
              //                 'Tone',
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 12,
              //                   fontFamily: 'Urbanist',
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         GestureDetector(
              //           onTap: () async {
              //             try {
              //               await EqualizerFlutter.open(0);
              //             } on PlatformException catch (e) {
              //               final snackBar = SnackBar(
              //                 behavior: SnackBarBehavior.floating,
              //                 content: Text('${e.message}\n${e.details}'),
              //               );
              //
              //               print("EQ is Not Found " + e.toString());
              //               // Scaffold.of(context).showSnackBar(snackBar);
              //             }
              //           },
              //           child: Column(
              //             children: [
              //               SvgPicture.asset("assets/icons/equilizer.svg"),
              //               const SizedBox(
              //                 height: 3,
              //               ),
              //               const Text(
              //                 'Equalizer',
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 12,
              //                   fontFamily: 'Urbanist',
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         GestureDetector(
              //           onTap: () {},
              //           child: Column(
              //             children: [
              //               // Image.asset("assets/images/playBtn.png")
              //               InkWell(
              //                   onTap: () async {
              //                     if (controller.playing.value) {
              //                       await controller.pauseSong();
              //                     } else {
              //                       if (controller.audioPlayer == null) {
              //                         controller.audioPlayer = AudioPlayer()
              //                           ..play(DeviceFileSource("/audios/music1.mp3"));
              //                         // setState(() {
              //                           playing = true;
              //                         // });
              //                         controller.audioPlayer?.onDurationChanged
              //                             .listen((Duration event) {
              //                           // setState(() {
              //                             controller.maxValue.value =
              //                                 event.inMilliseconds.toDouble();
              //                           // });
              //                         });
              //                         controller.audioPlayer?.onPositionChanged
              //                             .listen((Duration event) {
              //                           if (controller.isTap.value) return;
              //                           // setState(() {
              //                             controller.sliderProgress.value =
              //                                 event.inMilliseconds.toDouble();
              //                             controller.playProgress.value = event.inMilliseconds;
              //                           // });
              //                         });
              //
              //                        controller.audioPlayer?.onPlayerStateChanged
              //                             .listen((PlayerState state) {
              //                           // setState(() {
              //                             controller.playing.value = state == PlayerState.playing;
              //                           // });
              //                         });
              //                       } else {
              //                         controller.audioPlayer?.resume();
              //                       }
              //                     }
              //                   },
              //                   child: Container(
              //                     width: 56,
              //                     height: 56,
              //                     padding: const EdgeInsets.all(14),
              //                     decoration: ShapeDecoration(
              //                       color: const Color(0xFFF6AD00),
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(42),
              //                       ),
              //                     ),
              //                     child: Center(
              //                       child: Icon(
              //                         playing ? Icons.pause : Icons.play_arrow,
              //                         size: 30.sp,
              //                       ),
              //                     ),
              //                   )
              //
              //                   //  isPlaying ? Icons.pause_circle : Icons.play_circle,
              //                   // SvgPicture.asset(
              //                   //     "assets/icons/play_icon.svg")),
              //                   )
              //             ],
              //           ),
              //         ),
              //         Column(
              //           children: [
              //             SvgPicture.asset("assets/icons/skip.svg"),
              //             const SizedBox(
              //               height: 3,
              //             ),
              //             Text(
              //               'Skip',
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 12.sp,
              //                 fontFamily: 'Urbanist',
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             QueueBtn(context);
              //           },
              //           child: Column(
              //             children: [
              //               SvgPicture.asset("assets/icons/queue.svg"),
              //               const SizedBox(
              //                 height: 3,
              //               ),
              //               const Text(
              //                 'Queue',
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 12,
              //                   fontFamily: 'Urbanist',
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   bottom: 70,
              //   child: Column(
              //     children: [
              //       ...buildPlayControl(),
              //     ],
              //   ),
              // ),
              //
              //
              // FutureBuilder<List<int>>(
              //   future: EqualizerFlutter.getBandLevelRange(),
              //   builder: (context, snapshot) {
              //     return snapshot.connectionState == ConnectionState.done
              //         ? CustomEQ(true, snapshot.data!)
              //         : const CircularProgressIndicator();
              //   },
              // ),
              //
              ,
              Positioned(
                  // top: 0,
                  // top: 0.35.sh,
                  top: 0,
                  bottom: .02.sh,
                  left: 0,
                  right: 0,
                  // bottom: 0,
                  // left: 0,
                  // right: 0,
                  // alignment: Alignment.center,
                  child: Obx(
                    () => controller.isCloseSong.value
                        ? const SizedBox()
                        : Center(child: buildReaderWidget()),
                  )),

              Positioned(
                  top: .12.sh,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => controller.showSkipIntro.value
                        ? Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            // width: .8.sw,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.withOpacity(.2),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/skipintro.png',
                                  scale: 2,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Skipping Intro',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  )),
              //
            ],
          ),
        ),
      ),
    );
  }

  // var playing = false;

  Stack buildReaderWidget() {
    final controller = Get.find<SongController>();
    return Stack(
      children: [
        Obx(
          () => controller.lyricsInitilazied.value
              ? LyricsReader(
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  model: controller.lyricModel.getModel(),
                  position: controller.playProgress.value,
                  lyricUi: controller.lyricUI,
                  playing: controller.playing.value,
                  size: Size(double.infinity, .35.sh),
                  emptyBuilder: () => Center(
                    child: Text(
                      "No lyrics",
                      style: controller.lyricUI.getOtherMainTextStyle(),
                    ),
                  ),
                  // selectLineBuilder: (progress, confirm) {
                  //   return Row(
                  //     children: [
                  //       IconButton(
                  //           onPressed: () {
                  //             LyricsLog.logD("Line Builder Chal Rha HAi");
                  //             confirm.call();
                  //             // setState(() {
                  //             controller.audioPlayer
                  //                 ?.seek(Duration(milliseconds: progress));
                  //             // });
                  //           },
                  //           icon: const Icon(Icons.play_arrow,
                  //               color: Colors.green)),
                  //       Expanded(
                  //         child: Container(
                  //           decoration:
                  //               const BoxDecoration(color: Colors.green),
                  //           height: 1,
                  //           width: double.infinity,
                  //         ),
                  //       ),
                  //       Text(
                  //         progress.toString(),
                  //         style: const TextStyle(color: Colors.green),
                  //       )
                  //     ],
                  //   );

                  // },
                )
              : const SizedBox(),
        )
      ],
    );
  }

  Future<dynamic> ToneBtn(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppColor.darkColor,
      context: context,
      builder: (BuildContext context) {
        final controller = Get.find<SongController>();
        return Container(
          width: double.infinity,
          height: 190.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColor.darkColor,
            // shape: RoundedRectangleBorder(
            //   side: BorderSide(width: 1.w, color: const Color(0xFF2A2B39)),
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(18),
            //     topRight: Radius.circular(18),
            //   ),
            // ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomDragHandle(),
                // const SizedBox(
                //   height: 5,
                // ),
                // Center(
                //   child: Container(
                //     height: 5,
                //     width: 100,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(90),
                //       color: AppColor.secondaryTextColor,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Tone',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    width: double.infinity,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFF2A2B39),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        const Text(
                          'Change Music Key',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () {
                                    controller.decreasePitch();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/subsctract.svg")),
                              Obx(
                                () => Text(
                                  (controller.pitch.value * 10)
                                      .round()
                                      .toStringAsFixed(0),
                                  // .floorToDouble()
                                  // .toStringAsFixed(0),
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    controller.increasePitch();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/addition.svg")),
                            ],
                          ),
                        )
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Text(
                          'Tempo',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // SvgPicture.asset("assets/icons/subsctract.svg"),
                              InkWell(
                                  onTap: () {
                                    controller.decreaseTone();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/subsctract.svg")),
                              Obx(
                                () => Text(
                                  (controller.currrentTone.value * 10)
                                      .round()
                                      // .floorToDouble()
                                      .toStringAsFixed(0),
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              // SvgPicture.asset("assets/icons/addition.svg"),
                              InkWell(
                                  onTap: () {
                                    controller.increaseTone();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/addition.svg")),
                            ],
                          ),
                        )
                      ],
                    )),
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
        side: BorderSide(width: 1.w, color: AppColor.darkColor),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  List<Widget> buildPlayControl() {
    final controller = Get.find<SongController>();
    return [
      Container(
        height: 20,
      ),
    ];
  }
}

Future<dynamic> QueueBtn(BuildContext context, String songId) {
  final contoller = Get.find<SongController>();
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   GetQueListBloc().getQueList(
      //       context: context,
      //       songId: songId,
      //       setProgressBar: () {
      //         AppDialogs.progressAlertDialog(context: context);
      //       });
      // });
      return Container(
        width: double.infinity,
        height: 300.h,
        decoration: ShapeDecoration(
          color: AppColor.darkColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color: AppColor.darkColor,
            ),
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
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Queue',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              // MusicPlayList(
              //     name: 'Starboy',
              //     popular: 'Dance .ED music',
              //     songImage: 'assets/images/starboy.png',
              //     topNumber: 2,

              Obx(
                () => contoller.playlistModel.value != null
                    ? Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              final song =
                                  contoller.playlistModel.value?.songs![index];

                              return contoller.songData.value?.songId ==
                                      song?.songId
                                  ? const SizedBox()
                                  : MusicPlayList(
                                      genre:
                                          contoller.songData.value?.genre ?? '',
                                      hideRank: true,
                                      buttonText: ' Play',
                                      onPressed: () {
                                        if (song != null) {
                                          Get.back();

                                          // contoller.playlistModel.value?.songs!
                                          //     .remove(song);

                                          contoller.refreshController(
                                              Get.context!, song, index);
                                        } else {
                                          AppDialogs.showToast(
                                              message: 'Song Not Found');
                                        }
                                      },
                                      popular: song?.artistName ?? '',
                                      name: song?.name ?? '',
                                      songImage: song?.imageFile ?? '',
                                      topNumber: song?.rank ?? 0,
                                    );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount:
                                contoller.playlistModel.value?.songs?.length ??
                                    0),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    },
    useSafeArea: false,
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1.w, color: AppColor.darkColor),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
      ),
    ),
  );
}

Future<dynamic> Equilizer(BuildContext context) {
  bool enableCustomEQ = false;

  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, innerState) {
        final controller = Get.find<SongController>();

        return Container(
          width: double.infinity,
          height: .7.sh,
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Equilizer',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Obx(
                      () => CupertinoSwitch(
                          value: controller.equilizerEnabled.value,
                          onChanged: (v) async {
                            controller.equilizerEnabled.value = v;
                            if (v) {
                              try {
                                await EqualizerFlutter.open(1);
                              } catch (e) {
                                log("EQ Execption $e");
                              }
                            } else {
                              await EqualizerFlutter.release();
                            }
                          }),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder<List<int>>(
                  future: EqualizerFlutter.getBandLevelRange(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? CustomEQ(enableCustomEQ, snapshot.data!)
                        : const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        );
      });
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

class EqualizerBottomSheet extends StatelessWidget {
  const EqualizerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SongController>();
    return Container(
      height: .42.sh,
      width: 1.sw,
      decoration: const BoxDecoration(
          color: AppColor.darkColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomDragHandle(),
            // const SizedBox(
            //   height: 10,
            // ),
            // Center(
            //   child: Container(
            //     height: 5,
            //     width: 100,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(90),
            //       color: AppColor.secondaryTextColor,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20.h,
            ),
            Center(child: MyText.headingText('Equalizer')),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: MyText.headingText('Mic', height: .5, fontSize: 15.sp),
            ),
            Transform.scale(
              scale: .9,
              child: Slider(
                  // activeColor: AppColor.whiteColor,
                  inactiveColor: AppColor.whiteColor.withOpacity(.5),
                  min: 0,
                  max: 1.0,
                  value: controller.mic.value,
                  onChanged: (v) {
                    controller.mic.value = v;
                  }),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: MyText.headingText('Music', height: .5, fontSize: 14.sp),
            ),
            Transform.scale(
              scale: .9,
              child: Slider(
                  min: 0.0,
                  max: 1.0,
                  inactiveColor: AppColor.whiteColor.withOpacity(.5),
                  value: controller.musicVolume.value,
                  onChanged: (v) {
                    controller.changeMusicVolumne(v);
                  }),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: MyText.headingText('Echo', height: .5, fontSize: 14.sp),
            ),
            Transform.scale(
              scale: .9,
              child: Slider(
                  min: 0,
                  max: 1.0,
                  value: controller.echo.value,
                  inactiveColor: AppColor.whiteColor.withOpacity(.5),
                  onChanged: (v) {
                    controller.echo.value = v;
                  }),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }
}

// User
//  Obx(
//                                   () => InkWell(
//                                       onTap: () async {
//                                         if (controller.playing.value) {
//                                           await controller.pauseSong();
//                                           await controller.audioRecordService
//                                               .pauseRecording();

//                                           log("Pause SOng m Chala gyaa");
//                                         } else {
//                                           log("Pause SOng m Chala gyaa");
//                                           if (controller.musicFile.value !=
//                                               null) {
//                                             if (controller.audioPlayer ==
//                                                 null) {
//                                               log("Play SOng m Chala gyaa");

//                                               controller.audioPlayer =
//                                                   AudioPlayer();

//                                               await controller.audioPlayer
//                                                   ?.setFilePath(controller
//                                                       .musicFile.value!.path);

//                                               await controller.audioPlayer
//                                                   ?.play();

//                                               // ..play(DeviceFileSource(
//                                               //     controller.musicFile
//                                               //         .value!.path));

//                                               await controller
//                                                   .audioRecordService
//                                                   .startAudioRecording();

//                                               // controller.startListening();
//                                               // setState(() {
//                                               playing = true;
//                                               // });
//                                               controller.audioPlayer
//                                                   ?.onDurationChanged
//                                                   .listen((Duration event) {
//                                                 // setState(() {
//                                                 controller.maxValue.value =
//                                                     event.inMilliseconds
//                                                         .toDouble();
//                                                 // });
//                                               });
//                                               controller.audioPlayer
//                                                   ?.onPositionChanged
//                                                   .listen((Duration event) {
//                                                 if (controller.isTap.value)
//                                                   return;
//                                                 // setState(() {
//                                                 controller
//                                                         .sliderProgress.value =
//                                                     event.inMilliseconds
//                                                         .toDouble();
//                                                 controller.playProgress.value =
//                                                     event.inMilliseconds;
//                                                 // });
//                                               });

//                                               controller.audioPlayer
//                                                   ?.onPlayerStateChanged
//                                                   .listen((PlayerState
//                                                       state) async {
//                                                 // setState(() {
//                                                 controller.playing.value =
//                                                     state ==
//                                                         PlayerState.playing;
//                                                 if (state ==
//                                                     PlayerState.completed) {
//                                                   final path = await controller
//                                                       .audioRecordService
//                                                       .stopAudioAndSaveFile();
//                                                   // await controller
//                                                   //     .stopListening();

//                                                   log("Audio path FIle Of Recoding $path");
//                                                   // Get.off(() => SoundPlayerScreen(
//                                                   //       fileUrl: controller
//                                                   //           .getSongModel
//                                                   //           .value!
//                                                   //           .lyricsTxt!,
//                                                   //       audioPath: path!,
//                                                   //       songID: controller
//                                                   //           .getSongModel
//                                                   //           .value!
//                                                   //           .songId!,
//                                                   //       file: controller
//                                                   //           .specchFile.value,
//                                                   //     ));

//                                                   // ignore: use_build_context_synchronously
//                                                   UploadSong()
//                                                       .uploadSongForResult(
//                                                           playListData:
//                                                               controller
//                                                                   .playlistModel
//                                                                   .value,
//                                                           singleSong: Get
//                                                                       .arguments?[
//                                                                   'singleSong'] ??
//                                                               false,
//                                                           context: context,
//                                                           setProgressBar: () {
//                                                             AppDialogs
//                                                                 .progressAlertDialog(
//                                                                     context:
//                                                                         context,
//                                                                     loadingText:
//                                                                         'We are generating your score \nPlease wait...');
//                                                           },
//                                                           songID: controller
//                                                               .songData
//                                                               .value!
//                                                               .songId!,
//                                                           songPath: path!,
//                                                           fileUrl: controller
//                                                               .songData
//                                                               .value!
//                                                               .lyricsTxt!);

//                                                   // AppDialogs.showToast(
//                                                   //     message:
//                                                   //         "Recoding Success");
//                                                 }
//                                                 // });
//                                               });
//                                             } else {
//                                               controller.audioPlayer?.resume();
//                                               await controller
//                                                   .audioRecordService
//                                                   .resumeRecoding();
//                                             }
//                                           }
//                                         }
//                                       },
//                                       child: Container(
//                                         width: 60,
//                                         height: 60,
//                                         // padding: const EdgeInsets.all(12),
//                                         decoration: ShapeDecoration(
//                                           color: const Color(0xFFF6AD00),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(42),
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Icon(
//                                             controller.playing.value
//                                                 ? Icons.pause
//                                                 : Icons.play_arrow,
//                                             color: AppColor.darkBackgroundColor,
//                                             size: 40,
//                                           ),
//                                         ),
//                                       )

//                                       //  isPlaying ? Icons.pause_circle : Icons.play_circle,
//                                       // SvgPicture.asset(
//                                       //     "assets/icons/play_icon.svg")),
//                                       ),
//                                 ),
