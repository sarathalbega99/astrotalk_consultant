import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api_handler.dart';
import '../../model/login_model.dart';
import '../../utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  Repository? repository;
  AuthCubit({required this.repository}) : super(AuthInitial());

  void loginWithRepo(mobileNo) async {
    if (!isClosed) {
      emit(LoginLoading());
    }
    try {
      var result = await repository!.login(mobileNo);

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        LoginModel loginModel = LoginModel.fromJson(result['responseBody']);

        AppHiveBox.appBox?.put(
          AppHiveKeys.accessTokenKey,
          loginModel.accessToken,
        );
        if (!isClosed) {
          emit(LoginSuccess(loginModel: loginModel));
        }
      } else {
        if (!isClosed) {
          emit(LoginFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'login cubit error');
      if (!isClosed) {
        emit(LoginError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }

  void sendOnboardDetailToRepo(name, dob, gender) async {
    try {} catch (e) {
      log(e.toString(), name: 'onboard cubit error');
    }
  }

  void sendDeviceInfoToRepo(data) async {
    if (!isClosed) {
      emit(SendDeviceInfoLoading());
    }

    try {
      var result = await repository!.sendDeviceInfoToAPI(data);

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        if (!isClosed) {
          emit(SendDeviceInfoSuccess());
        }
      } else {
        if (!isClosed) {
          emit(SendDeviceInfoFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'device info cubit error');

      if (!isClosed) {
        emit(SendDeviceInfoError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }
}
