// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/blocs/banners/banner_bloc.dart';
import 'package:yelody_app/blocs/charts/chart_bloc.dart';
import 'package:yelody_app/blocs/song/getall_songs_bloc.dart';
import 'package:yelody_app/models/charts/chart_list_res.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/custom_image_network.dart';
import 'package:yelody_app/res/components/music_playlist.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/text.dart';
import 'home_controller.dart';

class YelodyHomeView extends StatefulWidget {
  const YelodyHomeView({super.key});

  @override
  State<YelodyHomeView> createState() => _YelodyHomeViewState();
}

class _YelodyHomeViewState extends State<YelodyHomeView> {
  int currentPos = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BannerBloc().loadBanners(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });

      ChartsBloc().loadCharts(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });

      GetAllSongsBloc().loadAllSongs(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          });

      ////
    });
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        leadingWidth: 50,
        backgroundColor: AppColor.darkBackgroundColor,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 0, top: 12, bottom: 10),
          child: Image.asset("assets/icons/app_logo.png"),
        ),
        // backgroundColor: AppColor.darkBackgroundColor,
        title: MyText.AppBarTextWidget(
          "Yelody",
        ),
      ),
      backgroundColor: AppColor.darkBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15).r,
        child: Obx(
          () => homeController.songs.value == null
              ? const SizedBox()
              : DefaultTabController(
                  length: homeController.charts.value?.data?.length ?? 0,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Obx(
                                    () => Visibility(
                                      visible: homeController
                                                  .homeBanners.value?.data !=
                                              null &&
                                          homeController.homeBanners.value!
                                              .data!.isNotEmpty,
                                      child: CarouselSlider.builder(
                                        itemCount: homeController.homeBanners
                                                .value?.data?.length ??
                                            0,
                                        options: CarouselOptions(
                                          autoPlay: true,
                                          viewportFraction: 1,
                                          onPageChanged: (index, reason) {
                                            homeController
                                                .bannerPosition.value = index;
                                          },
                                        ),
                                        itemBuilder: (context, index, i) {
                                          return GeneralBannerView(
                                              homeController.homeBanners.value!
                                                  .data![index].image!);
                                        },
                                      ),
                                    ),
                                  ),
                                  // Dots

                                  Positioned(
                                      bottom: 28,
                                      left: 0,
                                      right: 0,
                                      child: Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              homeController.homeBanners.value
                                                      ?.data?.length ??
                                                  0,
                                              (index) => Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 6),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: homeController
                                                                  .bannerPosition
                                                                  .value ==
                                                              index
                                                          ? AppColor
                                                              .primaryColor
                                                          : Colors.white,
                                                    ),
                                                  )),
                                          //
                                          // ),
                                        ),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText.HomeText(
                                    'New Songs ',
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteName.newSongListScreen);
                                      },
                                      child: Image.asset(
                                          "assets/icons/arrow_right.png"))
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Visibility(
                                visible:
                                    homeController.songs.value?.data != null,
                                child: SizedBox(
                                  height: 140.h,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: 22.w,
                                      );
                                    },
                                    // padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeController
                                            .songs.value?.data?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return SongStories(
                                        image: homeController.songs.value!
                                            .data![index].imageFile!,
                                        songName: homeController
                                            .songs.value!.data![index].name!,
                                        songWrittenBy: homeController.songs
                                            .value!.data![index].artistName!,
                                        onPressed: () {
                                          Get.toNamed(
                                            RouteName.musicPlayDetailsScreen,
                                            arguments: {
                                              'songData': homeController
                                                  .songs.value!.data![index],
                                              'singleSong': true
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverOverlapAbsorber(
                          // This widget takes the overlapping behavior of the SliverAppBar,
                          // and redirects it to the SliverOverlapInjector below. If it is
                          // missing, then it is possible for the nested "inner" scroll view
                          // below to end up under the SliverAppBar even when the inner
                          // scroll view thinks it has not been scrolled.
                          // This is not necessary if the "headerSliverBuilder" only builds
                          // widgets that do not overlap the next sliver.
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                          sliver: SliverSafeArea(
                            top: false,
                            bottom: false,
                            sliver: SliverAppBar(
                              // toolbarHeight:
                              //     Platform.isIOS ? 0 : kTextTabBarHeight,
                              floating: false,
                              elevation: 0,
                              pinned: true,
                              snap: false,
                              backgroundColor: AppColor.darkBackgroundColor,
                              primary: true,
                              forceElevated: innerBoxIsScrolled,
                              bottom: PreferredSize(
                                preferredSize: const Size.fromHeight(50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () => Align(
                                        alignment: Alignment.topLeft,
                                        child: Text.rich(TextSpan(children: [
                                          TextSpan(
                                            text: 'Top ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23.sp,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: homeController.charts.value
                                                            ?.data !=
                                                        null &&
                                                    homeController.charts.value!
                                                        .data!.isNotEmpty
                                                ? '#${homeController.charts.value?.data?[homeController.chartIndex.value].name}'
                                                : '',
                                            style: TextStyle(
                                              color: AppColor.primaryColor,
                                              fontSize: 23.sp,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' rankings!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23.sp,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ])),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TabBar(
                                      labelStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Urbanist',
                                      ),
                                      // indicatorPadding: EdgeInsets.zero,
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0, bottom: 4),
                                      labelPadding: const EdgeInsets.only(
                                          left: 0, right: 20),

                                      indicatorSize: TabBarIndicatorSize.label,

                                      // labelStyle: TextS,
                                      // tabAlignment: TabAlignment.start,
                                      onTap: (value) {
                                        homeController.chartIndex.value = value;
                                      },
                                      isScrollable: true,

                                      //                                 // padding: EdgeInsets.zero,
                                      unselectedLabelColor: Colors.white,
                                      indicatorColor: AppColor.primaryColor,
                                      labelColor: AppColor.primaryColor,
                                      // These are the widgets to put in each tab in the tab bar.
                                      tabs: homeController.charts.value != null
                                          ? homeController.charts.value!.data!
                                              .map((ChartData name) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0),
                                                    child: Tab(text: name.name),
                                                  ))
                                              .toList()
                                          : [],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: homeController.charts.value == null
                        ? const SizedBox()
                        : TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            // These are the contents of the tab views, below the tabs.
                            children: homeController.charts.value!.data!
                                .map((ChartData name) {
                              return SafeArea(
                                top: false,
                                bottom: false,
                                child: Builder(
                                  // This Builder is needed to provide a BuildContext that is "inside"
                                  // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                                  // find the NestedScrollView.
                                  builder: (BuildContext context) {
                                    return CustomScrollView(
                                      // The "controller" and "primary" members should be left
                                      // unset, so that the NestedScrollView can control this
                                      // inner scroll view.
                                      // If the "controller" property is set, then this scroll
                                      // view will not be associated with the NestedScrollView.
                                      // The PageStorageKey should be unique to this ScrollView;
                                      // it allows the list to remember its scroll position when
                                      // the tab view is not on the screen.
                                      key:
                                          PageStorageKey<String>(name.chartId!),
                                      slivers: <Widget>[
                                        SliverOverlapInjector(
                                          // This is the flip side of the SliverOverlapAbsorber above.
                                          handle: NestedScrollView
                                              .sliverOverlapAbsorberHandleFor(
                                                  context),
                                        ),
                                        SliverPadding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 15),
                                          // In this example, the inner scroll view has
                                          // fixed-height list items, hence the use of
                                          // SliverFixedExtentList. However, one could use any
                                          // sliver widget here, e.g. SliverList or SliverGrid.
                                          sliver: SliverFixedExtentList(
                                            // The items in this example are fixed to 48 pixels
                                            // high. This matches the Material Design spec for
                                            // ListTile widgets.
                                            itemExtent: 90.0,

                                            delegate:
                                                SliverChildBuilderDelegate(
                                              (BuildContext context,
                                                  int index) {
                                                // This builder is called for each child.
                                                // In this example, we just number each list item.

                                                final song = name.songs?[index];

                                                return MusicPlayList(
                                                  genre: song?.genre ?? '',
                                                  name: song?.name ?? '',
                                                  popular:
                                                      song?.artistName ?? '',
                                                  songImage:
                                                      song?.imageFile ?? 'null',
                                                  topNumber: song?.rank ?? 0,
                                                  onImageTapped: () {
                                                    Get.toNamed(
                                                      RouteName
                                                          .musicPlayDetailsScreen,
                                                      arguments: {
                                                        'songData': song,
                                                        'singleSong': true
                                                      },
                                                    );
                                                  },
                                                  onPressed: () {
                                                    Get.toNamed(
                                                      RouteName.singMode,
                                                      arguments: {
                                                        'songData': song,
                                                        'singleSong': true
                                                      },
                                                    );
                                                  },
                                                );

                                                // Container(
                                                //     color: Color((math.Random()
                                                //                         .nextDouble() *
                                                //                     0xFFFFFF)
                                                //                 .toInt() <<
                                                //             0)
                                                //         .withOpacity(1.0));
                                              },
                                              // The childCount of the SliverChildBuilderDelegate
                                              // specifies how many children this inner list
                                              // has. In this example, each tab has a list of
                                              // exactly 30 items, but this is arbitrary.
                                              childCount: name.songs?.length,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                ),
        ),
      ),
    );
  }
}

class SongStories extends StatelessWidget {
  final String image;
  final String songName;
  final VoidCallback onPressed;
  final String songWrittenBy;

  const SongStories({
    super.key,
    required this.image,
    required this.songName,
    required this.songWrittenBy,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 87.w,
            height: 87.h,
            decoration: ShapeDecoration(
                shape: CircleBorder(
              side: BorderSide(width: 4.w, color: Color(0xFF5D5E73)),
            )),
            child: Container(
              width: 76.w,
              height: 76.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(NetworkStrings.imageURL + image),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          SizedBox(
            width: 87.w,
            child: Text(
              // 'Shape of you',
              songName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            // 'ED Sheeran',
            songWrittenBy,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6C6D76),
              fontSize: 13.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class GeneralBannerView extends StatelessWidget {
  final String imgPath;

  const GeneralBannerView(this.imgPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   color: Colors.red,
        //   child: Stack(
        //     children: [
        ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 120.h,
        width: Get.width,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: ExtendedNetworkImageProvider(
        //             NetworkStrings.imageURL + imgPath))),
        // color: Colors.amber,
        child: ExtendedImageNetwork(
          imageUrl: NetworkStrings.imageURL + imgPath,
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   child: Image.network(
        //     NetworkStrings.imageURL + imgPath,
        //     height: 120.h,
        //     width: Get.width,
        //   ),
        // ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}

class Img {
  static String get(String? name) {
    return 'assets/images/$name';
  }
}

// class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar tabBar;

//   _StickyTabBarDelegate(this.tabBar);

//   @override
//   double get minExtent => 18;
//   @override
//   double get maxExtent => 18;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: AppColor.darkBackgroundColor, // Or any other background color
//       child: tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
//     return false;
//   }
// }

// class StackOver extends StatefulWidget {
//   @override
//   _StackOverState createState() => _StackOverState();
// }

// class _StackOverState extends State<StackOver>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           // give the tab bar a height [can change hheight to preferred height]
//           Container(
//             height: 45,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(
//                 25.0,
//               ),
//             ),
//             child: TabBar(
//               onTap: (value) {

//               },
//               controller: _tabController,
//               // give the indicator a decoration (color and border radius)
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                   25.0,
//                 ),
//                 color: Colors.green,
//               ),
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.black,
//               tabs: [
//                 // first tab [you can add an icon using the icon property]
//                 Tab(
//                   text: 'Place Bid',
//                 ),

//                 // second tab [you can add an icon using the icon property]
//                 Tab(
//                   text: 'Buy Now',
//                 ),
//               ],
//             ),
//           ),
//           // tab bar view here
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 // first tab bar view widget
//                 Text(
//                   'Place Bid',
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),

//                 // second tab bar view widget
//                 Center(
//                   child: Text(
//                     'Buy Now',
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
