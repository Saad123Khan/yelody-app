import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/shared_prefernces.dart';
import 'package:yelody_app/utils/app_dialogs.dart';

import 'connectivity_manager.dart';

class Network {
  static Dio? _dio;
  static CancelToken? _cancelRequestToken;

  static Network? _network;

  static ConnectivityManager? _connectivityManager;

  Network._createInstance();

  factory Network() {
    // factory with constructor, return some value
    if (_network == null) {
      _network = Network
          ._createInstance(); // This is executed only once, singleton object

      _dio = _getDio();
      _dio?.interceptors.add(LogInterceptor());
      _cancelRequestToken = _getCancelToken();

      _connectivityManager = ConnectivityManager();
    }
    return _network!;
  }

  static Dio _getDio() {
    BaseOptions options = BaseOptions(
      connectTimeout: 5000000,
    );
    return _dio ??= Dio(options);
  }

  static CancelToken _getCancelToken() {
    return _cancelRequestToken ??= CancelToken();
  }

  ////////////////// Get Request /////////////////////////
  Future<Response?> getRequest(
      {required BuildContext context,
      required String endPoint,
      Map<String, dynamic>? queryParameters,
      VoidCallback? onFailure,
      bool isToast = true,
      String? fullURlm,
      bool isErrorToast = true,
      int connectTimeOut = 5000000,
      required bool isHeaderRequire}) async {
    Response? response;

    if (await _connectivityManager!.isInternetConnected()) {
      try {
        _dio?.options.connectTimeout = connectTimeOut;
        response =
            await _dio!.get(fullURlm ?? NetworkStrings.baseUrl + endPoint,
                queryParameters: queryParameters,
                cancelToken: _cancelRequestToken,
                options: Options(
                  headers: _setHeader(isHeaderRequire: isHeaderRequire),
                  sendTimeout: connectTimeOut,
                  receiveTimeout: connectTimeOut,
                ));
        //print(response);
      } on DioError catch (e) {
        validateException(
            response: e.response,
            context: context,
            message: e.message,
            onFailure: onFailure,
            isToast: isToast,
            isErrorToast: isErrorToast);
        print("$endPoint Dio: ${e.message}");
      }
    } else {
      _noInternetConnection(onFailure: onFailure);
    }

    return response;
  }

  ////////////////// Post Request /////////////////////////
  Future<Response?> postRequest({
    required BuildContext context,
    required String endPoint,
    dynamic formData,
    String? contenType,
    Map<String, dynamic>? mapHeader,
    VoidCallback? onFailure,
    bool isToast = true,
    String? fullUrl,
    int connectTimeOut = 5000000,
    bool isErrorToast = true,
    required bool isHeaderRequire,
  }) async {
    Response? response;

    if (await _connectivityManager!.isInternetConnected()) {
      try {
        _dio?.options.connectTimeout = connectTimeOut;
        response =
            await _dio!.post(fullUrl ?? NetworkStrings.baseUrl + endPoint,
                data: formData,
                cancelToken: _cancelRequestToken,
                options: Options(
                    contentType: contenType,
                    headers: mapHeader,
                    // headers: _setHeader(isHeaderRequire: isHeaderRequire),
                    sendTimeout: connectTimeOut,
                    receiveTimeout: connectTimeOut));

        log("RESPONSE RECEIVED ${response.data}");
      } on DioError catch (e) {
        response = e.response;
        log("RESPONSE RECEIVED ${e.error.toString()}");
        log("Error Response RECEIVED ${e.response.toString()}");

        // ignore: use_build_context_synchronously
        validateException(
            response: e.response,
            context: context,
            message: e.message,
            onFailure: onFailure,
            isToast: isToast,
            isErrorToast: isErrorToast);
        // print("$endPoint Dio: ${e.message}");
      }
    } else {
      _noInternetConnection(onFailure: onFailure);
    }
    return response;
  }

