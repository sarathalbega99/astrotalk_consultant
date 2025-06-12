import 'all_const.dart';

class AppFontSizes {
  static double smallSize(context) => AppDimensions.width(context) * 0.02;

  static double secodaryTextSize(context) =>
      AppDimensions.width(context) * 0.025;

  static double defaultSize(context) => AppDimensions.width(context) * 0.03;

  static double contentSize(context) => AppDimensions.width(context) * 0.035;

  static double mediumSize(context) => AppDimensions.width(context) * 0.04;

  static double secondaryMediumSize(context) =>
      AppDimensions.width(context) * 0.04;

  static double titleSize(context) => AppDimensions.width(context) * 0.05;

  static double headerSize(context) => AppDimensions.width(context) * 0.06;

  static double secondaryHeaderSize(context) =>
      AppDimensions.width(context) * 0.08;
}
