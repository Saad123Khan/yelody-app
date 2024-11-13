import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class CustomDropDown2 extends StatefulWidget {
  final String? dropdownValue, hintText;
  final List<String>? dropDownData;
  final Function(String)? onChanged;
  final Color? color, dropdownListColor;
  bool hasShadow;
  String? error_text;
  Color? fillColor, errorTextColor;
  String? Function(String?)? validator;
  final double? width,
      fontSize,
      dropDownWidth,
      menuItemPadding,
      horizontalPadding,
      verticalPadding;
  final Color? borderColor, hintTextColor;
  final Offset? offset;
  CustomDropDown2(
      {Key? key,
      this.dropDownData,
      this.dropdownValue,
      this.error_text,
      this.width,
      this.onChanged,
      this.errorTextColor,
      this.validator,
      this.fontSize = 15.5,
      this.hasShadow = false,
      this.fillColor,
      this.dropdownListColor,
      this.hintText,
      this.hintTextColor,
      this.verticalPadding,
      this.horizontalPadding,
      this.menuItemPadding,
      this.dropDownWidth,
      this.offset,
      this.borderColor,
      this.color})
      : super(key: key);

  @override
  State<CustomDropDown2> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDown2> {
  @override
  Widget build(BuildContext context) {
    return dropDownTextField();
  }

  Widget dropDownTextField() {
    return Column(
      children: [
        Container(
          height: 60,
          // padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            boxShadow: widget.hasShadow
                ? [
                    BoxShadow(
                      color:
                          AppColor.primaryColor.withOpacity(.2), // darker color
                    ),
                    const BoxShadow(
                      color: AppColor.whiteColor, // background color
                      spreadRadius: -12.0,
                      blurRadius: 12.0,
                    ),
                  ]
                : null,
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: widget.borderColor ?? AppColor.whiteColor),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField2(
                style: TextStyle(
                    color: widget.color ?? AppColor.whiteColor,
                    fontSize: widget.fontSize!.sp),
                // hint: Text(
                //   widget.hintText!,
                //   style: TextStyle(
                //     fontSize: 14.sp,
                //     color: widget.hintTextColor ?? AppColors.GREY_COLOR,
                //   ),
                // ),

                validator: widget.validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                decoration: InputDecoration(
                  border: InputBorder.none,

                  alignLabelWithHint: false,
                  // labelStyle: TextStyle(
                  //   fontSize: 14.sp,
                  //   fontWeight: FontWeight.w500,
                  //   color: AppColors.RED_COLOR_1,
                  // ),
                  labelText: widget.hintText,
                  // alignLabelWithHint: T,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.primaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  floatingLabelStyle: TextStyle(color: AppColor.primaryColor),

                  // suffixIcon: Image.asset(
                  //   AssetPaths.DROPDOWNICON,
                  //   scale: 3,
                  //   color: AppColors.RED_COLOR_1,
                  // ),
                  // contentPadding: EdgeInsets.all(15),
                  // isCollapsed: true,
                  filled: true,
                  fillColor: widget.fillColor ?? AppColor.darkBackgroundColor,
                ),
                menuItemStyleData: MenuItemStyleData(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.menuItemPadding ?? 10.w),
                ),
                // iconStyleData: IconStyleData(
                //     icon: Padding(
                //   padding: const EdgeInsets.only(bottom: 5, right: 5),
                //   child: Image.asset(
                //     AssetPaths.DROP_DOWN_ICON,
                //     scale: 2,

                //   ),
                iconStyleData: IconStyleData(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: SvgPicture.asset(
                      'assets/icons/dropdown.svg',
                      // scale: 3,
                      // color: AppColors.RED_COLOR_1,
                    ),
                  ),
                ),

                // icon: Padding(
                //   padding: EdgeInsets.only(bottom: 20.h),
                //   child: Icon(Icons.arrow_drop_down_rounded,size: 40,color: AppColors.BLUE_COLOR,)
                // ),
                // iconSize: 30,

                isExpanded: true,
                items: widget.dropDownData!
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          TextStyle(color: widget.color ?? AppColor.whiteColor),
                    ),
                  );
                }).toList(),
                value: widget.dropdownValue,
                onChanged: (String? newValue) {
                  widget.onChanged!(newValue!);
                },
                selectedItemBuilder: (BuildContext context) {
                  return widget.dropDownData!.map<Widget>((dynamic item) {
                    return Text(
                      item,
                      style: TextStyle(color: widget.color),
                    );
                  }).toList();
                },
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                      color: widget.dropdownListColor ??
                          AppColor.darkBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                  padding:
                      EdgeInsets.only(left: widget.horizontalPadding ?? 5.w),
                  elevation: 1,
                  width: widget.dropDownWidth ?? 0.9.sw,
                  offset: widget.offset ?? Offset(-10, -13),
                  isOverButton: false,
                ),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 10),
        //   child: Visibility(
        //       visible: true,
        //       child: Text(widget.error_text ?? '',
        //           color: widget.errorTextColor ?? AppColors.RED_COLOR,
        //           fontsize: 12)),
        // ),
        // SizedBox(
        //   height:
        //       widget.error_text == "" || widget.error_text == null ? 0.h : 12.h,
        // )
      ],
    );
  }

  // Widget _text({String? text, Color? color}) {
  //   return CustomText(
  //     text: text ?? "",
  //     fontsize: widget.fontSize!.sp,
  //     color: color ?? AppColors.GREY_COLOR,
  //   );
  // }
}
