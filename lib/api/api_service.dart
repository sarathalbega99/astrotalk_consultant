import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../model/error_message_model.dart';
import '../utils/utils.dart';

import 'package:http/http.dart' as http;

dynamic returnResponse(http.Response response) {
  log("statusCode: ${response.statusCode}");
  log("response body: ${response.body}");
  ErrorMessageModel? errorMessageModel;
  Map<String, dynamic>? localResponse;
  switch (response.statusCode) {
    case 200:
      Map<String, dynamic> responseJson = {
        "statusCode": 200,
        "responseBody": json.decode(utf8.decode(response.bodyBytes)),
      };
      return responseJson;
    case 201:
      Map<String, dynamic> responseJson = {
        "statusCode": 201,
        "responseBody": json.decode(utf8.decode(response.bodyBytes)),
      };
      return responseJson;
    case 400:
      localResponse = json.decode(utf8.decode(response.bodyBytes));
      if (localResponse!.containsKey("error")) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: localResponse["error"],
        );
      } else {
        errorMessageModel = ErrorMessageModel(errorMessage: "Bad Request");
      }
      return json.decode(jsonEncode(errorMessageModel));
    case 401:
      try {
        localResponse = json.decode(utf8.decode(response.bodyBytes));
      } catch (e) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: AppMessage.emptyResponseMessage,
        );
        log(e.toString(), name: "PARSE ERROR ::: ");
        return json.decode(jsonEncode(errorMessageModel));
      }
      if (localResponse!.containsKey("error")) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: localResponse["error"],
        );
      } else {
        errorMessageModel = ErrorMessageModel(errorMessage: "Bad Request");
      }
      return json.decode(jsonEncode(errorMessageModel));
    case 403:
      localResponse = json.decode(utf8.decode(response.bodyBytes));
      if (localResponse!.containsKey("error")) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: localResponse["error"],
        );
      } else {
        errorMessageModel = ErrorMessageModel(errorMessage: "Bad Request");
      }
      return json.decode(jsonEncode(errorMessageModel));
    case 404:
      localResponse = json.decode(utf8.decode(response.bodyBytes));
      if (localResponse!.containsKey("error")) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: localResponse["error"],
        );
      } else {
        errorMessageModel = ErrorMessageModel(errorMessage: "Not Found");
      }
      return json.decode(jsonEncode(errorMessageModel));
    case 409:
      localResponse = json.decode(utf8.decode(response.bodyBytes));
      if (localResponse!.containsKey("error")) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: localResponse["error"],
        );
      } else {
        errorMessageModel = ErrorMessageModel(errorMessage: "Conflict");
      }
      return json.decode(jsonEncode(errorMessageModel));
    case 413:
      localResponse = json.decode(utf8.decode(response.bodyBytes));
      if (localResponse!.containsKey("error")) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: localResponse["error"],
        );
      } else {
        errorMessageModel = ErrorMessageModel(
          errorMessage: "Request Entity Too Large",
        );
      }
      return json.decode(jsonEncode(errorMessageModel));
    case 422:
      localResponse = json.decode(utf8.decode(response.bodyBytes));
      if (localResponse!.containsKey("error")) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: localResponse["error"],
        );
      } else {
        errorMessageModel = ErrorMessageModel(errorMessage: "validation error");
      }
      return json.decode(jsonEncode(errorMessageModel));
    case 500:
      localResponse = json.decode(utf8.decode(response.bodyBytes));
      if (localResponse!.containsKey("error")) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: localResponse["error"],
        );
      } else {
        errorMessageModel = ErrorMessageModel(
          errorMessage: "Internal Server Error",
        );
      }
      return json.decode(jsonEncode(errorMessageModel));
    case 502:
      localResponse = json.decode(utf8.decode(response.bodyBytes));
      if (localResponse!.containsKey("error")) {
        errorMessageModel = ErrorMessageModel(
          errorMessage: localResponse["error"],
        );
      } else {
        errorMessageModel = ErrorMessageModel(errorMessage: "Bad Gateway");
      }
      return json.decode(jsonEncode(errorMessageModel));
    default:
      errorMessageModel = ErrorMessageModel(
        errorMessage:
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
      );
      return json.decode(jsonEncode(errorMessageModel));
  }
}

var client = http.Client();

enum HeaderType { accessToken }

api({
  @required String? method,
  @required String? url,
  Map<String, dynamic>? body,
  HeaderType? headerType,
}) async {
  dynamic responseJson;
  dynamic response;
  if (method!.toLowerCase().contains("post")) {
    log("URL  : $url");
    log("Method : POST");
    log("body: ${jsonEncode(body)}");
    response = await client.post(
      Uri.parse(url!),
      body: json.encode(body),
      headers:
          headerType == HeaderType.accessToken
              ? {
                HttpHeaders.authorizationHeader:
                    'Bearer ${await AppHiveBox.appBox!.get(AppHiveKeys.accessTokenKey)}',
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.acceptHeader: "application/json",
                HttpHeaders.accessControlAllowOriginHeader: '*',
              }
              : {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.acceptHeader: "application/json",
                HttpHeaders.accessControlAllowOriginHeader: '*',
              },
    );
    responseJson = returnResponse(response);
    return responseJson;
  } else if (method.toLowerCase().contains("get")) {
    log("URL  : $url");
    log("Method : get");
    response = await client.get(
      Uri.parse(url!),
      headers:
          headerType == HeaderType.accessToken
              ? {
                HttpHeaders.authorizationHeader:
                    'Bearer ${await AppHiveBox.appBox!.get(AppHiveKeys.accessTokenKey)}',
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.acceptHeader: "application/json",
                HttpHeaders.accessControlAllowOriginHeader: '*',
              }
              : {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.acceptHeader: "application/json",
                HttpHeaders.accessControlAllowOriginHeader: '*',
              },
    );
    return responseJson = returnResponse(response);
  }
}
