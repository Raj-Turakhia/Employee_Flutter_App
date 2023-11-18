import 'package:employee_app/core/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonImageTextWidget extends StatelessWidget {
  final String icon;
  final String title;
  final double? imageWidth;
  final double? imageHeight;

  const CommonImageTextWidget(
      {Key? key,
      required this.icon,
      required this.title,
      this.imageHeight,
      this.imageWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: imageWidth ?? context.getWidthByPercentage(64.16),
          height: imageHeight ?? context.getHeightByPercentage(27.42),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
