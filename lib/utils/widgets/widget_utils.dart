import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import '../utils.dart';

horizontalSpacer({double? width}) => SizedBox(width: width);

verticalSpacer({double? height}) => SizedBox(height: height);

customDivider(
  context, {
  double? width,
  double? rightIndent,
  double? leftIndent,
}) {
  return Container(
    height: AppDimensions.height(context) * 0.006,
    width: width ?? AppDimensions.width(context) / 3,
    margin:
        EdgeInsets.only(left: leftIndent ?? 112.0, right: rightIndent ?? 112.0),
    decoration: BoxDecoration(
      color: AppColors.light,
      borderRadius: BorderRadius.circular(AppDimensions.defaultPadding),
    ),
  );
}

selectImageSourceDialog(
  context, {
  void Function()? cameraTap,
  void Function()? fileTap,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.smallPadding),
    ),
    child: Padding(
      padding: EdgeInsets.all(AppDimensions.defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: "Choose From",
            size: AppFontSizes.titleSize(context),
            color: AppColors.textPrimary,
            weight: FontWeight.bold,
          ),
          verticalSpacer(height: AppDimensions.defaultPadding),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: Icon(
              Icons.camera_alt_outlined,
              color: AppColors.primaryColor,
            ),
            title: AppText(
              text: "Camera",
              size: AppFontSizes.contentSize(context),
            ),
            onTap: cameraTap,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: Icon(
              Icons.image,
              color: AppColors.primaryColor,
            ),
            title: AppText(
              text: "Photos",
              size: AppFontSizes.contentSize(context),
            ),
            onTap: fileTap,
          ),
        ],
      ),
    ),
  );
}

// Loader
showLoader(context) {
  try {
    OverlayLoadingProgress.start(
      context,
      barrierDismissible: false,
      barrierColor: Colors.white54,
      widget: Container(
        height: AppDimensions.height(context) / 18,
        width: AppDimensions.width(context) / 6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  } catch (e) {
    log(e.toString(), name: "erorro loade");
  }
}

hideLoader() {
  OverlayLoadingProgress.stop();
}


noWidget() => const SizedBox();