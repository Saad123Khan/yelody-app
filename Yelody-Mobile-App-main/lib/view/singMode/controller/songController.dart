import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lyric/lyric_ui/ui_netease.dart';
import 'package:flutter_lyric/lyrics_model_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xml2json/xml2json.dart';
import 'package:yelody_app/blocs/song/load_song_bloc.dart';
import 'package:yelody_app/models/songs/song_model.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/services/audio_service.dart';
import 'package:yelody_app/services/method_channel_ios.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/view/singMode/custom_json_lyrics.dart';
import 'package:yelody_app/view/singMode/data/get_song_model.dart';
import 'package:yelody_app/view/singMode/data/song_que_list.dart';

import '../../../models/playlist/getsongs_byplaylistid_model.dart';

class SongController extends GetxController {
  AudioPlayer? audioPlayer;
  RxBool isCloseSong = false.obs;
  RxBool showSkipIntro = false.obs;

  Rxn<SongData> songData = Rxn(null);
  late bool singleSong;
  RxDouble sliderProgress = 0.0.obs;
  RxInt playProgress = 0002.obs;
  RxInt skipCounter = 0.obs;
  RxDouble maxValue = 11111.0.obs;
  RxBool isTap = false.obs;
  Rxn<CustomKroakeModel?> karaokeModel = Rxn<CustomKroakeModel?>(null);
  AudioRecordService audioRecordService = AudioRecordService();

  RxBool playing = false.obs;
  RxBool equilizerEnabled = false.obs;
  RxDouble mic = 0.5.obs;
  RxDouble music = 0.5.obs;
  RxDouble echo = 0.5.obs;
  RxDouble pitch = 1.00.obs;
  // RxBool playing
  RxBool lyricsInitilazied = false.obs;
  Rxn<SongQueList> songQueList = Rxn(null);

  ///Lyrics Builder
  var lyricModel = LyricsModelBuilder.create();
  var lyricUI = UINetease(
      defaultExtSize: 14.sp, otherMainSize: 14.sp, bias: .2, lineGap: 14);
  RxString xmlLyrics = "".obs;
  refreshController(BuildContext context, SongData song, int index) async {
    currentSongIndex.value = index;
    xmlLyrics.value = "";
    playing.value = false;
    karaokeModel.value = null;
    songData.value = song;
    sliderProgress.value = 0.0;
    lyricsInitilazied.value = false;
    playProgress.value = 0002;
    maxValue.value = 11111;
    await audioPlayer?.stop();
    skipCounter.value = 0;
    audioPlayer = null;
    await audioRecordService.stopAudioAndSaveFile();
    loadSongByID(song.songId!, context, song.lyricsXml!);
  }

  @override
  void dispose() {
    audioRecordService.dispose();
    EqualizerFlutter.release();
    audioPlayer = null;
    super.dispose();
  }

  RxDouble echoEffect = 1.0.obs;

  setEcho(double newValue) {
    echoEffect.value = newValue;
  }

  reinit(
    SongData song,
  ) {
    final date = DateTime.now();
    Get.offNamed("${RouteName.singMode}/$date",
        arguments: {'songData': song, 'singleSong': true});
  }

  Rxn<File> musicFile = Rxn<File>(null);
  Uint8List? songsBytes;

  Rxn<GetSongModel> getSongModel = Rxn(null);

  loadSongByID(String songID, BuildContext context, String lyrcisFIle) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/Yelody/AudioCaches/files';

    Directory directory = Directory(path);

