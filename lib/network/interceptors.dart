import 'dart:convert';

import 'package:Cliamizer/CommonUtils/log_utils.dart';
import 'package:Cliamizer/CommonUtils/preference/Prefs.dart';
import 'package:dio/dio.dart';
import 'package:sprintf/sprintf.dart';

import 'exception/error_status.dart';
import 'models/default_response.dart';

///Header management interceptor
class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Prefs.getAppLocal.then((value) => {
          options.headers["lang"] = value,
        });
    options.headers["Accept"] = "application/json";
    return super.onRequest(options, handler);
  }
}

///Log interceptor settings
class LoggingInterceptor extends Interceptor {
  DateTime startTime;
  DateTime endTime;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    startTime = DateTime.now();
    Log.d("----------Request Start---------");

    ///print full path request
    if (options.queryParameters.isEmpty) {
      if (options.path.contains(options.baseUrl)) {
        Log.i("RequestUrl:" + options.path);
      } else {
        Log.i("RequestUrl:" + options.baseUrl + options.path);
      }
    } else {
      ///If queryParameters is not empty, splice into a complete URl
      Log.i("RequestUrl:" +
          options.baseUrl +
          options.path +
          "?" +
          Transformer.urlEncodeMap(options.queryParameters));
    }
    Log.i("RequestUrl:" + options.baseUrl + options.path);

    // Log.d("RequestMethod:" +
    //     options.method +
    //     "\n" +
    //     "RequestHeaders:" +
    //     options.headers.toString() +
    //     "\n" +
    //     "RequestContentType:" +
    //     options.contentType.toString() +
    //     "\n" +
    //     "RequestData:${options.data.toString()}" +
    //     "\n");
    Log.d("RequestHeaders:" + options.headers.toString());
    // Log.d("RequestContentType:" + options.contentType.toString());
    // Log.d("RequestData:${options.data.toString()}");

    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    endTime = DateTime.now();
    //Request duration
    int duration = endTime.difference(startTime).inMilliseconds;
    Log.d("----------End Request $duration millisecond---------");
//    Log.d(response.data);
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    Log.d("--------------Error-----------");
    return super.onError(err, handler);
  }
}

//parsing data
class AdapterInterceptor extends Interceptor {
  static const String MSG = "msg";
  static const String SLASH = "\"";
  static const String MESSAGE = "message";
  static const String ERROR = "validateError";

  static const String DEFAULT = "\"NOT_FOUND\"";
  static const String NOT_FOUND = "Some Thing Wrong Happened";

  static const String FAILURE_FORMAT = "{\"code\":%d,\"message\":\"%s\"}";
  static const String SUCCESS_FORMAT =
      "{\"code\":0,\"data\":%s,\"message\":\"\"}";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    Response rp = adapterData(response);
    return super.onResponse(rp, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      adapterData(err.response);
    }
    return super.onError(err, handler);
  }

  Response adapterData(Response response) {
    String result;
    String content = response.data == null ? "" : response.data.toString();
    if (response.statusCode == ErrorStatus.SUCCESS) {
      if (content.isEmpty) {
        content = DEFAULT;
      }
      result = sprintf(SUCCESS_FORMAT, [content]);
      response.statusCode = ErrorStatus.SUCCESS;
    } else {
      result = sprintf(FAILURE_FORMAT, [
        response.statusCode,
        DefaultResponse?.fromJson(jsonDecode(response?.data))?.message?.isNotEmpty ?? false
            ? DefaultResponse.fromJson(jsonDecode(response.data)).message.toString()
            : NOT_FOUND
      ]);
      response.statusCode = ErrorStatus.SUCCESS;
    }
    if (response.statusCode == ErrorStatus.SUCCESS) {
      Log.d("ResponseCode:${response.statusCode}");
      Log.d("response:${response.data}");
    } else {
      Log.e("ResponseCode:${response.statusCode}");
      Log.d("response:${response.data}");
    }
    Log.json(result);
    response.data = result;
    return response;
  }
}
