// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:yelody_app/res/colors/app_color.dart';

// import '../../blocs/banners/banner_bloc.dart';

// class HomeScreenYellody extends StatefulWidget {
//   const HomeScreenYellody({Key? key}) : super(key: key);

//   @override
//   State<HomeScreenYellody> createState() => _HomeScreenYellodyState();
// }

// class _HomeScreenYellodyState extends State<HomeScreenYellody> {
//   @override
//   Widget build(BuildContext context) {
   
//     return

//         // Scaffold(
//         //   backgroundColor: AppColor.secondaryColor,
//         //   appBar: AppBar(
//         //     backgroundColor: Colors.transparent,
//         //     leading:  Image.asset("assets/icons/Logo.png"),
//         //     title: Text(
//         //       'Yelody',
//         //       textAlign: TextAlign.center,
//         //       style: TextStyle(
//         //         color: Color(0xFFE6E0E9),
//         //         fontSize: 22.sp,
//         //         fontFamily: 'Urbanist',
//         //         fontWeight: FontWeight.w600,
//         //       ),
//         //     ),
//         //   ),
//         //   body: SafeArea(
//         //     child: SingleChildScrollView(
//         //       child: Center(
//         //         child: Padding(
//         //           padding: const EdgeInsets.symmetric(horizontal: 15),
//         //           child: Column(
//         //             children: [
//         //               SizedBox(
//         //                 height: 50.h,
//         //               ),

//         //             ],
//         //           ),
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // );

//         DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         backgroundColor: AppColor.secondaryColor,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: Image.asset("assets/icons/Logo.png"),
//           title: Text(
//             'Yelody',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Color(0xFFE6E0E9),
//               fontSize: 22.sp,
//               fontFamily: 'Urbanist',
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             TabBar(
//               indicatorColor: AppColor.primaryColor,
//               indicatorSize: TabBarIndicatorSize.label,
//               labelColor: AppColor.primaryColor,
//               labelStyle: TextStyle(
//                 color: AppColor.primaryColor,
//                 fontSize: 16,
//                 fontFamily: 'Urbanist',
//                 fontWeight: FontWeight.w600,
//               ),
//               tabs: [
//                 Tab(
//                   text: "Billboard #100",
//                 ),
//                 Tab(
//                   text: "Hip Hop",
//                 ),
//                 Tab(
//                   text: "Rap",
//                 ),
//                 Tab(
//                   text: "Melody",
//                 ),
//               ],
//             ),
//             const Expanded(
//               child: TabBarView(
//                 children: [
//                   CashTablesTab(),
//                   CashTablesTab(),
//                   CashTablesTab(),
//                   CashTablesTab(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomTabBar extends StatelessWidget {
//   final List<String> tabTitles;
//   final int currentIndex;
//   final Function(int) onTabChanged;

//   CustomTabBar({
//     required this.tabTitles,
//     required this.currentIndex,
//     required this.onTabChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List<Widget>.generate(tabTitles.length, (index) {
//           return GestureDetector(
//             onTap: () => onTabChanged(index),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               color: currentIndex == index
//                   ? AppColor.primaryColor
//                   : Colors.transparent,
//               child: Text(
//                 tabTitles[index],
//                 style: TextStyle(
//                   color: currentIndex == index ? Colors.white : Colors.grey,
//                   fontSize: 16,
//                   fontFamily: 'Urbanist',
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// class CashTablesTab extends StatelessWidget {
//   const CashTablesTab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       separatorBuilder: (context, index) {
//         return const SizedBox(
//           height: 6,
//         );
//       },
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             //  color: Colors.green,
//             child: Row(
//               children: [
//                 Image.asset(
//                   "assets/images/starboy.png",
//                   width: 70,
//                   height: 70,
//                 ),
//                 Text("data")
//               ],
//             ),
//           ),
//         );
//       },
//       itemCount: 8,
//     );
//   }
// }

// class LeaderboardTab extends StatelessWidget {
//   const LeaderboardTab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Container(
//             color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
//             child: ListView.separated(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//               itemBuilder: (context, index) {
//                 return Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Image.asset(
//                         'assets/avatars/avatar${index + 1}.png',
//                         height: 40,
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Panthor2234',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleSmall
//                                 ?.copyWith(
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                           ),
//                           const SizedBox(
//                             height: 6,
//                           ),
//                           Text(
//                             '#${index + 1}',
//                             style: Theme.of(context).textTheme.titleSmall,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         '15465346',
//                         style: Theme.of(context).textTheme.titleSmall,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         '\$ 50',
//                         style: Theme.of(context).textTheme.titleSmall,
//                         textAlign: TextAlign.end,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               separatorBuilder: ((context, index) {
//                 return Divider(
//                   height: 40,
//                   thickness: 0.2,
//                   color: Theme.of(context).highlightColor,
//                 );
//               }),
//               itemCount: 6,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

  