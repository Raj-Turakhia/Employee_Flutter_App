import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/core/context_extension.dart';
import 'package:employee_app/widget/common_icon.dart';
import 'package:employee_app/widget/percentage_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDatePickWidget extends StatelessWidget {
  final String text;
  final String? prefixIcon;
  final VoidCallback? onTap;
  final Color? fontColor;

  const CommonDatePickWidget(
      {super.key,
      this.prefixIcon,
      this.onTap,
      required this.text,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.getWidthByPercentage(2.94),
            vertical: context.getHeightByPercentage(1.00)),
        decoration: BoxDecoration(
            border: Border.all(color: ThemeConstants.borderColor),
            borderRadius: BorderRadius.circular(4.r)),
        child: Row(
          children: [
            CommonIconWidget(
              icon:prefixIcon ?? '',
            ),
            const PercentageSizeBox(
              widthInPer: 2.37,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: fontColor ?? ThemeConstants.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
