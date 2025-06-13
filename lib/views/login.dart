// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';

import 'package:astrotalk_consultant/model/login_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../cubit/all_cubits.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileNumberController = TextEditingController();

  String countryCode = '+91';

  dynamic data;
  LoginModel? loginModel;

  Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      log(androidInfo.toString(), name: 'info');

      setState(() {
        data = {
          "device_id": androidInfo.id,
          "device_type": "mobile",
          "device_os": "android",
          "device_model": androidInfo.model,
          "os_version": androidInfo.version.release,
          "app_version": "1.0.0",
          "notification_enabled": false,
          "is_physical_device": androidInfo.isPhysicalDevice,
          "is_low_ram_device": androidInfo.isLowRamDevice,
          "physical_ram_size": androidInfo.physicalRamSize.toString(),
          "available_ram_size": androidInfo.availableRamSize.toString(),
        };
      });
      return data;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;

      setState(() { 
        data = {
          "device_id": iosInfo.identifierForVendor,
          "device_type": "mobile",
          "device_os": "iOS",
          "device_model": iosInfo.utsname.machine,
          "os_version": iosInfo.systemVersion,
          "app_version": "1.0.0",
          "notification_enabled": false,
          "is_physical_device": iosInfo.isPhysicalDevice,
          "is_low_ram_device": false, // iOS does not expose this
          "physical_ram_size": iosInfo.utsname.nodename,
          "available_ram_size": "Unknown",
        };
      });
      return data;
    } else {
      return {"error": "Unsupported platform"};
    }
  }

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.defaultBackground,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              showLoader(context);
            } else if (state is LoginSuccess) {
              hideLoader();

              if (state.loginModel != null) {
                loginModel = state.loginModel;

                BlocProvider.of<AuthCubit>(context).sendDeviceInfoToRepo(data);
              }
              // navigateTo(context, AppRoutes.onboard);
            } else if (state is LoginFailed) {
              hideLoader();
              msg(context, state.failedMessage, AppMessageType.failed);
            } else if (state is LoginError) {
              msg(context, state.errorMessage, AppMessageType.failed);
            } else if (state is SendDeviceInfoLoading) {
              showLoader(context);
            } else if (state is SendDeviceInfoSuccess) {
              hideLoader();
              if (loginModel != null) {
                if (loginModel!.isConsultant == true) {
                  navigateUntil(context, AppRoutes.mainScreen);
                } else {
                  // navigateUntil(context, AppRoutes.userHome);
                }
                // navigateWithData(context, AppRoutes.verifyOtp, {
                //   'countryCode': countryCode,
                //   'mobileNo': mobileNumberController.text,
                //   'isConsultant': state.loginModel!.isConsultant,
                // });
              }
            } else if (state is SendDeviceInfoFailed) {
              hideLoader();
              msg(context, state.failedMessage, AppMessageType.failed);
            } else if (state is SendDeviceInfoError) {
              hideLoader();
              msg(context, state.errorMessage, AppMessageType.failed);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(AppDimensions.mediumPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset(AppImages.loginImagePng),

                  // // SvgPicture.asset(AppImages.loginImage),
                  // AppText(
                  //   text: 'Connect. Engage.\n and Get Paid',
                  //   size: AppFontSizes.secondaryHeaderSize(context),
                  //   weight: FontWeight.bold,
                  // ),
                  // verticalSpacer(height: AppDimensions.defaultPadding),
                  AppText(
                    text: 'Enter your mobile number',
                    size: AppFontSizes.headerSize(context),
                    weight: FontWeight.bold,
                  ),
                  verticalSpacer(height: AppDimensions.defaultPadding),

                  // AppTextField(
                  //   controller: mobileNumberController,
                  //   // hint: 'Enter your mobile number',
                  //   maxLength: 10,
                  //   keyboardInputType: TextInputType.number,
                  //   formatter: <TextInputFormatter>[
                  //     FilteringTextInputFormatter.digitsOnly,
                  //   ],
                  // ),
                  IntlPhoneField(
                    controller: mobileNumberController,
                    initialCountryCode: 'IN',
                    onCountryChanged: (value) {
                      setState(() {
                        countryCode = '+${value.dialCode}';
                      });
                    },
                    onChanged: (phone) {
                      log(phone.number);
                    },
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      counterText: '',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.textPrimary,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.red.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.border,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),

                      errorStyle: TextStyle(
                        fontSize: AppFontSizes.defaultSize(context),
                        color: Colors.red.shade300,
                      ),
                      hintStyle: TextStyle(
                        color: AppColors.hintText,
                        fontSize: AppFontSizes.defaultSize(context),
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: const EdgeInsets.all(16.0),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.red.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  verticalSpacer(height: AppDimensions.mediumPadding),
                  AppButton(
                    onpress: () async {
                      if (await isConnected()) {
                        BlocProvider.of<AuthCubit>(
                          context,
                        ).loginWithRepo(mobileNumberController.text);
                      } else {
                        msg(
                          context,
                          AppMessage.messageNoInternet,
                          AppMessageType.warning,
                        );
                      }
                    },
                    color: AppColors.border,
                    buttonName: "Login",
                    txtSize: AppFontSizes.mediumSize(context),
                  ),
                  verticalSpacer(height: AppDimensions.defaultPadding),
                  AppText(
                    text:
                        'By entering the mobile number you agreeing to our privacy policy and terms and conditions',
                    size: AppFontSizes.defaultSize(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
