import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../cubit/all_cubits.dart';
import '../../model/calls/incoming_call_model.dart';
import '../../model/user/user_profile_model.dart';
import '../../utils/utils.dart';

class ConsultantHome extends StatefulWidget {
  const ConsultantHome({super.key});

  @override
  State<ConsultantHome> createState() => _ConsultantHomeState();
}

class _ConsultantHomeState extends State<ConsultantHome> {
  String callId = '';

  IcomingCallModel? incomingCall;

  dynamic eventPayload;

  int selectedIndex = 0;

  UserProfileModel? userProfileModel;

  void initialCall(BuildContext context) async {
    // Listen for CallKit events
    listenToCallEvents();

    var token = await AppHiveBox.appBox!.get(AppHiveKeys.accessTokenKey);

    socketService.onConnect = () {
      log('✅ Socket connected', name: 'consultant home');
    };

    socketService.onError = (err) {
      log('❌ Connection error: $err', name: 'consultant home');
    };

    socketService.onIncomingCall = (data) async {
      log('📞 Call Initiated: $data', name: 'consultant home');
      var encData = jsonEncode(data);
      log('icoming_call: $encData');

      incomingCall = IcomingCallModel.fromJson(data);
      setState(() {
        callId = incomingCall!.callId.toString();
      });
      BlocProvider.of<ConsultantHomeCubit>(context).getMetaDataFromRepo();
    };

    socketService.onCallAccepted = (data) {
      log('Call Accepted: $data', name: 'consultant home');
    };

    socketService.onCallCancelled = (data) {
      log('Call Cancelled: $data', name: 'consultant home');
      FlutterCallkitIncoming.endCall(callId.toString());
    };

    socketService.onCallDisconnect = (data) {
      log('Call Disconnect: $data', name: 'consultant home');
    };

    socketService.onCallEnded = (data) {
      log('Call Ended: $data', name: 'consultant home');
    };

    socketService.onCallMissed = (data) {
      log('Call Missed: $data', name: 'consultant home');
    };

    socketService.connectSocket(token);
  }

  connectToPieSocket() {
    log('message pie socket');
    pieSocketService.connect(
      onMessage: (data) {
        log(data.toString(), name: 'end call event from piesocket');
        eventPayload = jsonDecode(data);

        log(eventPayload.runtimeType.toString(), name: 'event payload type');

        if (eventPayload['event']['event'] == 'call_cancelled') {
          FlutterCallkitIncoming.endCall(callId.toString());
        }
      },
    );
  }

