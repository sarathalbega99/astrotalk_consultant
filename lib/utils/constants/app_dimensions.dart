import 'package:flutter/cupertino.dart';

class AppDimensions {
  static height(context) => MediaQuery.of(context).size.height;

  static width(context) => MediaQuery.of(context).size.width;

  static double tinyPadding = 4.0;
  static double smallPadding = 8.0;
  static double defaultPadding = 16.0;
  static double mediumPadding = 24.0;
  static double largePadding = 32.0;
  static double extraLargePadding = 48.0;

  static double defaultIconSize = 32.0;

}