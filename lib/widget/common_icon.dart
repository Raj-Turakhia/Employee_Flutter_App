import 'package:employee_app/core/context_extension.dart';
import 'package:flutter/material.dart';

class CommonIconWidget extends StatelessWidget {
  final String icon;
  final double? imageWidth;
  final double? imageHeight;

  const CommonIconWidget(
      {Key? key, required this.icon, this.imageHeight, this.imageWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      width: imageWidth ?? context.getWidthByPercentage(5.88),
      height: imageHeight ?? context.getWidthByPercentage(5.88),
    );
  }
}