  ////////////////// Put Request /////////////////////////
  Future<Response?> putRequest(
      {required BuildContext context,
      required String endPoint,
      Map<String, dynamic>? queryParameters,
      dynamic data,
      VoidCallback? onFailure,
      bool isToast = true,
      int connectTimeOut = 5000000,
      bool isErrorToast = true,
      required bool isHeaderRequire}) async {
    Response? response;

    if (await _connectivityManager!.isInternetConnected()) {
      try {
        _dio?.options.connectTimeout = connectTimeOut;
        response = await _dio!.put(NetworkStrings.baseUrl + endPoint,
            queryParameters: queryParameters,
            data: data,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: _setHeader(isHeaderRequire: isHeaderRequire),
                sendTimeout: connectTimeOut,
                receiveTimeout: connectTimeOut));
        //print(response);
      } on DioError catch (e) {
        response = e.response;
        validateException(
            response: e.response,
            context: context,
            message: e.message,
            onFailure: onFailure,
            isToast: isToast,
            isErrorToast: isErrorToast);
        print("$endPoint Dio: ${e.message}");
      }
    } else {
      _noInternetConnection(onFailure: onFailure);
    }

    return response;
  }

  ////////////////// Delete Request /////////////////////////
  Future<Response?> deleteRequest(
      {required BuildContext context,
      required String endPoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      VoidCallback? onFailure,
      bool isToast = true,
      int connectTimeOut = 5000000,
      bool isErrorToast = true,
      required bool isHeaderRequire}) async {
    Response? response;
    if (await _connectivityManager!.isInternetConnected()) {
      try {
        _dio?.options.connectTimeout = connectTimeOut;
        response = await _dio!.delete(NetworkStrings.baseUrl + endPoint,
            queryParameters: queryParameters,
            data: data,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: _setHeader(isHeaderRequire: isHeaderRequire),
                sendTimeout: connectTimeOut,
                receiveTimeout: connectTimeOut));
        // print(response.toString());
      } on DioError catch (e) {
        // validateException(
        //     response: e.response,
        //     context: context,
        //     message: e.message,
        //     onFailure: onFailure,
        //     isToast: isToast,
        //     isErrorToast: isErrorToast);
        // print("$endPoint Dio: " + e.message);
      }
    } else {
      _noInternetConnection(onFailure: onFailure);
    }
    return response;
  }

  ////////////////// Set Header /////////////////////
  _setHeader({required bool isHeaderRequire}) {
    if (isHeaderRequire == true) {
      String token = SharedPreference().getBearerToken() ?? "";
      return {
        'Accept': NetworkStrings.ACCEPT,
        // 'Authorization': "Bearer $token",
      };
    } else {
      return {
        'Accept': NetworkStrings.ACCEPT,
      };
    }
  }

  ////////////////// Validate Response /////////////////////
  void validateResponse(
      {Response? response,
      VoidCallback? onSuccess,
      VoidCallback? onFailure,
      bool isToast = true}) {
    var validateResponseData = response?.data;

    if (validateResponseData != null) {
      isToast
          ? AppDialogs.showToast(message: validateResponseData['message'] ?? "")
          : null;

      if (response!.statusCode == NetworkStrings.SUCCESS_CODE ||
          response.statusCode == NetworkStrings.SUCCESS_CODE_CREATED) {
        // if (validateResponseData['success'] ==
        //     NetworkStrings.API_SUCCESS_STATUS) {
        //   if (onSuccess != null) {
        //     print("ON SUCESSS M CHALA GYAA");
        //     onSuccess();
        //   }
        // } else {
        //   if (onFailure != null) {
        //     print("ON Failureeee M CHALA GYAA");
        //     onFailure();
        //   }
        // }

        if (onSuccess != null) {
          onSuccess();
        }
      } else if (response.statusCode == NetworkStrings.NOT_FOUND_CODE) {
        ///404 Not Found
        if (onFailure != null) {
          onFailure();
        }
      } else {
        if (onFailure != null) {
          onFailure();
        }
        //log(response.statusCode.toString());
      }
    }
  }

  ////////////////// Stripe Validate Response /////////////////////
  void stripeValidateResponse(
      {Response? response, VoidCallback? onSuccess, VoidCallback? onFailure}) {
    var validateResponseData = response?.data;

    if (validateResponseData != null) {
      if (response!.statusCode == NetworkStrings.SUCCESS_CODE) {
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        if (onFailure != null) {
          onFailure();
        }
        //log(response.statusCode.toString());
      }
    }
  }

  ////////////////// Validate Response /////////////////////
  void validateGifResponse(
      {Response? response, VoidCallback? onSuccess, VoidCallback? onFailure}) {
    var validateResponseData = response?.data;

    if (validateResponseData != null) {
      if (response!.statusCode == NetworkStrings.SUCCESS_CODE) {
        if (onSuccess != null) {
          onSuccess();
        }
      }
    } else {
      if (onFailure != null) {
        onFailure();
      }
      //log(response!.statusCode!.toString());
    }
  }

  ////////////////// Validate Exception /////////////////////
  void validateException(
      {required BuildContext context,
      Response? response,
      String? message,
      bool normalRequest = true,
      bool isToast = true,
      bool isErrorToast = true,
      VoidCallback? onFailure}) {
    // if (onFailure != null) {
    //   onFailure();
    // }

    // print("Fail Ho rhaa Hai Rewsponse ${response!.data}");
    if (response?.statusCode == NetworkStrings.CARD_ERROR_CODE) {
      AppDialogs.showToast(
          message: response?.data["error"]["message"] ??
              NetworkStrings.INVALID_CARD_ERROR);
    } else if (response?.statusCode == NetworkStrings.BAD_REQUEST_CODE) {
      //to check normal api or stripe bad request error
      if (normalRequest == true) {
        //for normal api request error
        isToast
            ? AppDialogs.showToast(message: response?.data["message"] ?? "")
            : null;
      } else {
        //for stripe bad request error
        AppDialogs.showToast(
            message: response?.data["error"]["message"] ??
                NetworkStrings.INVALID_BANK_ACCOUNT_DETAILS_ERROR);
      }
    } else if (response?.statusCode == NetworkStrings.FORBIDDEN_CODE) {
      //to check normal api or stripe bad request error
      AppDialogs.showToast(message: response?.data["message"] ?? "");
    } else if (response?.statusCode == NetworkStrings.NOT_FOUND_CODE) {
    } else {
      isErrorToast
          ? AppDialogs.showToast(
              message: response?.statusMessage ?? message.toString())
          : null;
    }
    if (response?.statusCode == NetworkStrings.UNAUTHORIZED_CODE) {
      // StaticData.clearAppDataMethod();
      /*    AppNavigation.navigateToRemovingAll(context, PreLoginScreen());
      SharedPreference().clear();



      Provider.of<UserProvider>(context,listen: false).setCurrentUser(user: null);*/
    }
  }

  ////////////////// No Internet Connection /////////////////////
  void _noInternetConnection({VoidCallback? onFailure}) {
    if (onFailure != null) {
      onFailure();
    }
    AppDialogs.showToast(message: NetworkStrings.NO_INTERNET_CONNECTION);
  }

  Future<Response?> downloadFile(
      {bool isToast = false,
      Function()? onSuccess,
      required String endpoint,
      bool errorToast = false,
      Function()? onFailure,
      required BuildContext context,
      required Map<String, dynamic> queryParameters}) async {
    Response? resp;

    if (await _connectivityManager!.isInternetConnected()) {
      try {
        _dio?.options.connectTimeout = 2000000;
        resp = await _dio!.get(endpoint,
            queryParameters: queryParameters,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: _setHeader(isHeaderRequire: false),
                responseType: ResponseType.plain));

        // onSuccess?.call();
      } on DioError catch (e) {
        resp = e.response;

        // onFailure?.call();
        // validateException(
        //     response: e.response,
        //     context: context,
        //     message: e.message,
        //     onFailure: onFailure,
        //     isToast: isToast,
        //     isErrorToast: errorToast);
        print("$endpoint Dio: ${e.message}");
      }
    } else {
      _noInternetConnection(onFailure: onFailure);
    }

    return resp;
  }

// ////////////////// On TimeOut /////////////////////
// void _onTimeOut({String message, onFailure}) {
//   if (onFailure != null) {
//     onFailure();
//   }
//   AppDialogs.showToast(message: message);
// }
}
