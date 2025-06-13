import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api_handler.dart';
import '../../model/consultant/payouts_model.dart';
import '../../utils/utils.dart';

part 'pay_out_state.dart';

class PayOutCubit extends Cubit<PayOutState> {
  Repository? repository;
  PayOutCubit({required this.repository}) : super(PayOutInitial());

  void getPayOutListFromRepo() async {
    if (!isClosed) {
      emit(PayOutLoading());
    }
 
    try {
      var result = await repository!.getPayOutListFromApi();
 
      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        PayOutModel payOutModel = PayOutModel.fromJson(result['responseBody']);
        if (!isClosed) {
          emit(PayOutSuccess(payOutModel: payOutModel));
        }
      } else {
        if (!isClosed) {
          emit(PayOutFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'get PayOut List cubit error ');
 
      if (!isClosed) {
        emit(PayOutError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }
}
