import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yelody_app/res/colors/app_color.dart';

///Custom CheckBoxes Used in App

class CheckBoxWidget extends StatefulWidget {
  final bool isChecked;
  final String title;
  final Function(bool? onChanged) onCheckBoxStateChanged;

  const CheckBoxWidget({
    super.key,
    required this.isChecked,
    required this.title,
    required this.onCheckBoxStateChanged,
  });

  @override
  CheckBoxWidgetState createState() => CheckBoxWidgetState();
}

class CheckBoxWidgetState extends State<CheckBoxWidget> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          fillColor: const MaterialStatePropertyAll(
            AppColor.primaryColor,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
            widget.onCheckBoxStateChanged(value);
          },
        ),
        Text(
          widget.title,
          style: TextStyle(
              fontSize: 13.sp,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
