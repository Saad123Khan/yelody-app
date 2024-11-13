import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyChartView/yelody_charview.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/yelody_homeview.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/yelody_karaake.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyProfile/yelody_profileview.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = Get.arguments?['index'] ?? 0;
    super.initState();
  }

  final List<Widget> _children = [
    const YelodyHomeView(),
    const ChartView(),
    const KaraakeView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomBarItems = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset("assets/icons/home_icon.svg"),
        activeIcon: SvgPicture.asset("assets/icons/home_active.svg"),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset("assets/icons/charts.svg"),
        activeIcon: SvgPicture.asset("assets/icons/charts_active.svg"),
        label: "Charts",
      ),
      BottomNavigationBarItem(
        icon:
            // Icon(Icons.wallet),
            SvgPicture.asset("assets/icons/karaoke.svg"),
        activeIcon:
            // Icon(Icons.wallet),
            SvgPicture.asset("assets/icons/karaoke_active.svg"),
        label: "Karaoke",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset("assets/icons/profile.svg"),
        activeIcon: SvgPicture.asset("assets/icons/profile_active.svg"),
        label: "Profile",
      ),
    ];
    return Column(
      children: <Widget>[
        Expanded(child: _children[currentIndex]),
        _buildBottomBar(),
      ],
    );
    //   bottomNavigationBar: BottomNavigationBar(
    //     backgroundColor: AppColor.blackColor,
    //     selectedItemColor: AppColor.primaryColor,
    //     unselectedItemColor: const Color(0xFFB4B5BF),
    //     currentIndex: _currentIndex,
    //     selectedFontSize: 13.sp,
    //     unselectedFontSize: 13.sp,
    //     iconSize: 20,
    //     type: BottomNavigationBarType.fixed,
    //     items: bottomBarItems,
    //     onTap: (int index) {
    //       setState(() {
    //         _currentIndex = index;
    //       });
    //     },
    //   ),
    // );
  }

  _buildBottomBar() {
    return Container(
      height: Platform.isAndroid ? 80 : 90,
      width: 1.sw,
      decoration: BoxDecoration(
          color: AppColor.darkBackgroundColor,
          border: Border(
              top: BorderSide(
            color: Colors.grey.withOpacity(.5),
          ))),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            // Divider(
            //   thickness: 1,
            //   color: Colors.grey.withOpacity(.5),
            // ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBottomIcon(
                      index: 0,
                      image: currentIndex == 0
                          ? 'assets/icons/bottom/home_icon.png'
                          : 'assets/icons/bottom/home_unfilled.png',
                      title: "Home"),
                  _buildBottomIcon(
                      index: 1,
                      image: currentIndex == 1
                          ? 'assets/icons/bottom/chart_filled.png'
                          : 'assets/icons/bottom/chart.png',
                      title: "Charts"),
                  _buildBottomIcon(
                      index: 2,
                      image: currentIndex == 2
                          ? 'assets/icons/bottom/karoke_filled.png'
                          : 'assets/icons/bottom/karoke.png',
                      title: "Karaoke"),
                  _buildBottomIcon(
                      index: 3,
                      image: currentIndex == 3
                          ? 'assets/icons/bottom/profile_filled.png'
                          : 'assets/icons/bottom/profile.png',
                      title: "Profile")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBottomIcon(
      {required int index, required String image, required String title}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                image,
                color:
                    currentIndex == index ? AppColor.primaryColor : Colors.grey,
                fit: BoxFit.contain,
                // scale: 4,
                // scale: ,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: AppFonts.Urbanist,
                  fontWeight: currentIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: currentIndex == index
                      ? AppColor.primaryColor
                      : Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
