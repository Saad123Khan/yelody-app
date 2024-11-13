import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/res/routes/routes.dart';
import 'package:yelody_app/view/AccountProfile/controller/AuthController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        // splitScreenMode: true,
        builder: (context, child) {
          return GetBuilder<AuthController>(
              init: AuthController(),
              builder: (context) {
                return GetMaterialApp(
                  title: "Yelody",
                  debugShowCheckedModeBanner: false,
                  // home: UserProfileScreen(),
                  initialRoute: "/",
                  // home: CongratulationsScreen(isSingleSongs: true),
                  getPages: AppRoutes.appRoutes(),
                  // themeMode: ThemeMode.dark,
                  theme: ThemeData(
                      fontFamily: AppFonts.Urbanist,
                      primarySwatch: Colors.amber,
                      brightness: Brightness.dark,
                      useMaterial3: false),
                  builder: (context, child) {
                    return ScrollConfiguration(
                        behavior: MyScrollBehavior(),
                        child: MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 1.0),
                            child: child!));
                  },
                );
              });
        });
    // return ScreenUtilInit(
    //   designSize: const Size(360, 690),
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //   builder: (_, child) {
    //     return GetBuilder<AuthController>(
    //         init: AuthController(),
    //         builder: (context) {
    //           return GetMaterialApp(
    //             navigatorKey: AppNavigation.navigatorKey,
    //             debugShowCheckedModeBanner: false,
    //             title: 'Yelody App',
    //             theme: ThemeData(
    //                 primarySwatch: Colors.amber,
    //                 fontFamily: AppFonts.Urbanist,
    //                 useMaterial3: false),
    //             getPages: AppRoutes.appRoutes(),
    //           );
    //         });
    //   },
    // );
  }
}

///Rmeoves Glowing Effect on List Views
class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
