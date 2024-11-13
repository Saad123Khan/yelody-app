
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BillboardList extends StatelessWidget {
  final String songImage;
  final int topNumber;
  final String name;
  final String popular;
  const BillboardList({
    super.key, required this.songImage, required this.topNumber, required this.name, required this.popular,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
  
      children: [
        Container(
          width: 70.w,
          height: 70.h,
          decoration: ShapeDecoration(
           
            image: DecorationImage(
              image:
                 
            // AssetImage("assets/images/divide.png"),
            AssetImage(songImage),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
          SizedBox(width: 12.w,),
        
          
        Expanded(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
             'Top #${topNumber}',
              style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
              
              ),
            ),
                SizedBox(height: 3.h,),
              Text(
            // 'Shape of you',
            name,
              style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
             
              ),
            ),SizedBox(height: 3.h,),
                Text(
            // 'Funk . ED Sheeran',
            popular,
                    style: TextStyle(
            color: Color(0xFF6C6D76),
            fontSize: 14.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w400,
                     
                    ),
                  ),
              ],),
            ],
          ),
        ),
          
          
          
          
          
          
          
          
          
          
          
          
            Container(
            width: 90.w,
            height: 35.h,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.10000000149011612),
              shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
    SvgPicture.asset("assets/images/add.svg"),
    Text(
    'Add',
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.white,
    fontSize: 14.sp,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w600,
    
    ),
    ),
              ],
            ),
            )
          
          
          
          
        
      ],
    );
  }
}
