// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:yelody_app/res/components/round_button.dart';
// import 'package:yelody_app/utils/utils.dart';
// import 'package:yelody_app/view_models/controller/register/register_view_models.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({Key? key}) : super(key: key);

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   final registerVM = Get.put(RegisterViewModel());
//   final _formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('register'.tr),
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
//                   TextFormField(
//                     controller: registerVM.emailController.value,
//                     focusNode: registerVM.emailFocusNode.value,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         Utils.snackBar('Email', 'Enter email');
//                       }
//                     },
//                     onFieldSubmitted: (value) {
//                       Utils.fieldFocusChange(
//                           context,
//                           registerVM.emailFocusNode.value,
//                           registerVM.passwordFocusNode.value);
//                     },
//                     decoration: InputDecoration(
//                         hintText: 'email_hint'.tr,
//                         border: OutlineInputBorder()),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     controller: registerVM.passwordController.value,
//                     focusNode: registerVM.passwordFocusNode.value,
//                     obscureText: true,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         Utils.snackBar('Password', 'Enter password');
//                       }
//                     },
//                     onFieldSubmitted: (value) {},
//                     decoration: InputDecoration(
//                         hintText: 'password_hint'.tr,
//                         border: OutlineInputBorder()),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             Obx(() => RoundButton(
//                 width: 200,
//                 title: "register".tr,
//                 loading: registerVM.loading.value,
//                 onPress: () {
//                   if (_formkey.currentState!.validate()) {
//                     // _formkey.
//                     registerVM.registerApi();
//                   }
//                   // registerVM.registerApi();
//                 }))
//           ],
//         ),
//       ),
//     );
//   }
// }
