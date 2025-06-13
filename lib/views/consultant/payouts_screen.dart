// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:astrotalk_consultant/model/consultant/payouts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/all_cubits.dart';
import '../../utils/utils.dart';

class PayoutsScreen extends StatefulWidget {
  const PayoutsScreen({super.key});

  @override
  State<PayoutsScreen> createState() => _PayoutsScreenState();
}

class _PayoutsScreenState extends State<PayoutsScreen> {
  PayOutModel? payOutModel;

  bool showRetry = false;

  String noPayoutMessage = '';

  initialCall() async {
    if (await isConnected() == true) {
      BlocProvider.of<PayOutCubit>(context).getPayOutListFromRepo();
    } else {
      msg(context, AppMessage.messageNoInternet, AppMessageType.warning);
      setState(() {
        showRetry = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initialCall();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayOutCubit, PayOutState>(
      listener: (context, state) {
        if (state is PayOutLoading) {
          showLoader(context);
        } else if (state is PayOutSuccess) {
          hideLoader();
          if (state.payOutModel != null) {
            showRetry = false;
            payOutModel = state.payOutModel;

            if (payOutModel!.payouts!.isEmpty) {
              noPayoutMessage = 'No payout available';
            }
          } else {
            showRetry = true;
          }
          log(payOutModel.toString(), name: "Get PayOut List");
        } else if (state is PayOutFailed) {
          hideLoader();
          showRetry = true;
          msg(context, state.failedMessage, AppMessageType.failed);
        } else if (state is PayOutError) {
          hideLoader();
          showRetry = true;
          msg(context, state.errorMessage, AppMessageType.failed);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: showRetry == true
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: 'Tap on Retry',
                        size: AppFontSizes.contentSize(context),
                      ),
                      GestureDetector(
                        onTap: initialCall,
                        child: AppText(
                          text: 'RETRY',
                          size: AppFontSizes.contentSize(context),
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                        padding: EdgeInsets.all(AppDimensions.defaultPadding),
                        width: AppDimensions.width(context),
                        color: Colors.amber.shade200,
                        child: AppText(
                          textAlign: TextAlign.center,
                          text:
                              'Earnings will be credited based on the schedule',
                          size: AppFontSizes.contentSize(context),
                        ),
                      ),
                    ),
                    payOutModel != null && payOutModel!.payouts!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: payOutModel!.payouts!.length,
                              itemBuilder: (context, index) {
                                var data = payOutModel!.payouts![index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: AppDimensions.largePadding,
                                  ),
                                  title: AppText(
                                    text: data.id!,
                                    size: AppFontSizes.secondaryMediumSize(
                                      context,
                                    ),
                                    weight: FontWeight.bold,
                                  ),
                                  subtitle: AppText(
                                    text: data.status,
                                    size: AppFontSizes.contentSize(context),
                                    weight: FontWeight.bold,
                                  ),

                                  trailing: AppText(
                                    text: "₹ ${data.amount}",
                                    size: AppFontSizes.contentSize(context),
                                    weight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                );
                              },
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: AppText(
                                text: noPayoutMessage,
                                size: AppFontSizes.contentSize(context),
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ],
                ),
        );
      },
    );
  }
}
