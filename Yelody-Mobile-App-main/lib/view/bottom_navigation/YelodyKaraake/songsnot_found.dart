import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongsNotFound extends StatelessWidget {
  const SongsNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Image.asset("assets/images/notfound.png"),
          Text(
            'Song Not Found!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Color(0xFFF6AD00),
              fontSize: 32,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Try searching again using different keyword.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6C6D76),
              fontSize: 16,
              height: 1.5,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
