// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:yelody_app/data/response/api_response.dart';
// import 'package:yelody_app/res/components/round_button.dart';
// import 'package:yelody_app/res/routes/routes_name.dart';
// import 'package:yelody_app/utils/utils.dart';
// import 'package:yelody_app/view/login/widgets/input_email_widget.dart';
// import 'package:yelody_app/view/login/widgets/input_password_widget.dart';
// import 'package:yelody_app/view/login/widgets/login_button_widget.dart';
// import 'package:yelody_app/view_models/controller/login/login_view_model.dart';

// import '../../data/response/status.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({Key? key}) : super(key: key);

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   // final loginVM = Get.put(LoginViewModel());
//   final _formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         title: Text('login'.tr),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Form(
//               key: _formkey,
//               child: Column(
//                 children: [
//                   InputEmailWidget(),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   InputPasswordWidget(),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             LoginButtonWidget(
//               text: 'login'.tr,
//               formKey: _formkey,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             TextButton(
//                 onPressed: () {
//                   Get.toNamed(RouteName.registerview);
//                 },
//                 child: Text("Register Now"))
//           ],
//         ),
//       ),
//     );
//   }
// }
