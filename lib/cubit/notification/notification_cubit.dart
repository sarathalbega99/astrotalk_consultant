import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api_handler.dart';
import '../../model/consultant/notification_model.dart';
import '../../utils/utils.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  Repository? repository;
  NotificationCubit({required this.repository}) : super(NotificationInitial());
  void getNotificatonsFromRepo() async {
    if (!isClosed) {
      emit(NotificationLoading());
    }

    try {
      var result = await repository!.getNotificationFromApi();

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        NotificationModel notificationModel = NotificationModel.fromJson(
          result['responseBody'],
        );
        if (!isClosed) {
          emit(NotificationSuccess(notificationModel: notificationModel));
        }
      } else {
        if (!isClosed) {
          emit(NotificationFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'get meta data cubit error consult');

      if (!isClosed) {
        emit(NotificationError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }
}
