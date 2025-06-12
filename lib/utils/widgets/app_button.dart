import 'package:flutter/material.dart';

import '../constants/all_const.dart';
import 'all_widgets.dart';

class AppButton extends StatelessWidget {
  final String? buttonName;
  final EdgeInsets? margin;
  final Function()? onpress;
  final num? heights;
  final num? minWidth;
  final Color? color;
  final Color? txtColor;
  final double? txtSize;
  final Color? buttonBorderColor;
  final OutlinedBorder? borderRadius;
  final Widget? child;
  final Color? forgroundColor;
  final double? buttonElevation;
  final Color? shadowColor;

  const AppButton(
      {super.key,
      this.buttonName,
      this.margin,
      @required this.onpress,
      this.heights,
      this.color,
      this.minWidth,
      this.txtColor,
      this.buttonElevation,
      this.buttonBorderColor,
      this.txtSize,
      this.shadowColor,
      this.forgroundColor,
      this.borderRadius,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0.0),
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          elevation: buttonElevation ?? 4.0,
          foregroundColor: forgroundColor ?? AppColors.primaryColor,
          animationDuration: const Duration(milliseconds: 2000),
          shadowColor: shadowColor ?? Colors.grey,
          backgroundColor: color ?? AppColors.primaryColor,
          minimumSize: Size(minWidth ?? AppDimensions.width(context),
              heights ?? AppDimensions.height(context) / 16),
          shape: borderRadius ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.smallPadding)),
              ),
          //RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(4),
          // )
          side: BorderSide(color: buttonBorderColor ?? Colors.transparent),
        ),
        child: child ??
            AppText(
              text: buttonName,
              size: txtSize ?? AppFontSizes.contentSize(context),
              textAlign: TextAlign.center,
              weight: FontWeight.bold,
              color: txtColor ?? Colors.white,
              isTitle: true,
            ),
      ),
    );
  }
}