  void listenToCallEventsForThisScreen() {
    try {
      FlutterCallkitIncoming.onEvent.listen((event) {
        switch (event!.event) {
          case Event.actionCallDecline:
            BlocProvider.of<ConsultantHomeCubit>(
              context,
            ).rejectCallWithRepo(callId);
            break;
          default:
        }
      });
    } catch (e) {
      log(e.toString(), name: 'call event listen home');
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void showMyBottomSheet(BuildContext context) {
    double rating = 0.0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            padding: EdgeInsets.all(AppDimensions.defaultPadding),
            width: AppDimensions.width(context),
            child: StatefulBuilder(
              builder:
                  (context, setState) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        text: "Rate your experience",
                        color: AppColors.textPrimary,
                        size: AppFontSizes.mediumSize(context),
                        weight: FontWeight.w600,
                      ),
                      verticalSpacer(height: 16),

                      //  Star Rating
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder:
                            (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (value) {
                          setState(() {
                            rating = value;
                          });
                        },
                      ),

                      verticalSpacer(height: 24),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          log("User rated: $rating");
                          // You can trigger any submission logic here
                        },
                        child: Text("Submit"),
                      ),
                    ],
                  ),
            ),
          ),
        );
      },
    );
  }

  List intrestList = [
    {"name": "Vastu", "image": AppImages.vastuImagePng},
    {"name": "Vedic Astrology", "image": AppImages.vedicImagePng},
    {"name": "Horoscope", "image": AppImages.horoscopImagePng},
    {"name": "Graha Shanti", "image": AppImages.grahaImagePng},
  ];

  @override
  void initState() {
    super.initState();
    initialCall(context);
    connectToPieSocket();
    listenToCallEvents();
    BlocProvider.of<ConsultantHomeCubit>(context).getUserProfileRepo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantHomeCubit, ConsultantHomeState>(
      listener: (context, state) async {
        if (state is ConsultantHomeLoading) {
          showLoader(context);
        } else if (state is ConsultantHomeSuccess) {
          userProfileModel = state.userProfileModel;
          log(userProfileModel.toString(), name: "Get User Details");
        } else if (state is ConsultantHomeFailed) {
          msg(context, state.failedMessage, AppMessageType.failed);
        } else if (state is ConsultantHomeError) {
          msg(context, state.errorMessage, AppMessageType.failed);
        } else if (state is MetaDataLoading) {
        } else if (state is MetaDataSuccess) {
          clusterId =
              state.metaDataModel!.brandMeta!.piesocketClusterId.toString();

          apiKey = state.metaDataModel!.brandMeta!.piesocketApiKey.toString();

          callTimeout = state.metaDataModel!.brandMeta!.callTimeout! * 1000;
          BlocProvider.of<ConsultantHomeCubit>(
            context,
          ).getPieSocketTokenFromRepo(callId);
        } else if (state is MetaDataFailed) {
          msg(context, state.failedmessage, AppMessageType.failed);
        } else if (state is MetaDataError) {
          msg(context, state.errorMessage, AppMessageType.failed);
        } else if (state is PieSocketTokenLoading) {
        } else if (state is PieSocketTokenSuccess) {
          await showIncomingCall(incomingCall!);
          pieSocketUrl =
              'wss://$clusterId.piesocket.com/v3/call_$callId?api_key=$apiKey&jfw=${state.piesocketTokenModel!.data!.token.toString()}';
          pieSocketService.connect(onMessage: (data) {});
        } else if (state is PieSocketTokenFailed) {
          msg(context, state.failedMessage, AppMessageType.failed);
        } else if (state is PieSocketTokenError) {
          msg(context, state.errorMessage, AppMessageType.failed);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body:
                userProfileModel == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView(
                      padding: EdgeInsets.all(AppDimensions.defaultPadding),
                      children: [
                        verticalSpacer(height: AppDimensions.largePadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              child: Icon(
                                Icons.person_3_outlined,
                                size: AppDimensions.defaultIconSize,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text:
                                      userProfileModel!.user!.name!.toString(),
                                  size: AppFontSizes.contentSize(context),
                                  weight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                                AppText(
                                  text:
                                      "${userProfileModel!.user!.userRating.toString()} Star Rating",
                                  size: AppFontSizes.contentSize(context),
                                  weight: FontWeight.w300,
                                  color: AppColors.textPrimary,
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => showMyBottomSheet(context),
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                width: AppDimensions.width(context) / 4,
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AppText(
                                      text: "Online",
                                      size: AppFontSizes.contentSize(context),
                                      weight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        verticalSpacer(height: AppDimensions.defaultPadding),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: AppColors.secondaryLightColor,
                          ),
                          padding: EdgeInsets.all(AppDimensions.largePadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text:
                                    "₹ ${userProfileModel!.user!.totalEarned.toString()}",
                                size: AppFontSizes.headerSize(context),
                                weight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              verticalSpacer(height: AppDimensions.tinyPadding),

                              AppText(
                                text: "Total Earnings",
                                size: AppFontSizes.contentSize(context),
                                weight: FontWeight.w300,
                                color: AppColors.textPrimary,
                              ),
                            ],
                          ),
                        ),
                        verticalSpacer(height: AppDimensions.defaultPadding),
                        AppText(
                          text: "Your Interests",
                          size: AppFontSizes.contentSize(context),
                          weight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                        verticalSpacer(height: AppDimensions.defaultPadding),
                        GridView.builder(
                          itemCount: intrestList.length,
                          // itemCount: userProfileModel!.user!.topics!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                childAspectRatio: 3, // adjust as needed
                              ),
                          itemBuilder: (context, index) {
                            // var data = userProfileModel!.user!.topics!.toList();
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.0),
                                color: AppColors.secondaryLightColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(intrestList[index]['image']),
                                  horizontalSpacer(
                                    width: AppDimensions.defaultPadding,
                                  ),
                                  AppText(
                                    text: intrestList[index]['name'],
                                    size: AppFontSizes.contentSize(context),
                                    weight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        verticalSpacer(height: AppDimensions.defaultPadding),

                        AppText(
                          text: "Languages",
                          size: AppFontSizes.contentSize(context),
                          weight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                        verticalSpacer(height: AppDimensions.defaultPadding),
                        SizedBox(
                          height: AppDimensions.height(context) / 16,
                          child: Center(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  userProfileModel!.user!.languages!.length,
                              itemBuilder: (context, index) {
                                var data =
                                    userProfileModel!.user!.languages!.toList();
                                return Container(
                                  margin: EdgeInsets.only(
                                    right: AppDimensions.extraLargePadding,
                                  ),
                                  padding: EdgeInsets.all(
                                    AppDimensions.defaultPadding,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32.0),
                                    color: AppColors.secondaryLightColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText(
                                        text: data[index].languageIcon,
                                        size: AppFontSizes.contentSize(context),
                                        weight: FontWeight.bold,
                                      ),
                                      horizontalSpacer(
                                        width: AppDimensions.defaultPadding,
                                      ),
                                      AppText(
                                        text: data[index].languageName,
                                        size: AppFontSizes.contentSize(context),
                                        weight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        verticalSpacer(height: AppDimensions.defaultPadding),
                        Container(
                          padding: EdgeInsets.all(AppDimensions.tinyPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.0),
                            color: AppColors.green,
                          ),
                          child: AppText(
                            text: "You are Online now, Waiting for calls...",
                            size: AppFontSizes.contentSize(context),
                            weight: FontWeight.bold,
                            textAlign: TextAlign.center,
                            color: AppColors.white,
                          ),
                        ),
                        verticalSpacer(height: AppDimensions.defaultPadding),

                        AppText(
                          text:
                              "App Version - ${userProfileModel!.realtime!.version}",
                          size: AppFontSizes.contentSize(context),
                          weight: FontWeight.w400,
                          color: AppColors.textPrimary,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
          ),
        );
      },
    );
  }
}
