import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:videosdk/videosdk.dart';

import '../../cubit/all_cubits.dart';
import '../../model/calls/join_call_model.dart';
import '../../utils/utils.dart';

class InitiateCallScreen extends StatefulWidget {
  final String? callId;
  final String? displayName;
  const InitiateCallScreen({super.key, this.callId, this.displayName});

  @override
  State<InitiateCallScreen> createState() => _InitiateCallScreenState();
}

class _InitiateCallScreenState extends State<InitiateCallScreen> {
  JoinCallModel? joinCallModel;

  Room? room;
  bool isMicOn = true;
  bool isSpeakerOn = false;
  Duration callDuration = Duration.zero;
  Timer? callTimer;

  String meetingId = '';
  String token = '';

  dynamic eventPayload;

  initialCall() {
    BlocProvider.of<CallCubit>(context).joinCallWithRepo(widget.callId);
  }

  connectToPieSocket() {
    log('message pie socket');
    pieSocketService.connect(
      onMessage: (data) {
        log(data.toString(), name: 'end call event from piesocket');
        eventPayload = jsonDecode(data);

        log(eventPayload.runtimeType.toString(), name: 'event payload type');

        if (eventPayload['event']['event'] == 'call_ended') {
          room?.end();
          FlutterCallkitIncoming.endCall(widget.callId.toString());
          stopCallTimer();
          log('user cut the call');
          navigateUntil(context, AppRoutes.mainScreen);
        } else if (eventPayload['event']['event'] == 'call_cancelled') {
          FlutterCallkitIncoming.endCall(widget.callId.toString());
        }
      },
    );
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  Future<void> joinRoom() async {
    await Permission.microphone.request();

    room = VideoSDK.createRoom(
      roomId: meetingId,
      token: token,
      displayName: widget.displayName!,
      micEnabled: true,
      camEnabled: false,
      mode: Mode.SEND_AND_RECV,
    );

    room?.on(Events.roomJoined, () {
      log("Audio room joined");
    });

    room?.on(Events.participantJoined, () {
      startCallTimer();
    });

    room?.on(Events.participantLeft, () {
      BlocProvider.of<CallCubit>(
        context,
      ).sendEndCallRequestToRepo(widget.callId);
    });

    room?.on(Events.roomLeft, () {
      // Events.;
      // BlocProvider.of<CallCubit>(
      //   context,
      // ).sendEndCallRequestToRepo(widget.callId);
    });

    room?.join();
  }

  void toggleMic() {
    setState(() => isMicOn = !isMicOn);
    isMicOn ? room?.unmuteMic() : room?.muteMic();
  }

  Future<void> toggleSpeaker() async {
    setState(() => isSpeakerOn = !isSpeakerOn);

    final devices = await VideoSDK.getAudioDevices();
    if (devices == null) return;

    // Pick desired device
    final desiredDevice = devices.firstWhere(
      (d) =>
          d.kind == 'audiooutput' &&
          ((isSpeakerOn && d.label.toLowerCase().contains('speaker')) ||
              (!isSpeakerOn && d.label.toLowerCase().contains('earpiece'))),
      orElse: () => devices.firstWhere(
        (d) => d.kind == 'audiooutput',
        orElse: () => devices.first,
      ),
    );

    // Use the room instance to switch the audio route
    room?.switchAudioDevice(desiredDevice);
  }

  void endCall() {
    BlocProvider.of<CallCubit>(context).sendEndCallRequestToRepo(widget.callId);
    log('message');
  }

  void startCallTimer() {
    callTimer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        callDuration += Duration(seconds: 1);
      });
    });
  }

  void stopCallTimer() {
    callTimer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    initialCall();

    connectToPieSocket();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallCubit, CallState>(
      listener: (context, state) {
        if (state is JoinCallLoading) {
        } else if (state is JoinCallSuccess) {
          if (state.joinCallModel != null) {
            joinCallModel = state.joinCallModel;
            meetingId = joinCallModel!.meetingId.toString();
            token = joinCallModel!.token.toString();

            // joinMeeting(meetingId, token);
            joinRoom();
          }
        } else if (state is JoinCallFailed) {
          msg(context, state.failedMessage, AppMessageType.failed);
        } else if (state is JoinCallError) {
          msg(context, state.errorMessage, AppMessageType.failed);
        } else if (state is EndCallLoading) {
        } else if (state is EndCallSuccess) {
          room?.end();
          FlutterCallkitIncoming.endCall(widget.callId.toString());
          stopCallTimer();
          log('consult cut the call');
          navigateUntil(context, AppRoutes.mainScreen);
        } else if (state is EndCallFailed) {
          msg(context, state.failedMessage, AppMessageType.failed);
        } else if (state is EndCallError) {
          msg(context, state.errorMessage, AppMessageType.failed);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              verticalSpacer(height: AppDimensions.height(context) / 14),
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: AppDimensions.extraLargePadding,
                      child: Icon(
                        Icons.person,
                        size: AppDimensions.defaultIconSize,
                      ),
                    ),
                    verticalSpacer(height: AppDimensions.mediumPadding),
                    AppText(
                      text: widget.displayName,
                      size: AppFontSizes.titleSize(context),
                      weight: FontWeight.bold,
                      maxLine: 1,
                    ),
                    verticalSpacer(height: AppDimensions.defaultPadding),
                    AppText(
                      text: formatDuration(callDuration),
                      size: AppFontSizes.mediumSize(context),
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: toggleMic,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade400,
                        radius: AppDimensions.largePadding,
                        child: Icon(
                          isMicOn ? Icons.mic : Icons.mic_off,
                          color: Colors.white,
                          size: AppDimensions.defaultIconSize,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: endCall,
                      child: CircleAvatar(
                        radius: AppDimensions.largePadding,
                        child: Icon(
                          Icons.call_end,
                          color: Colors.red,
                          size: AppDimensions.defaultIconSize,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: toggleSpeaker,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade400,
                        radius: AppDimensions.largePadding,
                        child: Icon(
                          isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                          color: Colors.white,
                          size: AppDimensions.defaultIconSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpacer(height: AppDimensions.height(context) / 14),
            ],
          ),
        );
      },
    );
  }
}
