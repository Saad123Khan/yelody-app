import 'package:flutter/cupertino.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class CustomDragHandle extends StatelessWidget {
  const CustomDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // alignment: Alignment.center,
      child: Container(
        width: 40,
        margin: const EdgeInsets.only(top: 8),
        height: 5,
        decoration: BoxDecoration(
            color: AppColor.linearProgressIndicator,
            borderRadius: BorderRadius.circular(40)),
        // padding: const EdgeInsets.all(2),
      ),
    );
  }
}
