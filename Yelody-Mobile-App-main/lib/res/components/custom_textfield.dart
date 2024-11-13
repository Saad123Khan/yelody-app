import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomTextfield extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   const CustomTextfield({
//     super.key,
//     required this.hintText,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 56.h,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 15,
//       ),
//       clipBehavior: Clip.antiAlias,
//       decoration: ShapeDecoration(
//         color: Color(0xFF3A3B43),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       child: Center(
//         child: TextField(
//           controller: controller,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14.sp,
//             fontFamily: 'Urbanist',
//             fontWeight: FontWeight.w400,
//           ),
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: hintText,
//             // 'connortack@gmail.com',
//             hintStyle: TextStyle(color: Color(0xFF6C6D76)),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  void Function()? onPrefixTap;
  void Function()? onTap;
  String? prefxicon;
  TextInputType? keyboardType;
  double? prefixRIghtPadding, sufixRIghtPadding, prefixLeftPadding;
  IconData? sufixicon;
  Widget? sufixImage, prefixImage;
  int? lines;
  bool readOnly, divider;
  // FocusNode? myFocusNode;
  EdgeInsetsGeometry? contentPadding;
  final String? hint, label;
  final double? fontsize, width, border_radius;
  final bool? obscureText;
  final Color? prefixIconColor, hintColor, fillColor, borderColor;
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function(String)? onchange;
  bool? suffix_divider;
  final void Function()? onclick;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  List<TextInputFormatter>? inputFormatters;
  CustomTextField({
    Key? key,
    this.onPrefixTap,
    this.prefxicon,
    this.prefixRIghtPadding,
    this.sufixRIghtPadding,
    this.borderColor,
    this.sufixicon,
    this.prefixImage,
    this.textInputAction,
    this.fillColor,
    this.focusNode,
    this.prefixLeftPadding,
    this.border_radius,
    this.lines,
    this.obscureText = false,
    this.hintColor,
    this.hint,
    this.fontsize,
    this.width,
    this.prefixIconColor,
    // this.myFocusNode,
    this.contentPadding,
    this.onclick,
    this.controller,
    this.validator,
    this.onchange,
    this.onTap,
    this.keyboardType,
    this.sufixImage,
    this.readOnly = false,
    this.divider = true,
    this.suffix_divider = false,
    this.label,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onTap: widget.onTap,

      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,

      // keyboardAppearance: TextInputType.text,
      onChanged: widget.onchange,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.obscureText!,
      textInputAction: widget.textInputAction,
      minLines: widget.lines ?? 1,
      maxLines: widget.lines ?? 1,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(
        fontSize: widget.fontsize ?? 14.sp,
        color: Colors.white,
        // fontFamily: 'Urbanist',
      ),
      decoration: InputDecoration(
          alignLabelWithHint: true,
          filled: true,
          fillColor: widget.fillColor ?? Color(0xFF3A3B43),
          enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.border_radius ?? 10.sp),
              borderSide: BorderSide(
                  width: 1, color: widget.borderColor ?? Color(0xFF3A3B43))),
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.border_radius ?? 10.sp),
              borderSide: BorderSide(
                  width: 1, color: widget.borderColor ?? Color(0xFF3A3B43))),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.border_radius ?? 10.sp),
              borderSide: const BorderSide(color: Color(0xFF3A3B43))),
          errorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.border_radius ?? 10.sp),
              borderSide: const BorderSide(color: Colors.red)),
          contentPadding: widget.prefxicon == null
              ? EdgeInsets.all(17.sp)
              : widget.contentPadding ?? null,
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: widget.hintColor ?? Colors.white.withOpacity(.3),
              fontSize: 15),
          label: widget.label != null ? Text(widget.label.toString()) : null,
          labelStyle: TextStyle(
            color: widget.hintColor ?? Colors.white,
            fontSize: 15,
          ),
          border: InputBorder.none,
          isDense: true,
          errorStyle: const TextStyle(overflow: TextOverflow.visible),
          errorMaxLines: 3,
          prefixIcon: widget.prefixImage ??
              (widget.prefxicon != null
                  ? GestureDetector(
                      onTap: widget.onPrefixTap,
                      child: Container(
                        height: 25,
                        margin: EdgeInsets.only(left: 15.w, right: 10.w),
                        padding: EdgeInsets.only(
                          right: widget.prefixRIghtPadding ?? 5.w,
                          left: widget.prefixLeftPadding ?? 0,
                        ),
                        decoration: widget.divider == true
                            ? const BoxDecoration(
                                border: Border(
                                    right: BorderSide(color: Colors.white)))
                            : null,
                        child: Image.asset(
                          widget.prefxicon!,
                          color: widget.prefixIconColor ?? Colors.red,
                          scale: 3,
                        ),
                      ),
                    )
                  : null),
          prefixIconConstraints: const BoxConstraints(),
          suffixIcon: widget.sufixImage != null
              ? GestureDetector(
                  onTap: widget.onclick,
                  child: Container(
                      height: 15,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: widget.suffix_divider == true
                          ? BoxDecoration(
                              border:
                                  Border(left: BorderSide(color: Colors.red)))
                          : null,
                      child: widget.sufixImage),
                )
              : null),
    );
  }
}
