// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:yelody_app/blocs/playlist/create_playlist_bloc.dart';
import 'package:yelody_app/blocs/playlist/postSong_palylist_block.dart';
import 'package:yelody_app/models/charts/chart_list_res.dart';
import 'package:yelody_app/models/charts/getchartSongsbyid_model.dart';
import 'package:yelody_app/models/charts/getchartbyid_model.dart';
import 'package:yelody_app/models/playlist/getall_playlist_model.dart';
import 'package:yelody_app/models/playlist/getplaylist_byuserid_model.dart';
import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';
import 'package:yelody_app/models/songs/getRecommanded_song_model.dart';
import 'package:yelody_app/models/songs/song_model.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/app_navigation.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/data/banner_model.dart';

class CountryModel {
  final String country;
  final String flag;

  CountryModel({required this.country, required this.flag});

  @override
  bool operator ==(covariant CountryModel other) {
    if (identical(this, other)) return true;

    return other.country == country && other.flag == flag;
  }

  @override
  int get hashCode => country.hashCode ^ flag.hashCode;
}

class HomeController extends GetxController {
  Rxn<BannerModel> homeBanners = Rxn(null);
  Rxn<ChartsList> charts = Rxn(null);
  RxString selectedChartID = "".obs;
  Rxn<GetChartByIdModel> chartsById = Rxn(null);
  Rxn<GetChartSongByIdModel> chartsSongsById = Rxn(null);
  Rxn<GetRecommandedSongByuserIdModel> getRecommandedSong = Rxn(null);
  Rxn<GetAllPlaylistModel> getAllplaylist = Rxn(null);
  Rxn<GetSongByPlaylistIdModel> getSongbyPlaylistId = Rxn(null);
  RxInt bannerPosition = 0.obs;
  RxInt chartIndex = 0.obs;
  Rxn<File> playListImagePciked = Rxn(null);
  RxInt currentSelectedTabIndex = 0.obs;

  RxString currentLyrics = "".obs;

  RxBool iSearching = false.obs;
  RxBool iSearchingInsidePlayList = false.obs;

  Rxn<PlayListData> selectedPlayList = Rxn(null);
  RxBool editingPlayList = false.obs;

  RxString currentSelectedCountry = "UK".obs;
  Rxn<CountryModel> currentSelectedCountryDropdown = Rxn(null);
  // Rxn<DropdownMenuItem<dynamic>> selectedDropDown = Rxn();

  TextEditingController nameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchSongsController = TextEditingController();
  TextEditingController searchControllerPlayList = TextEditingController();
  TextEditingController searchControllerInsideAllPlayList =
      TextEditingController();

  Rxn<SongsList> songs = Rxn(null);

  RxList<SongData> editedSelected = <SongData>[].obs;

  ///Not Implemented
  Rxn<SongsList> recomendedSongs = Rxn(null);