    if (await directory.exists()) {
      List<FileSystemEntity> files = directory.listSync();

      File? existingFile;

      for (var file in files) {
        log(file.path.toString());
        if (file is File && file.path.split('/').last == '$songID.mp3') {
          log("File Exisistes Krtaa Hai Cache m Api Call Nhii Honi Chhiye ${file.path}");
          existingFile = file;
          break;
        }
      }

      if (existingFile != null) {
        log('$existingFile exists in $directory.');

        musicFile.value = existingFile;

        // ignore: use_build_context_synchronously

        // ignore: use_build_context_synchronously
        LoadSongBloc().loadXMLData(context, () {
          AppDialogs.progressAlertDialog(
              context: context,
              loadingText: 'Preparing Lyrics \n Please wait...');
        }, lyrcisFIle);

        // Now you can use 'existingFile' as a reference to the file.
        // For example, you can read its contents: existingFile.readAsStringSync()
      } else {
        log('$existingFile does not exist in $directory.');

        log("File Exisistes NHII Krataa Hai Cache m Api Call Honi Chhiye");

        // ignore: use_build_context_synchronously
        LoadSongBloc().loadSongByID(
            songID: songID,
            lyricsId: lyrcisFIle,
            context: context,
            setProgressBar: () {
              AppDialogs.progressAlertDialog(
                  context: context,
                  loadingText: 'Downloading Song \nPlease wait...');
            });
      }
    } else {
      // ignore: use_build_context_synchronously

      log("Directory Exisistes NHII Krataa Hai Cache m Api Call Honi Chhiye");

      print('directory${directory.path}');

      // ignore: use_build_context_synchronously
      LoadSongBloc().loadSongByID(
          songID: songID,
          lyricsId: lyrcisFIle,
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(
                context: context,
                loadingText: 'Downloading Song \nPlease wait...');
          });
    }
  }

  RxInt currentSongIndex = 0.obs;
  Rxn<PlayListData> playlistModel = Rxn(null);

  @override
  void onInit() {
    if (Get.arguments?['playList'] != null) {
      playlistModel.value = Get.arguments['playList'];

      if (Get.arguments?['currentIndex'] != null) {
        int index = Get.arguments['currentIndex'];
        songData.value = playlistModel.value?.songs?[index];
        currentSongIndex.value = index;
      } else {
        songData.value = playlistModel.value?.songs?.first;
        currentSongIndex.value = 0;
      }
    } else {
      songData.value = Get.arguments?['songData'];
    }

    audioRecordService.init();

    // initizalizeSpeechToText();
    super.onInit();
  }

  RxBool initizalizedSpeech = false.obs;

  prepareLyrics() {
    log("Preparing Lyrics Now");
    final json = xmlToJSONConverter(xmlLyrics.value);

    print("Json Json$json");

    karaokeModel.value = CustomKroakeModel.fromJson(jsonDecode(json));

    log("Karoaro Mdoe ${karaokeModel.value!.karaoke.ltaginfo.cTitle1}");
    lyricModel.bindLyricToMain(
      karaokeModel.value!.generateLyricFile(),
    );
    log("Lyrics Ban gaee ");
  }

  ////Converts the  XML Data to JSON
  String xmlToJSONConverter(String xml) {
    final myTransformer = Xml2Json();
    myTransformer.parse(xmlLyrics.value);
    var json = myTransformer.toParker();
    return json;
  }

  ///SongMethods
  Future<void> pauseSong() async {
    return await audioPlayer?.pause();
  }

  Future<void> skipIntro() async {
    //  if(lyricModel)kar
    print(
        "KaroKe Lines ${karaokeModel.value?.karaoke.stag.record.first.lTimeSyncStart}");

    if (audioPlayer != null && audioPlayer!.playing) {
      if (karaokeModel.value != null) {
        int threeSecondsBefore = int.parse(
                karaokeModel.value!.karaoke.stag.record.first.lTimeSyncStart) -
            3000;

        if (playProgress.value < threeSecondsBefore) {
          Future.delayed(const Duration(seconds: 2));
          playProgress.value = threeSecondsBefore;
          audioPlayer?.seek(Duration(milliseconds: playProgress.value.toInt()));
          showSkipIntro.value = true;
          Future.delayed(const Duration(seconds: 2), () {
            showSkipIntro.value = false;
          });
        } else {
          print("Intro Already Skipped");
        }
      }
    }

    // controller.playProgress.value +=
    //                                     3000
  }

  Rxn<File> specchFile = Rxn(null);

  Future<void> saveToFile(String text) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/speech_output${DateTime.now}.txt');
    await file.writeAsString(text);
    specchFile.value = file;
    print("File Saved Successfully at : ${file.path}");
  }

  RxDouble currrentTone = 1.0.obs;
  // RxDouble currentPitch = 1.0.obs;
  increaseTone() {
    if (currrentTone < 1.5) {
      currrentTone.value = currrentTone.value + .1;
      audioPlayer?.setSpeed(currrentTone.value);
      // audioPlayer?.setPlaybackRate(currrentTone.value);
    }
  }

  decreaseTone() {
    if (currrentTone > 0.2) {
      currrentTone.value = currrentTone.value - .1;
      audioPlayer?.setSpeed(currrentTone.value);

      // audioPlayer?.setPlaybackRate(currrentTone.value);
    }
  }

  increasePitch() {
    if (pitch < 1.5) {
      pitch.value = pitch.value + .1;
      // audioPlayer.
      // if (Platform.isIOS) {
      //   audioPlayer?.setPreferredPeakBitRate(pitch.value);
      //   // audioPlayer.
      // } else {
      //   audioPlayer?.setPitch(pitch.value);
      // }

      if (Platform.isAndroid) {
        audioPlayer?.setPitch(pitch.value);
      } else {
        NativeMethodChannelService.setPitch(pitch.value);
      }

      // if (Platform.isIOS) {
      //   print('Setting Native Pitch TO ${pitch.value}');
      //   NativeMethodChannelService.setPitch(
      //     pitch.value,

      //   );
      // } else {
      //   print("Pitch " + pitch.value.toString());
      //   audioPlayer?.setPitch(pitch.value);
      // }

      // audioPlayer?.setPlaybackRate(currrentTone.value);
    }
  }

  decreasePitch() {
    if (pitch > 0.2) {
      pitch.value = pitch.value - .1;

      // if (Platform.isIOS) {
      //   audioPlayer?.setPreferredPeakBitRate(pitch.value);
      // } else {
      //   audioPlayer?.setPitch(pitch.value);
      // }

      if (Platform.isAndroid) {
        audioPlayer?.setPitch(pitch.value);
      } else {
        NativeMethodChannelService.setPitch(pitch.value);
      }
      // if (Platform.isIOS) {
      //   print('Setting Native Pitch TO ${pitch.value}');
      //   NativeMethodChannelService.setPitch(pitch.value);
      // } else {
      //   audioPlayer?.setPitch(pitch.value);
      // }

      // audioPlayer?.setPlaybackRate(currrentTone.value);
    }
  }

  ///Set Global Music Voumne
  RxDouble musicVolume = 1.0.obs;
  changeMusicVolumne(double music) {
    musicVolume.value = music;
    audioPlayer?.setVolume(musicVolume.value);
  }

  chnageEcho(double music) {
    musicVolume.value = music;
  }
}
