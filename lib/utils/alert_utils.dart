import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants/all_const.dart';
import 'widgets/all_widgets.dart';

FToast? fToast;

enum AppMessageType { success, failed, warning }

enum BubbleType {
  /// Represents a sender's bubble displayed on the left side.
  sendBubble,

  /// Represents a receiver's bubble displayed on the right side.
  receiverBubble,
}

msg(context, msg, msgType) {
  fToast = FToast();
  fToast?.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: msgType == AppMessageType.failed
          ? Colors.red
          : msgType == AppMessageType.success
          ? Colors.green
          : Colors.amberAccent,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 0,
          child: msgType == AppMessageType.failed
              ? Icon(Icons.cancel, color: AppColors.white)
              : msgType == AppMessageType.success
              ? Icon(Icons.check, color: AppColors.white)
              : Icon(Icons.warning, color: AppColors.white),
        ),
        horizontalSpacer(width: AppDimensions.defaultPadding),
        Expanded(
          child: AppText(
            text: msg,
            size: AppFontSizes.contentSize(context),
            weight: FontWeight.bold,
            maxLine: 10,
            color: AppColors.white,
          ),
        ),
      ],
    ),
  );

  fToast?.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 3),
    gravity: ToastGravity.TOP,
  );
}

// connectivity
isConnected() async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity()
      .checkConnectivity());

  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  } else {
    return false;
  }
}
