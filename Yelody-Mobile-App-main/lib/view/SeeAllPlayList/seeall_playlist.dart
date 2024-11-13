import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/custom_searchtextfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:yelody_app/res/components/customalert_singing.dart';

import 'package:yelody_app/res/components/my_playlist.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/view/FeatureClickedScreen/widgets/musicplay_class.dart';
import 'package:yelody_app/view/SeeAllPlayList/bilboardlist.dart';

class SeeAllPlayScreen extends StatefulWidget {
  const SeeAllPlayScreen({super.key});

  @override
  State<SeeAllPlayScreen> createState() => _SeeAllPlayScreenState();
}

class _SeeAllPlayScreenState extends State<SeeAllPlayScreen> {
  List<MusicPlaylist> playlists = [
    MusicPlaylist(
        name: 'Christmas List',
        popular: '76 Songs',
        songImage: "assets/images/cristmis_avatar.png",
        topNumber: 2),
    MusicPlaylist(
        name: 'Chillin List',
        popular: '36 Songs',
        songImage: "assets/images/chillin_avatar.png",
        topNumber: 1),
    MusicPlaylist(
        name: 'It’s party time!',
        popular: '124 Songs',
        songImage: "assets/images/partytime_avatar.png",
        topNumber: 3),
    MusicPlaylist(
      name: 'Dance playlists',
      popular: '76 Songs',
      songImage: "assets/images/dance_avatar.png",
      topNumber: 1,
    ),
    MusicPlaylist(
        name: 'Romantic playlist ',
        popular: '36 Songs',
        songImage: "assets/images/romentic_avatar.png",
        topNumber: 1),
    MusicPlaylist(
        name: 'Mc the Max Best',
        popular: '124 Songs',
        songImage: "assets/images/max_avatar.png",
        topNumber: 1),
    MusicPlaylist(
        name: 'Christmas List',
        popular: '76 Songs',
        songImage: "assets/images/cristmis_avatar.png",
        topNumber: 2),
    MusicPlaylist(
        name: 'Chillin List',
        popular: '36 Songs',
        songImage: "assets/images/chillin_avatar.png",
        topNumber: 1),
    MusicPlaylist(
        name: 'It’s party time!',
        popular: '124 Songs',
        songImage: "assets/images/partytime_avatar.png",
        topNumber: 3),
    MusicPlaylist(
      name: 'Dance playlists',
      popular: '76 Songs',
      songImage: "assets/images/dance_avatar.png",
      topNumber: 1,
    ),
    MusicPlaylist(
        name: 'Romantic playlist ',
        popular: '36 Songs',
        songImage: "assets/images/romentic_avatar.png",
        topNumber: 1),
    MusicPlaylist(
        name: 'Mc the Max Best',
        popular: '124 Songs',
        songImage: "assets/images/max_avatar.png",
        topNumber: 1)
  ];

  final List<String> items = [
    'All Playlists',
    'Christmas playlist',
    'party playlist',
  ];
  String? selectedValue;

  final List<String> countryNAames = [
    'IN',
    'UK',
    'CA',
    'UA',
  ];
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.darkBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.darkBackgroundColor,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          title: Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  // isExpanded: true,

