import 'package:employee_app/core/context_extension.dart';
import 'package:flutter/material.dart';

/// Common SizedBox widget that will render based on percentage which we passed.
class PercentageSizeBox extends StatelessWidget {
  final double? widthInPer;
  final double? heightInPer;

  const PercentageSizeBox({Key? key, this.widthInPer, this.heightInPer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (widthInPer == null) {
      return SizedBox(
        height: context.getHeightByPercentage(heightInPer!),
      );
    } else {
      return SizedBox(
        width: context.getWidthByPercentage(widthInPer!),
      );
    }
  }
}
