import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/constants.dart';
import 'package:yelody_app/view/LoginYelody/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  final int _delaySeconds = 500;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: _delaySeconds), (timer) {
      if (_pageIndex == demo_data.length - 1) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {
                Get.toNamed(RouteName.loginScreen);
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 30, top: 20),
                  child: Text("Skip", style: textTheme.titleSmall)))
        ],
        backgroundColor: AppColor.darkBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                itemCount: demo_data.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => onboardingContainer(
                  image: demo_data[index].image,
                  description: demo_data[index].description,
                  pageIndex: _pageIndex,
                  title_one: demo_data[index].title_one,
                  title_two: demo_data[index].title_two,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  demo_data.length,
                  ((index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: DotIndicator(isActive: index == _pageIndex),
                      )),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: PrimaryButton(
                  onpressed: () {
                    if (_pageIndex == 2) {
                      Get.off(() => LoginScreen());
                    } else {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    }
                  },
                  text: "Next"),
            ),
            // SizedBox(
            //   height: 15.h,
            // ),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 10 : 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? AppColor.primaryColor : const Color(0xff2A2B39),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class Onboard {
  final String image, description;
  final String title_one;
  final String title_two;
  Onboard({
    required this.image,
    required this.title_one,
    required this.title_two,
    required this.description,
  });
}

final List<Onboard> demo_data = [
  Onboard(
      image: 'assets/images/onbaording/onbaord1.png',
      title_one: "Join Community of Karaoke Enthusiasts from",
      title_two: "\nAround The World.",
      description:
          "Express yourself, share your talent, and\nconnect with fellow singers."),
  Onboard(
      image: 'assets/images/onbaording/onbaord2.png',
      title_one: "Find Your",
      title_two: "Favorite Songs",
      description:
          "Browse our extensive library of songs spanning various genres and languages. From classics to the latest hits, we've got something for everyone."),
  Onboard(
      image: 'assets/images/onbaording/onbaord3.png',
      title_one: "Let\'s",
      title_two: "Get Started!",
      description:
          "Create your Yelody account now and embark on a melodious adventure. Sing, connect, and enjoy the joy of karaoke like never before."),
];

class onboardingContainer extends StatelessWidget {
  const onboardingContainer({
    super.key,
    required this.image,
    required this.title_one,
    required this.title_two,
    required this.description,
    required this.pageIndex,
  });
  final String image, description;
  final String title_one, title_two;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          SizedBox(
            height: .07.sh,
          ),
          SizedBox(
            // height: .65.sh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Image.asset(
                    image,
                    // scale: 3,
                    width: ScreenUtil().setWidth(200),
                    height: ScreenUtil().setHeight(200),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              // 'Join Community of Karaoke Enthusiasts from ',
                              "$title_one ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(28),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: title_two,
                          //  'Around The World.',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: ScreenUtil().setSp(28),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Text(
                      // 'Express yourself, share your talent, and connect with fellow singers.',
                      description,

                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF6C6D76),
                        fontSize: 16.sp,
                        fontFamily: 'Urbanist',
                        height: 1.3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
