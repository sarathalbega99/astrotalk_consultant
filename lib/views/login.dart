// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/all_cubits.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileNumberController = TextEditingController();

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
              // navigateTo(context, AppRoutes.onboard);
              if (state.loginModel != null) {
                if (state.loginModel!.isConsultant == true) {
                  navigateUntil(context, AppRoutes.mainScreen);
                } else {
                  // navigateUntil(context, AppRoutes.userHome);
                }
                // navigateWithData(context, AppRoutes.verifyOtp, {
                //   'mobileNo': mobileNumberController.text,
                //   'isConsultant': state.loginModel!.isConsultant,
                // });
              }
            } else if (state is LoginFailed) {
              hideLoader();
              msg(context, state.failedMessage, AppMessageType.failed);
            } else if (state is LoginError) {
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
                  AppTextField(
                    prefix: AppText(
                      text: "+91",
                      size: AppFontSizes.defaultSize(context),
                      color: AppColors.textPrimary,
                    ),
                    controller: mobileNumberController,
                    // hint: 'Enter your mobile number',
                    maxLength: 10,
                    keyboardInputType: TextInputType.number,
                    formatter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
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
