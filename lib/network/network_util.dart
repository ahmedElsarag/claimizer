import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:Cliamizer/CommonUtils/log_utils.dart';
import 'package:Cliamizer/network/api/network_api.dart';

import 'exception/error_status.dart';
import 'exception/exception_handle.dart';
import 'interceptors.dart';
import 'net_response.dart';

//Set default Header Not configured User-Agent Eye open API 403
Map<String, dynamic> headers = {
  "Accept": "application/json",
  "User-Agent": "insomnia/6.4.1"
//  "Content-Type":"application/x-www-form-urlencoded",
};

class DioUtils {
  static final DioUtils _singleInstance = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils({String customisedUrl}) {
    return _singleInstance;
  }

  static Dio _dio;
  BaseOptions _options;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal() {
    _options = BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: 60000,

      ///The interval between receiving data before and after the response stream
      receiveTimeout: 60000,

      ///If the returned is json (content-type), dio is automatically converted to json by default, no need to manually transfer
      ///(https://github.com/flutterchina/dio/issues/30)
      responseType: ResponseType.plain,

      //Default headers configuration
      headers: headers,

      validateStatus: (status) {
        //Whether to use http status code for judgment, true means not to use http status code for judgment
        return true;
      },
    );
    _dio = Dio(_options);

    //Add cookie blocker management
//    _dio.interceptors.add(CookieManager(CookieJar()));

    //Unified request header interceptor
    _dio.interceptors.add(AuthInterceptor());
    //Web log blocker
    _dio.interceptors.add(LoggingInterceptor());

    _dio.interceptors.add(AdapterInterceptor());
  }

  ///The returned data is processed uniformly and parsed into corresponding Bean
  Future<BaseResponse<T>> _request<T>(
    String method,
    String endPoint, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    var response = await _dio.request(endPoint,
        data: data,
        queryParameters: queryParameters,
        options: _setOptions(method, options),
        cancelToken: cancelToken);
    try {
      Map<String, dynamic> _map =
          await compute(parseData, response.data.toString());
      return BaseResponse.fromJson(_map);
    } catch (e) {
      print(e);
      return BaseResponse(ErrorStatus.PARSE_ERROR, "PARSE_ERROR", null);
    }
  }

  Future requestDataFuture<T>(
    Method method,
    String endPoint, {
    Function(T t) onSuccess,
    Function(List<T> list) onSuccessList,
    Function(int code, String msg) onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
    bool isList: false,
  }) async {
    String requestMethod = _getMethod(method);

    return await _request<T>(
      requestMethod,
      endPoint,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ).then((BaseResponse<T> result) {
      if (result.code == ErrorStatus.REQUEST_DATA_OK) {
        if (isList) {
          if (onSuccessList != null) {
            onSuccessList(result.listData);
          }
        } else {
          if (onSuccess != null) {
            onSuccess(result.data);
          }
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (e) {
      _cancelLog(e, endPoint);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  BaseResponse parseError() {
    return BaseResponse(ErrorStatus.PARSE_ERROR, "Data parsing error", null);
  }

  Options _setOptions(String method, Options options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  //Request the operation of a single object
  Future<BaseResponse<T>> request<T>(String method, String url,
      {Map<String, dynamic> params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    var response = await _request<T>(
      method,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response;
  }

  requestData<T>(Method method, String url,
      {Function(T t) onSuccess,
      Function(List<T> t) onSuccessList,
      Function(int code, String msg) onError,
      Map<String, dynamic> params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    String requestMethod = _getMethod(method);
    Stream.fromFuture(_request<T>(requestMethod, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result) {
      //Successful data returned
      if (result.code == ErrorStatus.REQUEST_DATA_OK) {
        if (isList) {
          if (onSuccessList != null) {
            onSuccessList(result.listData);
          }
        } else {
          if (onSuccess != null) {
            onSuccess(result.data);
          }
        }
      } else {
        _onError(result.code, result.message, onError);
      }
    }, onError: (e) {
      _cancelLog(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  _cancelLog(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.i("Cancel network request：$url");
    }
  }

  _onError(int code, String msg, Function(int code, String msg) onError) {
    Log.e("Interface request exception code:$code message:$msg");
    if (onError != null) {
      onError(code, msg);
    }
//    showToast(msg);
  }

  //Request type
  String _getMethod(Method method) {
    String netMethod;
    switch (method) {
      case Method.get:
        netMethod = "GET";
        break;
      case Method.post:
        netMethod = "POST";
        break;
      case Method.put:
        netMethod = "PUT";
        break;
      case Method.delete:
        netMethod = "DELETE";
        break;
    }
    return netMethod;
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data);
}

enum Method {
  get,
  post,
  put,
  delete,
}
