import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/all_cubits.dart';
import '../../model/consultant/notification_model.dart';
import '../../utils/utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationModel? notificationModel;

  @override
  void initState() {
    BlocProvider.of<NotificationCubit>(context).getNotificatonsFromRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is NotificationLoading) {
          showLoader(context);
        } else if (state is NotificationSuccess) {
          notificationModel = state.notificationModel!;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: myAppBar(
            context,
            backgroundColor: AppColors.primaryColor,
            title: "Notification",
            weight: FontWeight.bold,
            titleColor: AppColors.textPrimary,
          ),
          body: notificationModel == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: notificationModel!.notifications!.length,
                  padding: EdgeInsets.all(AppDimensions.defaultPadding),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          notificationModel!.notifications![index].image
                              .toString(),
                        ),
                        onBackgroundImageError: (_, __) {
                          log("Image Load Failed");
                        },
                        // child: const Icon(Icons.person), // f
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: notificationModel!
                                .notifications![index]
                                .message
                                .toString(),
                            size: AppFontSizes.defaultSize(context),
                            weight: FontWeight.w400,
                          ),
                          AppText(
                            text: callDateTimeFormat(
                              notificationModel!
                                  .notifications![index]
                                  .createdAt
                                  .toString(),
                            ),
                            size: AppFontSizes.defaultSize(context),
                            weight: FontWeight.w300,
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
