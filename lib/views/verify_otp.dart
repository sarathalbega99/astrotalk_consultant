// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otpless_headless_flutter/otpless_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/utils.dart';

class VerifyOtpScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  const VerifyOtpScreen({super.key, this.data});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final Otpless _otplessPlugin = Otpless();
  final TextEditingController otpController = TextEditingController();

  bool isVerified = false;
  bool isConsultant = false;
  String mobileNo = '';
  String response = '';

  @override
  void initState() {
    super.initState();

    mobileNo = widget.data!['mobileNo'];
    isConsultant = widget.data!['isConsultant'];

    requestSmsPermission();
    initialiseOtpless();
  }

  Future<void> requestSmsPermission() async {
    final status = await Permission.sms.request();
    if (status.isGranted) {
      log("SMS permission granted");
    } else {
      log("SMS permission denied");
    }
  }

  Future<bool> isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void initialiseOtpless() async {
    _otplessPlugin.initialize('O5HUA73OYG3VRZ38PR78', timeout: 60);
    _otplessPlugin.setResponseCallback(onOtplessResult);

    _otplessPlugin.start(onOtplessResult, {
      'phone': mobileNo,
      'countryCode': '91',
    });

    // _otplessPlugin.s();
  }

  void onOtplessResult(dynamic result) {
    log("OTPLESS RESULT: ${jsonEncode(result)}", name: 'OTPLESS');

    setState(() {
      response = jsonEncode(result);

      if (result['responseType'] == 'OTP_AUTO_READ') {
        final otp = result['response']['otp'];
        otpController.text = otp;
        log('Auto-Read OTP: $otp', name: "OTP");
      } else if (result['responseType'] == 'SUCCESS') {
        isVerified = true;
        log('OTP Verified Successfully!', name: "OTP");
      } else if (result['responseType'] == 'ERROR') {
        log('OTP Error: ${result['response']['message']}', name: "OTP");
      }
    });
  }

  void showToast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Container(
        padding: EdgeInsets.all(AppDimensions.defaultPadding),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalSpacer(height: AppDimensions.defaultPadding),
              AppText(
                text: 'Enter OTP received',
                size: AppFontSizes.secondaryHeaderSize(context),
                weight: FontWeight.bold,
                color: AppColors.textPrimary,
                textAlign: TextAlign.center,
              ),
              verticalSpacer(height: AppDimensions.defaultPadding),
              PinCodeTextField(
                appContext: context,
                controller: otpController,
                length: 6,
                obscureText: true,
                animationType: AnimationType.fade,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                onCompleted: (code) {
                  log('Manual OTP entered: $code', name: "OTP");
                },
                beforeTextPaste: (text) {
                  return text != null && RegExp(r'^[0-9]{6}$').hasMatch(text);
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldWidth: 40,
                  fieldHeight: 50,
                  borderRadius: BorderRadius.circular(10),
                  activeColor: Colors.blue,
                  selectedColor: Colors.blueAccent,
                  inactiveColor: Colors.grey,
                ),
              ),
              verticalSpacer(height: AppDimensions.defaultPadding),
              AppText(
                text: "Resend",
                size: AppFontSizes.mediumSize(context),
                color: AppColors.textPrimary,
                weight: FontWeight.w400,
                textAlign: TextAlign.left,
              ),
              verticalSpacer(height: AppDimensions.defaultPadding),
              AppButton(
                onpress: () async {
                  if (await isConnected()) {
                    if (otpController.text.length == 6) {
                      navigateTo(context, AppRoutes.mainScreen);
                      showToast(context, "OTP Entered: ${otpController.text}");
                    } else {
                      showToast(context, "Enter valid 6-digit OTP");
                    }
                  } else {
                    showToast(context, "No internet connection");
                  }
                },
                color: AppColors.border,
                buttonName: "Verify",
                txtSize: AppFontSizes.mediumSize(context),
              ),
              verticalSpacer(height: AppDimensions.defaultPadding),
              AppText(
                textAlign: TextAlign.center,
                maxLine: 3,
                text:
                    "By authenticating the mobile number you agreeing to \nour privacy policy and terms and conditions",
                size: AppFontSizes.contentSize(context),
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
