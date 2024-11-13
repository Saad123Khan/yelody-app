import 'package:flutter/material.dart';
import 'package:yelody_app/res/colors/app_color.dart';

typedef OnCheckBoxStateChanged = Function(bool? v);

class CheckBoxWidget extends StatefulWidget {
  final bool isChecked;
  final OnCheckBoxStateChanged onCheckBoxStateChanged;

  const CheckBoxWidget({
    Key? key,
    required this.isChecked,
    required this.onCheckBoxStateChanged,
  }) : super(key: key);

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
    return InkWell(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
        widget.onCheckBoxStateChanged(_isChecked);
      },
      child: Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.primaryColor, width: 3),
          borderRadius: BorderRadius.circular(5.0),
          color: _isChecked ? AppColor.primaryColor : Colors.transparent,
        ),
        child: _isChecked
            ? const Icon(
                Icons.check,
                size: 14.0,
                color: Colors.black,
              )
            : null,
      ),
    );
  }
}