                  hint: Text(
                    'John deo\'s favs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child:

                                // Column(
                                //   children: [
                                Text(
                              item,
                              style: TextStyle(
                                color: Color(0xFFF9F9F9),
                                fontSize: 14.sp,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },

                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      // Icons.arrow_downward,
                      Icons.arrow_drop_down,
                    ),
                    iconSize: 30,
                    // iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                  ),

                  dropdownStyleData: DropdownStyleData(
                    // maxHeight: 200,
                    width: 200.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      color: Color(0xFF23252F),
                    ),
                  ),

                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            //  Icon(Icons.abc,
            //   color: Colors.red,)
            selectedValue != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              bottomSheet(context);
                            },
                            child:
                                // SvgPicture.asset("assets/icons/pen_icon.svg")
                                SvgPicture.asset("assets/icons/plusicon.svg")),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
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
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 56.h,
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFF3A3B43),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28),
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
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                    onpressed: () {
                                                      Navigator.pop(context);
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
                                      width: 1.w, color: Color(0xFF2A2B39)),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                  ),
                                ),
                              );
                            },
                            child: SvgPicture.asset("assets/icons/pen_icon.svg")

                            // Icon(
                            //   Icons.menu,
                            //   size: 18,
                            //   color: AppColor.primaryColor,
                            // ),
                            )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child:
                        SvgPicture.asset("assets/icons/appbar_filtericon.svg"),
                  )
          ],
        ),
        body: selectedValue != null
            ? selectedValue == 'All Playlists' ||
                    // selectedValue == 'John deo\'s favs' ||
                    selectedValue == 'Christmas playlist' ||
                    selectedValue == 'party playlist'
                ? Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomSearchTextField(hintText: "Search Playlist"),
                            SizedBox(
                              height: 22.h,
                            ),
                            Expanded(
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 15,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  final playlist = playlists[index];
                                  return MyPlayList(
                                    name: playlist.name,
                                    popular: playlist.popular,
                                    songImage: playlist.songImage,
                                    onPressed: () {
                                      Get.toNamed(
                                          RouteName.musicPlayDetailsScreen);
                                    },
                                  );
                                },
                                itemCount: playlists.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomAlertDialogSinging();
                                  },
                                );
                              },
                              child: Container(
                                height: 56.h,
                                decoration: ShapeDecoration(
                                  color: AppColor.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    SvgPicture.asset(
                                        "assets/icons/play_btn.svg"),
                                    Expanded(
                                      child: Text(
                                        'Start Singing Now',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF3A3B43),
                                          fontSize: 16.sp,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
                : Text("data")
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    const CustomSearchTextField(hintText: "Search Playlist"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'It\’s Empty!',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Color(0xFFF6AD00),
                              fontSize: 32.sp,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: 120.w,
                            height: 40.h,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: ShapeDecoration(
                              color:
                                  Colors.white.withOpacity(0.10000000149011612),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }

  Future<dynamic> bottomSheetArtist(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
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
                          child: SvgPicture.asset("assets/images/back.svg")),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Container(
                            // width: 115,
                            height: 38,
                            decoration: ShapeDecoration(
                              color:
                                  Colors.white.withOpacity(0.10000000149011612),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                // isExpanded: true,

                                hint: Text(
                                  'US',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                items: countryNAames
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child:

                                              // Column(
                                              //   children: [
                                              Row(
                                            children: [
                                              Image.asset(
                                                  "assets/images/uk_flag.png"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                item,
                                                style: TextStyle(
                                                  color: Color(0xFFF9F9F9),
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                value: selectedCountry,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                },

                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    // Icons.arrow_downward,
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 30,
                                  // iconEnabledColor: Colors.black,
                                  iconDisabledColor: Colors.grey,
                                ),

                                dropdownStyleData: DropdownStyleData(
                                  // maxHeight: 200,
                                  // width: 200.w,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(14),
                                      bottomRight: Radius.circular(14),
                                    ),
                                    color: Color(0xFF23252F),
                                  ),
                                ),

                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildContainer('Songs', 0, context),
                          SizedBox(
                            width: 10,
                          ),
                          buildContainer('Artists', 1, context),
                          SizedBox(
                            width: 10,
                          ),
                          buildContainer('All Songs', 2, context),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Image.asset("assets/images/notfound.png"),
                  Text(
                    'Song Not Found!',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color(0xFFF6AD00),
                      fontSize: 32,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Try searching again using different keyword.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6C6D76),
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetSong(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 600.h,
          decoration: ShapeDecoration(
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Container(
                            // width: 115,
                            height: 38,
                            decoration: ShapeDecoration(
                              color:
                                  Colors.white.withOpacity(0.10000000149011612),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                // isExpanded: true,

                                hint: Text(
                                  'US',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                items: countryNAames
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child:

                                              // Column(
                                              //   children: [
                                              Row(
                                            children: [
                                              Image.asset(
                                                  "assets/images/uk_flag.png"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                item,
                                                style: TextStyle(
                                                  color: Color(0xFFF9F9F9),
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                value: selectedCountry,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                },

                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    // Icons.arrow_downward,
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 30,
                                  // iconEnabledColor: Colors.black,
                                  iconDisabledColor: Colors.grey,
                                ),

                                dropdownStyleData: DropdownStyleData(
                                  // maxHeight: 200,
                                  // width: 200.w,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(14),
                                      bottomRight: Radius.circular(14),
                                    ),
                                    color: Color(0xFF23252F),
                                  ),
                                ),

                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildContainer('Songs', 0, context),
                          SizedBox(
                            width: 10,
                          ),
                          buildContainer('Artists', 1, context),
                          SizedBox(
                            width: 10,
                          ),
                          buildContainer('All Songs', 2, context),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BillboardList(
                      name: 'Shape of you',
                      popular: 'Funk . ED Sheeran',
                      songImage: 'assets/images/divide.png',
                      topNumber: 1),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Shape of you',
                      popular: 'Funk . ED Sheeran',
                      songImage: 'assets/images/divide.png',
                      topNumber: 1),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Shape of you',
                      popular: 'Funk . ED Sheeran',
                      songImage: 'assets/images/divide.png',
                      topNumber: 1),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetBillBoard(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 600.h,
          decoration: ShapeDecoration(
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
                        child: Text(
                          'Billboard #100',
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
                  BillboardList(
                      name: 'Shape of you',
                      popular: 'Funk . ED Sheeran',
                      songImage: 'assets/images/divide.png',
                      topNumber: 1),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Shape of you',
                      popular: 'Funk . ED Sheeran',
                      songImage: 'assets/images/divide.png',
                      topNumber: 1),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Shape of you',
                      popular: 'Funk . ED Sheeran',
                      songImage: 'assets/images/divide.png',
                      topNumber: 1),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetSearch(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 600.h,
          decoration: ShapeDecoration(
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
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomSearchTextField(
                    hintText: "Search songs",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Searches',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Clear All',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFF6AD00),
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xFF23252F),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  searchresult(
                    text: 'Ariana Grande',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  searchresult(
                    text: 'Morgan Wallen',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  searchresult(
                    text: 'Justin Bieber',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  searchresult(
                    text: 'Drake',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  searchresult(
                    text: 'Olivia Rodrigo',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetSongs(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 600.h,
          decoration: ShapeDecoration(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Songs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'X',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 20.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetAllSong(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 600.h,
          decoration: ShapeDecoration(
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
                        child: Text(
                          'All Songs ',
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
                  BillboardList(
                      name: 'Shape of you',
                      popular: 'Funk . ED Sheeran',
                      songImage: 'assets/images/divide.png',
                      topNumber: 1),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Shape of you',
                      popular: 'Funk . ED Sheeran',
                      songImage: 'assets/images/divide.png',
                      topNumber: 1),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Shape of you',
                      popular: 'Funk . ED Sheeran',
                      songImage: 'assets/images/divide.png',
                      topNumber: 1),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Starboy',
                      popular: 'Dance .ED music',
                      songImage: 'assets/images/starboy.png',
                      topNumber: 2),
                  SizedBox(height: 13.h),
                  BillboardList(
                      name: 'Positions',
                      popular: 'Pop .ED Ariana ',
                      songImage: 'assets/images/position.png',
                      topNumber: 3),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetArtists(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 600.h,
          decoration: ShapeDecoration(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Artist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'X',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 20.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search Song',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'X',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 20.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      bottomSheetSearch(context);
                    },
                    child: CustomSearchTextField(
                      hintText: "Search songs",
                    ),
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
                        Container(
                          // width: 115,
                          height: 38,
                          decoration: ShapeDecoration(
                            color:
                                Colors.white.withOpacity(0.10000000149011612),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              // isExpanded: true,

                              hint: Text(
                                'US',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              items: countryNAames
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child:

                                                // Column(
                                                //   children: [
                                                Row(
                                              children: [
                                                Image.asset(
                                                    "assets/images/uk_flag.png"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  item,
                                                  style: TextStyle(
                                                    color: Color(0xFFF9F9F9),
                                                    fontSize: 14.sp,
                                                    fontFamily: 'Urbanist',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                  .toList(),
                              value: selectedCountry,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              },

                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  // Icons.arrow_downward,
                                  Icons.arrow_drop_down,
                                ),
                                iconSize: 30,
                                // iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.grey,
                              ),

                              dropdownStyleData: DropdownStyleData(
                                // maxHeight: 200,
                                // width: 200.w,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(14),
                                    bottomRight: Radius.circular(14),
                                  ),
                                  color: Color(0xFF23252F),
                                ),
                              ),

                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        buildContainer('Songs', 0, context),
                        SizedBox(
                          width: 10,
                        ),
                        buildContainer('Artists', 1, context),
                        SizedBox(
                          width: 10,
                        ),
                        buildContainer('All Songs', 2, context),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            "assets/images/chartbanner1.png",
                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            //  "assets/images/chartbanner3.png",
                            "assets/images/chartbanner3.png",
                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            "assets/images/chartbanner2.png",
                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            "assets/images/Chart.png",
                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            // "assets/images/chartbanner4.png",
                            "assets/images/kpop.png",

                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            "assets/images/bilboardpurple.png",
                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            "assets/images/chartbanner4.png",
                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            "assets/images/chartbanner5.png",
                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            "assets/images/chartbanner1.png",
                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bottomSheetBillBoard(context);
                          },
                          child: Image.asset(
                            //  "assets/images/chartbanner3.png",
                            "assets/images/chartbanner3.png",
                            width: double.infinity,
                            height: 88.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        );
      },
      useSafeArea: false,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF2A2B39)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
    );
  }

  int selectedTabIndex = -1;

  Widget buildContainer(String text, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });

        // bottomSheet(context);
        // Open a new bottom sheArtistet based on the selected index
        switch (index) {
          case 0:
            // bottomSheetSongs(context);
            bottomSheetSong(context);
            break;
          case 1:
            // Add code to handle the second container tap
            bottomSheetArtist(context);

            break;
          case 2:
            // Add code to handle the third container tap
            bottomSheetAllSong(context);
            break;
          // Add more cases as needed
        }
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: ShapeDecoration(
          // color: selectedTabIndex == index ? Color(0xFFF6AD00) : Color(0xff313238),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(100),
          // ),

          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: selectedTabIndex == index
                  ? Color(0xFFF6AD00)
                  : Color(0xff313238),
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selectedTabIndex == index ? Color(0xFFF6AD00) : Colors.white,
            fontSize: 16,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class searchresult extends StatelessWidget {
  final String text;
  const searchresult({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          // 'Ariana Grande',
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'x',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

//  AllPlayList(playlists: playlists),
class AllPlayList extends StatelessWidget {
  const AllPlayList({
    super.key,
    required this.playlists,
  });

  final List<MusicPlaylist> playlists;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          CustomSearchTextField(hintText: "Search Playlist"),
          SizedBox(
            height: 22.h,
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return GestureDetector(
                  onTap: () {
                    // Get.toNamed(RouteName.featureClicked);
                  },
                  child: MyPlayList(
                    name: playlist.name,
                    popular: playlist.popular,
                    songImage: playlist.songImage,
                    onPressed: () {},
                  ),
                );
              },
              itemCount: playlists.length,
            ),
          ),
        ],
      ),
    );
  }
}
