import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double getWidthByPercentage(double percentage) {
    return MediaQuery.of(this).size.width * (percentage / 100);
  }

  double getHeightByPercentage(double percentage) {
    return MediaQuery.of(this).size.height * (percentage / 100);
  }

  bool isPhone() {
    var size = MediaQuery.of(this).size;
    return size.shortestSide <= 550;
  }

  dismissKeyboard(){
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
