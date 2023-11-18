import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/core/context_extension.dart';
import 'package:employee_app/widget/common_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final Color color;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.onTap,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: context.getWidthByPercentage(1.96)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              4.r,
            ),
            borderSide: const BorderSide(color: ThemeConstants.borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              4.r,
            ),
            borderSide: const BorderSide(color: ThemeConstants.borderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              4.r,
            ),
            borderSide: const BorderSide(color: ThemeConstants.borderColor)),
        hintText: hintText,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: ThemeConstants.textColor),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonIconWidget(icon: prefixIcon ?? ''))
            : null,
        suffixIcon: suffixIcon,
      ),
      controller: controller,
      onTap: onTap,
      obscureText: obscureText,
      onChanged: onChanged,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: ThemeConstants.bottomSheetTextColor,
      ),
    );
  }
}
