
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';
import 'package:yelody_app/view/LiveScreen/live_screen.dart';

class CustomAlertDialogSinging extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Dialog(
      backgroundColor: Color(0xFF1A1B22),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
      height: 400.h,
     
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

Row(
  
  mainAxisAlignment: MainAxisAlignment.end,
  
  children: [
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
    child: GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Text("x",
      style: TextStyle(
      fontSize: 20
      
      ),
      ),
    ),
  )
],),




        SvgPicture.asset("assets/images/singing_image.svg",
        // height: 180.h,
        // width: 130.w,
         width: 240.w,
          height: 220.h,
        ),
        

        Text(
              'Use headsets!!',
            
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 32.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
               
              ),
            ),
        Text(
              'for Better Recordings',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
             
              ),
            ),
        
         PrimaryButton(onpressed: (){ 
          
          // Navigator.of(context).pop();
        //  Get.toNamed(RouteName.homeScreenYellody) ;
        //  Get.toNamed(RouteName.featureClicked) ;
         
        //  Get.toNamed(RouteName.liveScreen) ;
        Get.off(LiveScreen());
         
         
         }, text:  'Start With Singing',),
        
            SizedBox(height: 10.h,)
            
            ],
          ),
        ),
      ),
    );
  }
}
