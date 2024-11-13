import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchFieldDesigin extends StatelessWidget {
  final String hintText;

  const SearchFieldDesigin({
    Key? key,
    required this.hintText,
  }) : super(key: key);

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
          SvgPicture.asset("assets/images/search_icon.svg"),
          SizedBox(width: 5.w),
          Expanded(
            child: Text(
              hintText,
              style: TextStyle(
                color: Color(0xFF6C6D76),
                fontSize: 14.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}