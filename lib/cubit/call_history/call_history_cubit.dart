import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api_handler.dart';
import '../../model/calls/call_history_model.dart';
import '../../utils/utils.dart';

part 'call_history_state.dart';

class CallHistoryCubit extends Cubit<CallHistoryState> {
  Repository? repository;
  CallHistoryCubit({required this.repository}) : super(CallHistoryInitial());

  void getCallHistoryFromRepo() async {
    if (!isClosed) {
      emit(CallHistoryLoading());
    }

    try {
      var result = await repository!.getcallHistoryFromApi();

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        CallHistoryModel callHistoryModel = CallHistoryModel.fromJson(
          result['responseBody'],
        );
        if (!isClosed) {
          emit(CallHistorySuccess(callHistoryModel: callHistoryModel));
        }
      } else {
        if (!isClosed) {
          emit(CallHistoryFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'call history cubit error');

      if (!isClosed) {
        emit(CallHistoryError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }
}
