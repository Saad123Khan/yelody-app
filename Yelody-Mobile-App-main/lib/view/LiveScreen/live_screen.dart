import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true,
      backgroundColor: AppColor.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading :false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                Expanded(
                  child: Container(
                          width: double.infinity,
                          height: 36.h,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.4000000059604645),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                  width: 1.w,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0x339E9E9E),
                              ),
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Row(
                            children: [
                  Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/divide_appbar.png"),
                              fit: BoxFit.fill,
                            ),
                            shape: OvalBorder(),
                          ),
                        ), 
                        SizedBox(width: 5.w,),
                               Text(
                          'Next',
                          style: TextStyle(
                            color: Color(0xFFF6AD00),
                            fontSize: 12.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          
                          ),
                        ),  SizedBox(width: 5.w,),
                             Text.rich(
                            TextSpan(
                              children: [
                  TextSpan(
                    text: 'Shape of you by',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                  
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    
                    ),
                  ),
                  TextSpan(
                    text: 'Ed Sheeran',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                     
                    ),
                  ),
                              
                            ],
                          ),
                          ),
                            ],
                          ),
                          ),
                ),
                SizedBox(width: 10,),
            GestureDetector(
              onTap: (){

                 showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  width: double.infinity,
                                  height: 150.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF1A1B22),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.w, color: Color(0xFF2A2B39)),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        topRight: Radius.circular(18),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text(
                                          'Quit singing?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width: double.infinity,
                                                height: 56.h,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color: Color(0xFF3A3B43),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: GestureDetector(

                                                  onTap: (){

                                                  // Navigator.pop(context);
                                                  Get.toNamed(RouteName.songUploadingModal
                                                  
                                                  
                                                  
                                                  );
                                                  },
                                                    child: Text(
                                                      'Cancel',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: PrimaryButton(
                                                  onpressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: "Yes"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              useSafeArea: false,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: Color(0xFF2A2B39)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                              ),
                            );
              },
              child: Text(
                'X ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      body: 
      Container(
              width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
     decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/livebg.png",)
              ),
            ),
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
         
          
          children: [
        // SizedBox(height: MediaQuery.of(context).size.height*0.15,),
        SizedBox(height: 100.h,),
        
        GestureDetector(
          onTap: (){
              Get.toNamed(
                                                      RouteName.songUploadingModal
                                                    );
          },
          child: Row(children: [
           SvgPicture.asset("assets/images/singing_logo.svg"),
            Expanded(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children:[ Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        'Electronic',
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 14.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                         
                        ),
                      ),
                       Text(
                    'Starboy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                     
                    ),
                  ),
                    Text(
                    'weekend',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      
                    ),
                  ),
                ],
              ),]
            ),
          ),
            ),
          ],),
        ),
      
          SizedBox(height: MediaQuery.of(context).size.height*0.2,),
      
        Column(
          children: [
            Text(
                'love Your love was hand',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  
                ),
              ),     SizedBox(height: 5,),
              Text(
            'made for Somebody Like',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
             
            ),
          ),     SizedBox(height: 5,),
        
          Text(
            'Come on now, I may be crazy,',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF6AD00),
              fontSize: 18.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
        
            ),
          ),
             SizedBox(height: 5,),
          Text(
            'Come on now, I may be crazy,',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
             
            ),
          ),
             SizedBox(height: 5,),
        Text(
            'Come on now, I may be crazy,',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
            
            ),
          ),
          ],
        ),
          
        
        ],),
      ),
    ),
      )
      

    );
  }
}