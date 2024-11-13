// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yelody_app/res/colors/app_color.dart';

// class CustomDropDown2 extends StatefulWidget {
//   final String? dropdownValue, hintText;
//   final List<String>? dropDownData;
//   final Function(String)? onChanged;
//   final Color? color, dropdownListColor;
//   String? error_text;
//   Color? fillColor;
//   String? Function(String?)? validator;
//   final double? width,
//       fontSize,
//       dropDownWidth,
//       menuItemPadding,
//       horizontalPadding,
//       verticalPadding;
//   final Color? borderColor, hintTextColor;
//   final Offset? offset;
//   CustomDropDown2(
//       {Key? key,
//       this.dropDownData,
//       this.dropdownValue,
//       this.error_text,
//       this.width,
//       this.onChanged,
//       this.validator,
//       this.fontSize = 15.5,
//       this.fillColor,
//       this.dropdownListColor,
//       this.hintText,
//       this.hintTextColor,
//       this.verticalPadding,
//       this.horizontalPadding,
//       this.menuItemPadding,
//       this.dropDownWidth,
//       this.offset,
//       this.borderColor,
//       this.color})
//       : super(key: key);

//   @override
//   State<CustomDropDown2> createState() => _CustomDropDown2State();
// }

// class _CustomDropDown2State extends State<CustomDropDown2> {
//   @override
//   Widget build(BuildContext context) {
//     return dropDownTextField();
//   }

//   Widget dropDownTextField() {
//     return Column(
//       children: [
//         Container(
//           height: 55,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: AppColor.blackColor)),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButtonFormField2(
//                 style: TextStyle(
//                     color: widget.color ?? AppColors.RED_COLOR,
//                     fontSize: widget.fontSize!.sp),
//                 // hint: Text(
//                 //   widget.hintText!,
//                 //   style: TextStyle(
//                 //     fontSize: 14.sp,
//                 //     color: widget.hintTextColor ?? AppColors.GREY_COLOR,
//                 //   ),
//                 // ),
//                 validator: widget.validator,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   label: Text(
//                     widget.hintText!,
//                   ),
//                   labelStyle: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w500,
//                     color: widget.hintTextColor ?? AppColors.GREY_COLOR,
//                   ),
//                   // contentPadding: EdgeInsets.all(15),
//                   // isCollapsed: true,
//                   filled: true,
//                   fillColor: widget.fillColor ?? AppColors.BLACK_COLOR,
//                 ),
//                 menuItemStyleData: MenuItemStyleData(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: widget.menuItemPadding ?? 10.w),
//                 ),
//                 iconStyleData: IconStyleData(
//                     icon: Padding(
//                   padding: const EdgeInsets.only(bottom: 5, right: 5),
//                   child: Image.asset(
//                     AssetPaths.DROP_DOWN_ICON,
//                     scale: 2,
//                   ),
//                 )
//                     // icon: Padding(
//                     //   padding: EdgeInsets.only(bottom: 20.h),
//                     //   child: Icon(Icons.arrow_drop_down_rounded,size: 40,color: AppColors.BLUE_COLOR,)
//                     // ),
//                     // iconSize: 30,
//                     ),
//                 isExpanded: true,
//                 items: widget.dropDownData!
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: _text(
//                         text: value,
//                         color: widget.color ?? AppColors.BLUE_COLOR),
//                   );
//                 }).toList(),
//                 value: widget.dropdownValue,
//                 onChanged: (String? newValue) {
//                   widget.onChanged!(newValue!);
//                 },
//                 selectedItemBuilder: (BuildContext context) {
//                   return widget.dropDownData!.map<Widget>((dynamic item) {
//                     return CustomText(
//                         text: item,
//                         color: widget.color ?? AppColors.BLUE_COLOR);
//                   }).toList();
//                 },
//                 dropdownStyleData: DropdownStyleData(
//                   decoration: BoxDecoration(
//                       color: widget.dropdownListColor ?? AppColors.BLACK_COLOR,
//                       borderRadius: BorderRadius.only(
//                         bottomRight: Radius.circular(10),
//                         bottomLeft: Radius.circular(10),
//                       )),
//                   padding:
//                       EdgeInsets.only(left: widget.horizontalPadding ?? 5.w),
//                   elevation: 1,
//                   width: widget.dropDownWidth ?? 0.9.sw,
//                   offset: widget.offset ?? Offset(-10, -13),
//                   isOverButton: false,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // Padding(
//         //   padding: const EdgeInsets.only(left: 10),
//         //   child: Visibility(
//         //       visible: true,
//         //       child: Text(widget.error_text,
//         //           color: AppColors.RED_COLOR, fontsize: 12)),
//         // ),
//         SizedBox(
//           height:
//               widget.error_text == "" || widget.error_text == null ? 0.h : 12.h,
//         )
//       ],
//     );
//   }

//   Widget _text({String? text, Color? color}) {
//     return Text(
//       text ?? "",
//       style: TextStyle(
//         fontSize: widget.fontSize!.sp,
//         color: color ?? AppColor.whiteColor,
//       ),
//     );
//   }
// }
