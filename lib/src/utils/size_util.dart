import 'package:flutter/material.dart';

/// Use this class to perform common size-related tasks, such as converting between
/// different units (e.g., pixels and points), scaling sizes based on the device's
/// screen density, and more.
class SizeUtil {
  static late MediaQueryData _mediaQuery;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late double bottom;
  static late Orientation orientation;

  /// Initializes SizeUtil class
  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    screenWidth = _mediaQuery.size.width;
    screenHeight = _mediaQuery.size.height;
    orientation = _mediaQuery.orientation;
    bottom = _mediaQuery.viewInsets.bottom;
  }

  /// get dynamic height
  static double sizeHeight(double inputHeight) {
    double screenHeight = SizeUtil.screenHeight;
    return (inputHeight / 812.0) * screenHeight;
  }

  /// get dynamic width
  static double sizeWidth(double inputWidth) {
    double screenWidth = SizeUtil.screenWidth;
    return (inputWidth / 375.0) * screenWidth;
  }

  static double setDynamicHeight({required context, required value}) =>
      MediaQuery.of(context).size.height * value;

  static double setDynamicWidth({required context, required value}) =>
      MediaQuery.of(context).size.width * value;

  static double setLongestSide({required context, required value}) =>
      MediaQuery.of(context).size.longestSide * value;

  static double setShortestSide({required context, required value}) =>
      MediaQuery.of(context).size.shortestSide * value;
}
