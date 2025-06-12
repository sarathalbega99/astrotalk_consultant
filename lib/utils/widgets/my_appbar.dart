
import 'package:flutter/material.dart';

// import '../constants/all_const.dart';
import '../utils.dart';
import 'all_widgets.dart';

myAppBar(
  context, {
  Color? backgroundColor,
  FontWeight? weight,
  String? title,
  Widget? titleWidget,
  bool? centerTitle,
  Widget? leadingWidget,
  Color? leadingIconColor,
  Color? titleColor,
  bool? showLeading,
  List<Widget>? action,
  void Function()? leadingOnPress,
}) => PreferredSize(
  preferredSize: const Size.fromHeight(kToolbarHeight),
  child: AppBar(
    backgroundColor: backgroundColor ?? Colors.transparent,
    titleSpacing: 0.0,
    scrolledUnderElevation: 0.0,
    centerTitle: centerTitle ?? false,
    actions: action ?? [],
    leading:
        showLeading == true
            ? IconButton(
              onPressed: leadingOnPress,
              icon:
                  leadingWidget ??
                  Icon(Icons.arrow_back_ios, color: leadingIconColor),
            )
            : noWidget(),
    title:
        titleWidget ??
        AppText(
          text: title ?? "AppStrings.empty",
          size: AppFontSizes.mediumSize(context),
          weight: weight ?? FontWeight.w600,
          color: titleColor ?? AppColors.white,
        ),
  ),
);
