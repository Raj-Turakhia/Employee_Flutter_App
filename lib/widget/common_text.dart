import 'package:employee_app/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.fontColor,
      this.fontWeight,
      this.maxLines})
      : super(key: key);
  final String text;
  final double? fontSize;
  final int? maxLines;
  final Color? fontColor;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.w500,
          color: fontColor ?? ThemeConstants.primaryColor,
          fontSize: fontSize ?? 16.sp),
    );
  }
}
