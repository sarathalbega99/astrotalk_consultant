import 'dart:developer';

import '../utils/utils.dart';
import 'api_service.dart';

abstract class Repository {
  Future login(mobileNo) async {}
  Future getActiveConsultantFromAPI() async {}
  Future startCallFromAPI(consultantId) async {}
  Future getMetaDataForCallFromAPI() async {}
  Future getPieSocketTokenFromAPI(callId) async {}
  Future getcallHistoryFromApi() async {}
  Future getUserProfileApi() async {}
  Future getNotificationFromApi() async {}

  Future joinCallWithAPI(callId) async {}
  Future endCallWithAPI(callId) async {}
  Future rejectCallWithAPI(callId) async {}
}

class ApiHandler implements Repository {
  @override
  Future login(mobileNo) async {
    Map<String, dynamic> loginResponse = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };

    Map<String, dynamic> requestParams = {
      "mobile_number": mobileNo,
      "country_code": "+91",
    };
    try {
      loginResponse = await api(
        method: 'post',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.loginEndpoint,
        body: requestParams,
      );
    } catch (e) {
      log(e.toString(), name: 'login api error');
    }

    return loginResponse;
  }

  @override
  Future getActiveConsultantFromAPI() async {
    Map<String, dynamic> activeConsultRes = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };
    try {
      activeConsultRes = await api(
        method: 'get',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.getActiveConsultantEndpoint,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: 'Get active consult API error');
    }

    return activeConsultRes;
  }

  @override
  Future startCallFromAPI(consultantId) async {
    Map<String, dynamic> startCallRes = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };

    Map<String, dynamic> requestParams = {"consultant_id": consultantId};

    try {
      startCallRes = await api(
        method: 'post',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.startCallEndpoint,
        body: requestParams,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: 'start call api error');
    }

    return startCallRes;
  }

  @override
  Future getMetaDataForCallFromAPI() async {
    Map<String, dynamic> metaDataRes = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };

    try {
      metaDataRes = await api(
        method: 'get',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.metaDataEndPoint,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: 'get meta data api error');
    }

    return metaDataRes;
  }

  @override
  Future getPieSocketTokenFromAPI(callId) async {
    Map<String, dynamic> response = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };

    try {
      response = await api(
        method: 'get',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.pieSocketTokenEndpoint +
            callId,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: 'pie socket token api error');
    }

    return response;
  }

  @override
  Future getcallHistoryFromApi() async {
    Map<String, dynamic> callHistoryRes = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };

    try {
      callHistoryRes = await api(
        method: 'get',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.callHistoryEndpoint,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: 'call history api error');
    }

    return callHistoryRes;
  }

  @override
  Future getUserProfileApi() async {
    Map<String, dynamic> userProfile = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };
    try {
      userProfile = await api(
        method: 'get',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.getProfileEndPoint,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: "userProfile API error");
    }
    return userProfile;
  }

  @override
  Future getNotificationFromApi() async {
    Map<String, dynamic> notification = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };
    try {
      notification = await api(
        method: 'get',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.getNotificatonendPoint,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: "Get Notification API error");
    }
    return notification;
  }

  @override
  Future joinCallWithAPI(callId) async {
    Map<String, dynamic> joinCallRes = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };

    Map<String, dynamic> requestParams = {"call_id": callId};

    try {
      joinCallRes = await api(
        method: 'post',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.joinCallEndpoint,
        body: requestParams,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: 'join call api error');
    }

    return joinCallRes;
  }

  @override
  Future endCallWithAPI(callId) async {
    Map<String, dynamic> endCallRes = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };

    Map<String, dynamic> requestParams = {"call_id": callId};

    try {
      endCallRes = await api(
        method: 'post',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.endCallEndpoint,
        body: requestParams,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: 'end call api error');
    }

    return endCallRes;
  }
  
  @override
  Future rejectCallWithAPI(callId)async {
     Map<String, dynamic> reejectCallRes = {
      'statusCode': 0,
      'errorMessage': AppMessage.messageUnknownError,
    };

    Map<String, dynamic> requestParams = {"call_id": callId};

    try {
      reejectCallRes = await api(
        method: 'post',
        url:
            const String.fromEnvironment('baseUrl') +
            AppEndpoints.rejectCallEndpoint,
        body: requestParams,
        headerType: HeaderType.accessToken,
      );
    } catch (e) {
      log(e.toString(), name: 'reject call api error');
    }

    return reejectCallRes;
  }
}
