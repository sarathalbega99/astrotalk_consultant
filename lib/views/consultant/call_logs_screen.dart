import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/all_cubits.dart';
import '../../model/calls/call_history_model.dart';
import '../../utils/utils.dart';

class CallLogsScreen extends StatefulWidget {
  const CallLogsScreen({super.key});

  @override
  State<CallLogsScreen> createState() => _CallLogsScreenState();
}

class _CallLogsScreenState extends State<CallLogsScreen> {
  CallHistoryModel? callHistoryModel;

  bool showRetry = false;

  String noCallMessage = '';

  initialCall() async {
    if (await isConnected() == true) {
      if (!mounted) return;
      BlocProvider.of<CallHistoryCubit>(context).getCallHistoryFromRepo();
    } else {
      if (!mounted) return;
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
    return BlocConsumer<CallHistoryCubit, CallHistoryState>(
      listener: (context, state) {
        if (state is CallHistoryLoading) {
          showLoader(context);
        } else if (state is CallHistorySuccess) {
          hideLoader();
          showRetry = false;
          if (state.callHistoryModel != null) {
            callHistoryModel = state.callHistoryModel;

            if (state.callHistoryModel!.calls!.isEmpty) {
              noCallMessage = "No calls found";
            }
          } else {
            noCallMessage = "No calls found";
          }
        } else if (state is CallHistoryFailed) {
          hideLoader();
          showRetry = true;
          msg(context, state.failedMessage, AppMessageType.failed);
        } else if (state is CallHistoryError) {
          hideLoader();
          showRetry = true;
          msg(context, state.errorMessage, AppMessageType.failed);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body:
              showRetry == true
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
                  : callHistoryModel != null &&
                      callHistoryModel!.calls!.isNotEmpty
                  ? ListView.builder(
                    itemCount: callHistoryModel!.calls!.length,
                    itemBuilder: (context, index) {
                      var data = callHistoryModel!.calls![index];
                      return ListTile(
                        leading: CircleAvatar(radius: 30),
                        title: AppText(
                          text: data.user!.name,
                          size: AppFontSizes.secondaryMediumSize(context),
                          weight: FontWeight.bold,
                        ),
                        subtitle: AppText(
                          text: callDateTimeFormat(data.initiatedDate),
                          size: AppFontSizes.contentSize(context),
                        ),

                        trailing:
                            data.status == 'missed' ||
                                    data.status == "cancelled" ||
                                    data.status == 'rejected'
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AppText(
                                      text:
                                          data.status.toString().toCapitalized,
                                      size: AppFontSizes.contentSize(context),
                                      weight: FontWeight.bold,
                                    ),
                                    verticalSpacer(
                                      height: AppDimensions.tinyPadding,
                                    ),
                                    AppText(
                                      text: data.consultantEarned,
                                      size: AppFontSizes.contentSize(context),
                                      weight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ],
                                )
                                : noWidget(),
                      );
                    },
                  )
                  : Center(
                    child: AppText(
                      text: noCallMessage,
                      size: AppFontSizes.contentSize(context),
                      weight: FontWeight.bold,
                    ),
                  ),
        );
      },
    );
  }
}
