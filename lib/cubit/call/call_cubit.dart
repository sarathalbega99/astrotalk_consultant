import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api_handler.dart';
import '../../model/calls/end_call_model.dart';
import '../../model/calls/join_call_model.dart';
import '../../utils/utils.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  Repository? repository;
  CallCubit({required this.repository}) : super(CallInitial());

  void joinCallWithRepo(callId) async {
    if (!isClosed) {
      emit(JoinCallLoading());
    }

    try {
      var result = await repository!.joinCallWithAPI(callId);

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        JoinCallModel joinCallModel = JoinCallModel.fromJson(
          result['responseBody'],
        );

        if (!isClosed) {
          emit(JoinCallSuccess(joinCallModel: joinCallModel));
        }
      } else {
        if (!isClosed) {
          emit(JoinCallFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'join call cubit error');
      if (!isClosed) {
        emit(JoinCallError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }

  void sendEndCallRequestToRepo(callId) async {
    if (!isClosed) {
      emit(EndCallLoading());
    }
    try {
      var result = await repository!.endCallWithAPI(callId);

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        EndCallModel endCallModel = EndCallModel.fromJson(
          result['responseBody'],
        );
        if (!isClosed) {
          emit(EndCallSuccess(endCallModel: endCallModel));
        }
      } else {
        if (!isClosed) {
          emit(EndCallFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'end call cubit error');
    }
  }
}
