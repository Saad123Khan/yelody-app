import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchTextField extends StatelessWidget {
  final String hintText;
  const CustomSearchTextField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56.h,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFF3A3B43),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          // Icon(Icons.abc,
          // color: Colors.red,),
          SvgPicture.asset("assets/images/search_icon.svg"),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                // 'connortack@gmail.com',
                hintStyle: TextStyle(color: Color(0xFF6C6D76)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
