// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:yelody_app/data/response/status.dart';
// import 'package:yelody_app/res/components/general_exception.dart';
// import 'package:yelody_app/res/routes/routes_name.dart';
// import 'package:yelody_app/services/shared_prefernces.dart';
// import 'package:yelody_app/utils/app_dialogs.dart';
// import 'package:yelody_app/view/onboarding/onboarding_screen.dart';
// import 'package:yelody_app/view_models/controller/screenone/screenone_view_models.dart';
// import 'package:yelody_app/view_models/controller/user_preference/user_prefrence_view_model.dart';

// import '../../res/components/internet_exceptions_widget.dart';
// import '../../view_models/controller/home/home_view_models.dart';

// class ScreenOne extends StatefulWidget {
//   const ScreenOne({Key? key}) : super(key: key);

//   @override
//   State<ScreenOne> createState() => _ScreenOneState();
// }

// class _ScreenOneState extends State<ScreenOne> {
//   final screenOneController = Get.put(ScreenOneViewModel());

//   // UserPreference userPreference = UserPreference();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     screenOneController.screenOneApi();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 SharedPreference().clear();
//                 Get.offAll(OnboardingScreen());
//                 AppDialogs.showToast(message: 'Logout Sucess');
//                 // userPreference.removeUser().then((value) {
//                 //   Get.toNamed(RouteName.loginView);
//                 // });
//               },
//               icon: const Icon(Icons.logout))
//         ],
//       ),
//       body: Obx(() {
//         switch (screenOneController.rxRequestStatus.value) {
//           case Status.LOADING:
//             return const Center(child: CircularProgressIndicator());
//           case Status.ERROR:
//             if (screenOneController.error.value == 'No internet') {
//               return InterNetExceptionWidget(
//                 onPress: () {
//                   // screenOneController.refreshApi();
//                 },
//               );
//             } else {
//               return GeneralExceptionWidget(onPress: () {
//                 // screenOneController.refreshApi();
//               });
//             }
//           case Status.COMPLETED:
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(children: [
//                 Row(
//                   children: [
//                     Text("email:"),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Container(
//                       color: Colors.green,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(screenOneController
//                             .screenOneList.value.data!.email
//                             .toString()),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     Text("first name:"),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Container(
//                       color: Colors.green,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(screenOneController
//                             .screenOneList.value.data!.firstName
//                             .toString()),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     Text("last name"),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Container(
//                       color: Color.fromRGBO(76, 175, 80, 1),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(screenOneController
//                             .screenOneList.value.data!.lastName
//                             .toString()),
//                       ),
//                     ),
//                   ],
//                 )
//               ]),
//             );
//         }
//       }),
//     );
//   }
// }
