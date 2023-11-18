import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/core/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double? width;
  final double? height;
  final VoidCallback onPressed;

  const CommonButton(
      {Key? key,
      required this.buttonText,
      this.buttonColor,
      required this.onPressed,
      this.buttonTextColor,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width ?? context.getWidthByPercentage(17.89),
          height: height ?? context.getHeightByPercentage(5.01),
          decoration: BoxDecoration(
              color: buttonColor ?? ThemeConstants.primaryColor,
              borderRadius: BorderRadius.circular(6.r)),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              buttonText, // textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: buttonTextColor ?? Colors.white,
              ),
            ),
          )),
    );
  }
}
