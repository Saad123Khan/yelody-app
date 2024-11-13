import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/components/round_button.dart';

class LoginButtonWidget extends StatelessWidget {
  final formKey;
  final String text;
  LoginButtonWidget({Key? key, required this.formKey, required this.text})
      : super(key: key);

  // final loginVM = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => RoundButton(
        width: 200,
        title: text,
        // loading: loginVM.loading.value,
        onPress: () {
          if (formKey.currentState!.validate()) {
            // loginVM.loginApi();
          }
        }));
  }
}
