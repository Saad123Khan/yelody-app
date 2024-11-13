import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/components/primary_button.dart';
import 'package:yelody_app/res/routes/routes_name.dart';

class SongUploadingModal extends StatefulWidget {
  const SongUploadingModal({super.key});

  @override
  State<SongUploadingModal> createState() => _SongUploadingModalState();
}



class _SongUploadingModalState extends State<SongUploadingModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.secondaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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

                                                  Navigator.pop(context);
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
        // body: Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(
        //       "assets/images/uploadingmodal.png",
        //     )),
        //   ),
        //   child: SingleChildScrollView(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 15),
        //       child: Column(
        //         children: [
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.3,
        //           ),
        //           Column(
        //             children: [
        //               Text(
        //                 'Score',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 24.sp,
        //                   fontFamily: 'Urbanist',
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //               ),
        //               Text(
        //                 '98',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(
        //                   color: Color(0xFFF6AD00),
        //                   fontSize: 100,
        //                   fontFamily: 'Urbanist',
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //               ),
        //               Text(
        //                 'Congratulations!',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 24.sp,
        //                   fontFamily: 'Urbanist',
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height * 0.3,
        //           ),
        //           BottomBtns()
        //         ],
        //       ),
        //     ),
        //   ),
        // ));

        body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/uploadingmodal.png"),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                           Column(
                    children: [
                      Text(
                        'Score',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '98',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF6AD00),
                          fontSize: 100,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Congratulations!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: BottomBtns(),
            ),
          ),
        ],
      ),);
  }
}

class BottomBtns extends StatelessWidget {
  const BottomBtns({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){

            Get.toNamed(RouteName.singMode);
            },
            child: Container(
              height: 56.h,
              decoration: ShapeDecoration(
                color: Color(0xFF3A3B43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Center(
                child: Text(
                  'Okay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ), SizedBox(width: 8.w,),
        Expanded(
          child: GestureDetector(


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
                                          'Moving to Next Song',
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

                                                  Navigator.pop(context);
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
                                                  text: "Ok"),
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

            child: Container(
              width: double.infinity,
              height: 56.h,
              decoration: ShapeDecoration(
                color: Color(0xFFF6AD00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 4.w,),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/girl.png"),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),SizedBox(width: 4.w,),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next song',
                              style: TextStyle(
                                color: Color(0xFF3A3B43),
                                fontSize: 10.sp,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Positions',
                              style: TextStyle(
                                color: Color(0xFF3A3B43),
                                fontSize: 16.sp,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          SvgPicture.asset("assets/icons/arrow_icon.svg"),         
                  SizedBox(width: 4.w,),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
