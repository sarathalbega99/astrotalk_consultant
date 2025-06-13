import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api_handler.dart';
import '../../model/calls/meta_data_model.dart';
import '../../model/calls/pie_socket_token_model.dart';
import '../../model/consultant/user_profile_model.dart';
import '../../utils/utils.dart';

part 'consultant_home_state.dart';

class ConsultantHomeCubit extends Cubit<ConsultantHomeState> {
  Repository? repository;
  ConsultantHomeCubit({required this.repository})
    : super(ConsultantHomeInitial());

  void getMetaDataFromRepo() async {
    if (!isClosed) {
      emit(MetaDataLoading());
    }

    try {
      var result = await repository!.getMetaDataForCallFromAPI();

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        MetaDataModel metaDataModel = MetaDataModel.fromJson(
          result['responseBody'],
        );
        if (!isClosed) {
          emit(MetaDataSuccess(metaDataModel: metaDataModel));
        }
      } else {
        if (!isClosed) {
          emit(MetaDataFailed(failedmessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'get meta data cubit error consult');

      if (!isClosed) {
        emit(MetaDataError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }

  void getPieSocketTokenFromRepo(callId) async {
    if (!isClosed) {
      emit(PieSocketTokenLoading());
    }

    try {
      var result = await repository!.getPieSocketTokenFromAPI(callId);

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        PiesocketTokenModel piesocketTokenModel = PiesocketTokenModel.fromJson(
          result['responseBody'],
        );

        if (!isClosed) {
          emit(PieSocketTokenSuccess(piesocketTokenModel: piesocketTokenModel));
        }
      } else {
        if (!isClosed) {
          emit(PieSocketTokenFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'pie socket token cubit error consult');

      if (!isClosed) {
        emit(PieSocketTokenError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }

  void rejectCallWithRepo(callId) async {
    if (!isClosed) {
      emit(RejectCallLoading());
    }
    try {
      var result = await repository!.rejectCallWithAPI(callId);

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        if (!isClosed) {
          emit(RejectCallSuccess());
        }
      } else {
        if (!isClosed) {
          emit(RejectCallFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'pie socket token cubit error consult');

      if (!isClosed) {
        emit(RejectCallError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }

  void getUserProfileRepo() async {
    if (!isClosed) {
      emit(ConsultantHomeLoading());
    }
    try {
      var result = await repository!.getUserProfileApi();
      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        UserProfileModel userProfileModel = UserProfileModel.fromJson(
          result['responseBody'],
        );
        if (!isClosed) {
          emit(ConsultantHomeSuccess(userProfileModel: userProfileModel));
        }
      } else {
        if (!isClosed) {
          emit(ConsultantHomeFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: "get user profile cubit error");
      if (!isClosed) {
        emit(ConsultantHomeError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }

  void changePrefWithRepo(pref) async {
    if (!isClosed) {
      emit(ChangePrefLoading());
    }

    try {
      var result = await repository!.changePrefWithAPI(pref);

      if (result['statusCode'] == 200 || result['statusCode'] == 201) {
        if (!isClosed) {
          emit(ChangePrefSuccess());
        }
      } else {
        if (!isClosed) {
          emit(ChangePrefFailed(failedMessage: result['errorMessage']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'change pref cubit error');
      if (!isClosed) {
        emit(ChangePrefError(errorMessage: AppMessage.messageUnknownError));
      }
    }
  }
}
