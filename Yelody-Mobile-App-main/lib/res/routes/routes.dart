import 'package:get/get.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/view/AccountProfile/profile_screen.dart';
import 'package:yelody_app/view/AddInterest/addinterst_screen.dart';
import 'package:yelody_app/view/FeatureClickedScreen/featureclicked_screen.dart';
import 'package:yelody_app/view/LiveScreen/live_screen.dart';
import 'package:yelody_app/view/LoginYelody/login_screen.dart';
import 'package:yelody_app/view/MusicPlayDetailScreen/musicplaydetail_screen.dart';
import 'package:yelody_app/view/NewSongList/newsonglist_screen.dart';
import 'package:yelody_app/view/SeeAllPlayList/play_list_detail_screen.dart';
import 'package:yelody_app/view/SeeAllPlayList/seeall_playlist.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/homebinding.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/all_playlists_screen.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/allsongs_playlist.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyKaraake/seeall_myplaylist.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyProfile/edit_profile/editprofile_screen.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyProfile/setting/setting_screen.dart';
import 'package:yelody_app/view/bottom_navigation/bottom_navigation.dart';
import 'package:yelody_app/view/login/login_view.dart';
import 'package:yelody_app/view/onboarding/onboarding_screen.dart';
import 'package:yelody_app/view/register/register_view.dart';
import 'package:yelody_app/view/screenone/screen_one.dart';
import 'package:yelody_app/view/singMode/sing_mode.dart';
import 'package:yelody_app/view/songUploadingModal/song_uploading_modal.dart';
import 'package:yelody_app/view/splash_screen.dart';
import 'package:yelody_app/view/webView/webview_window.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.onboarding_screen,
          page: () => OnboardingScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.profileScreen,
          page: () => ProfileScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => LoginScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.addInterestsScreen,
          page: () => AddInterestsScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.bottomNavigation,
          page: () => BottomNavigation(),
          binding: AppBindings(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        // GetPage(
        //   name: RouteName.homeScreenYellody,
        //   page: () => HomeScreenYellody(),
        //   binding: AppBindings(),
        //   transitionDuration: Duration(milliseconds: 250),
        //   transition: Transition.leftToRightWithFade,
        // ),
        GetPage(
          name: RouteName.featureClicked,
          page: () => FeatureClicked(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.newSongListScreen,
          page: () => NewSongListScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.seeAllmyplaylistscreen,
          page: () => SeeAllMyPlayListScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.allSongsInsidePlaylist,
          page: () => AllSongsInsidePlaylist(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.musicPlayDetailsScreen,
          page: () => MusicPlayDetailScreen(),
          // binding: MusicDetailsBinding(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.seeAllPlaylist,
          page: () => SeeAllPlayScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.settingScreen,
          page: () => SettingScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        // GetPage(
        //   name: RouteName.loginView,
        //   page: () => LoginView(),
        //   transitionDuration: Duration(milliseconds: 250),
        //   transition: Transition.leftToRightWithFade,
        // ),
        GetPage(
          name: RouteName.editProfileScreen,
          page: () => EditProfileScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RouteName.recomendedPlayListsScreen,
          page: () => AllPlayListsScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),

        GetPage(
          name: RouteName.playListDetailsScreen,
          page: () => const PlayListDetailScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.cupertino,
        ),
        // GetPage(
        //   name: RouteName.homeView,
        //   page: () => HomeView(),
        //   transitionDuration: Duration(milliseconds: 250),
        //   transition: Transition.leftToRightWithFade,
        // ),
        GetPage(
          name: RouteName.liveScreen,
          page: () => LiveScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.songUploadingModal,
          page: () => SongUploadingModal(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        // GetPage(
        //   name: RouteName.registerview,
        //   page: () => RegisterView(),
        //   transitionDuration: Duration(milliseconds: 250),
        //   transition: Transition.leftToRightWithFade,
        // ),
        GetPage(
          name: RouteName.singMode,
          page: () => SingModeScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        // GetPage(
        //   name: RouteName.screen_one,
        //   page: () => ScreenOne(),
        //   transitionDuration: Duration(milliseconds: 250),
        //   transition: Transition.leftToRightWithFade,
        // ),
        // GetPage(
        //   name: RouteName.webViewSignRoute,
        //   page: () => ContentScreen(),
        //   transitionDuration: Duration(milliseconds: 250),
        //   transition: Transition.leftToRightWithFade,
        // ),
      ];
}
