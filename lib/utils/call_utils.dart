import 'dart:developer' as dev;
import 'package:astrotalk_consultant/model/calls/incoming_call_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import '../cubit/all_cubits.dart';
import '../views/screens.dart';
import 'utils.dart';

showIncomingCall(IcomingCallModel incomingCallModel) async {
  try {
    CallKitParams callKitParams = CallKitParams(
      id: incomingCallModel.callId,
      nameCaller: incomingCallModel.user!.name,
      appName: 'Astrology',
      handle: 'caller',
      type: 0,
      duration: callTimeout,
      textAccept: 'Accept',
      textDecline: 'Decline',
      extra: {
        'meeting_id': incomingCallModel.meetingId,
        'token': incomingCallModel.token,
      },
      android: AndroidParams(
        isCustomNotification: true,
        isShowLogo: true,
        ringtonePath: 'system_ringtone_default', // <== THIS IS KEY
        backgroundColor: '#000000',
        actionColor: '#34C759',
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
  } catch (e) {
    dev.log(e.toString(), name: 'consult call kit error');
  }
}

void listenToCallEvents() {
  try {
    FlutterCallkitIncoming.onEvent.listen((event) {
      switch (event!.event) {
        case Event.actionCallAccept:
          // final data = event.body['extra'];
          // final meetingId = data['meetingId'];
          // final token = data['token'];

          dev.log(event.toString(), name: 'event');

          // Navigate to call screen
          // e.g., context.read<NavigatorService>().navigateToCall(meetingId, token);

          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider(
                    create: (context) => CallCubit(repository: apiHandler),
                    child: InitiateCallScreen(callId: event.body['id']),
                  ),
            ),
            (route) => false,
          );
          break;

        case Event.actionCallDecline:
          // Handle decline6
          break;

        case Event.actionCallEnded:
          // Clean up
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider(
                    create:
                        (context) =>
                            ConsultantHomeCubit(repository: apiHandler),
                    child: ConsultantHome(),
                  ),
            ),
            (route) => false,
          );
          break;
        default:
      }
    });
  } catch (e) {
    dev.log(e.toString(), name: 'call event listen error');
  }
}