  @override
  void onInit() {
    // selectedDropDown.value = dropdow÷nItems.first;
    print("HOME ONREADY");
    currentSelectedCountryDropdown.value = allCountryes.first;
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        iSearching.value = true;
      } else {
        iSearching.value = false;
      }
    });

    searchControllerPlayList.addListener(() {
      if (searchControllerPlayList.text.isNotEmpty) {
        iSearchingInsidePlayList.value = true;
      } else {
        iSearchingInsidePlayList.value = false;
      }
    });

    super.onInit();
  }

  Rxn<GetPlaylistByUserId> recomdendedPlayList = Rxn(null);

  final List<String> countryNames = ['IN', 'UK', 'CA', 'UA', 'US'];

  List<CountryModel> allCountryes = [
    CountryModel(country: 'IN', flag: 'assets/icons/new_flag.png'),
    CountryModel(country: 'CA', flag: 'assets/icons/ca_flag.png'),
    CountryModel(country: 'UK', flag: 'assets/images/uk_flag.png'),
    CountryModel(country: 'US', flag: 'assets/images/us_flag.png'),
    CountryModel(country: 'UAE', flag: 'assets/images/uae.png'),
  ];

  // List<DropdownMenuItem<String>> dropdownItems = [
  //   DropdownMenuItem<String>(
  //     value: 'IN',
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             // Icon(Icons.star, color: Colors.yellow),
  //             Image.asset("assets/icons/new_flag.png"),
  //             const SizedBox(width: 8),
  //             const Text('IN'),
  //           ],
  //         ),
  //         Divider(),
  //       ],
  //     ),
  //   ),
  //   DropdownMenuItem<String>(
  //     value: 'CA',
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Image.asset("assets/icons/ca_flag.png"),
  //             const SizedBox(width: 8),
  //             const Text('CA'),
  //           ],
  //         ),
  //         Divider(),
  //       ],
  //     ),
  //   ),
  //   DropdownMenuItem<String>(
  //     value: 'UK',
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             // Icon(Icons.shopping_cart, color: Colors.green),
  //             Image.asset("assets/images/uk_flag.png"),
  //             const SizedBox(width: 8),
  //             const Text('UK'),
  //           ],
  //         ),
  //         Divider(),
  //       ],
  //     ),
  //   ),
  //   DropdownMenuItem<String>(
  //     value: 'US',
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             // Icon(Icons.shopping_cart, color: Colors.green),
  //             Image.asset(
  //               "assets/images/us_flag.png",
  //               scale: 3,
  //             ),
  //             const SizedBox(width: 8),
  //             const Text('US'),
  //           ],
  //         ),
  //         Divider(),
  //       ],
  //     ),
  //   ),
  //   DropdownMenuItem<String>(
  //     value: 'UAE',
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             // Icon(Icons.shopping_cart, color: Colors.green),
  //             Image.asset(
  //               "assets/images/uae.png",
  //               scale: 2,
  //             ),
  //             const SizedBox(width: 8),
  //             const Text('UAE'),
  //           ],
  //         ),
  //         Divider(),
  //       ],
  //     ),
  //   ),
  // ];

  //getuserplaylistbyuserid
  Rxn<GetPlaylistByUserId> getUserplaylist = Rxn(null);
  //getuserplaylistbyuserid+ search
  RxList<PlayListData> filteredPlaylists = <PlayListData>[].obs;

  void filterPlaylists(String searchText) {
    if (searchText.isEmpty) {
      filteredPlaylists.assignAll(getUserplaylist.value?.data ?? []);
    } else {
      filteredPlaylists.assignAll(getUserplaylist.value?.data
              ?.where((playlist) =>
                  playlist.name
                      ?.toLowerCase()
                      .contains(searchText.toLowerCase()) ??
                  false)
              .toList() ??
          []);
    }
  }

  RxList<PlayListData> filteredPlaylistsInsideAllPlayList =
      <PlayListData>[].obs;

  RxBool searchingInsideList = false.obs;
  void filterInsidePlayList() {
    searchControllerInsideAllPlayList.addListener(() {
      if (searchControllerInsideAllPlayList.text.isNotEmpty) {
        iSearchingInsidePlayList.value = true;
        filteredPlaylistsInsideAllPlayList.assignAll(getUserplaylist.value?.data
                ?.where((playlist) =>
                    playlist.name?.toLowerCase().contains(
                        searchControllerInsideAllPlayList.text.toLowerCase()) ??
                    false)
                .toList() ??
            []);
      } else {
        iSearchingInsidePlayList.value = false;
        filteredPlaylistsInsideAllPlayList.value = [];
      }

      print(
          "Search Results ${searchControllerInsideAllPlayList.text.toString()}");
      print("Search Results ${filteredPlaylistsInsideAllPlayList.length}");
      print("Search Results ${iSearchingInsidePlayList.value}");
    });
  }

  RxBool searchInBottomSheet = false.obs;

  RxList<SongData> filteredSongs = <SongData>[].obs;
  void filterSongs() {
    searchSongsController.addListener(() {
      if (searchSongsController.text.isEmpty) {
        filteredSongs.assignAll(songs.value?.data ?? []);
        searchInBottomSheet.value = false;
      } else {
        filteredSongs.assignAll(songs.value?.data
                ?.where((songsListItem) =>
                    (songsListItem.name?.toLowerCase().contains(
                            searchSongsController.text.toLowerCase()) ??
                        false) ||
                    (songsListItem.artistName?.toLowerCase().contains(
                            searchSongsController.text.toLowerCase()) ??
                        false))
                .toList() ??
            []);

        searchInBottomSheet.value = true;
      }
    });
  }

  RxList<SongData> filteredPlayListSongs = <SongData>[].obs;
  void filterPlayListSongs(String searchText) {
    if (searchText.isEmpty) {
      if (getSongbyPlaylistId.value?.data != null &&
          getSongbyPlaylistId.value!.data!.songs!.isNotEmpty) {
        filteredPlayListSongs
            .assignAll(getSongbyPlaylistId.value!.data!.songs!);
      }
    } else {
      if (getSongbyPlaylistId.value?.data != null &&
          getSongbyPlaylistId.value!.data!.songs!.isNotEmpty) {
        filteredPlayListSongs.assignAll(getSongbyPlaylistId.value?.data!.songs
                ?.where((songsListItem) =>
                    songsListItem.name
                        ?.toLowerCase()
                        .contains(searchText.toLowerCase()) ??
                    false)
                .toList() ??
            []);
      }
    }
  }

  createNewPlayList(BuildContext context, Function()? onSuccess) {
    if (nameController.text.length > 5) {
      AppNavigation.navigatorPop(context);
      CreatePlayListBloc().createPlayListMethod(
          context: Get.context!,
          onSuccess: onSuccess,
          name: nameController.text,
          image: playListImagePciked.value,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: Get.context!);
          });
    } else {
      AppDialogs.showToast(message: 'Name must greater than 5 characters');
    }
  }

  ///Sort Songs
  ///
  void sortSongsByRanking({int index = 0}) {
    print("SORTINNG");
    charts.value?.data?[index].songs
        ?.sort((a, b) => a.rank!.compareTo(b.rank!));
  }

// postSongInPlaylist(BuildContext context) {

//         PostSongPlaylistBloc().createPostSongPlaylistMethod(
//             context: Get.context!,
//             songId: ,
//          playlistId: ,
//             setProgressBar: () {
//               AppDialogs.progressAlertDialog(context: Get.context!);
//             });

//     }
//   }
}
