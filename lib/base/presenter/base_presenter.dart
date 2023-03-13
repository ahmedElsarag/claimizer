import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Cliamizer/CommonUtils/preference/Prefs.dart';
import 'package:Cliamizer/generated/l10n.dart';
import 'package:Cliamizer/network/exception/error_status.dart';
import 'package:Cliamizer/network/models/LoginResponse.dart';
import 'package:Cliamizer/network/network_util.dart';
import 'package:Cliamizer/ui/user/login_screen/LoginScreen.dart';

import '../../CommonUtils/log_utils.dart';
import '../../network/api/network_api.dart';
import '../view/i_base_view.dart';
import 'i_presenter.dart';

class BasePresenter<V extends IBaseView> extends IPresenter {
  V view;

  //Cancel network request
  CancelToken _cancelToken;

  BasePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidget<W>(W oldWidget) {}

  @override
  void dispose() {
    if (_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  @override
  void initState() {}

  Future requestFutureData<T>(Method method,
      {String endPoint,
      bool isShow: true,
      bool isClose: true,
      Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParams,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) async {
    await DioUtils.instance.requestDataFuture<T>(method, endPoint,
        params: params,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken ?? _cancelToken, onSuccess: (data) {
      //view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }
    }, onSuccessList: (data) {
      if (isClose) //view.closeProgress();
      if (onSuccessList != null) onSuccessList(data);
    }, onError: (code, msg) {
      if (isClose) //view.closeProgress();
        _onError(code, msg, onError);
      if (code == ErrorStatus.FORBIDDEN) {
        Prefs.clearExpectLanguage();
        Navigator.pushReplacement(view.getContext(), MaterialPageRoute(builder: (context)=>LoginScreen()));
      } else if (code == ErrorStatus.UNKNOWN_ERROR ||
          code == ErrorStatus.TIMEOUT_ERROR ||
          code == ErrorStatus.NETWORK_ERROR) {
        final context = view.getContext();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text("${S.of(context).checkYourInternet}"),
            backgroundColor: Theme.of(context).errorColor));
      } else if (code == ErrorStatus.SERVER_ERROR) {
        final context = view.getContext();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text(S.of(context).anErrorOccurredTryAgainLater),
            backgroundColor: Theme.of(context).errorColor));
      } else if (code == ErrorStatus.UNAUTHORIZED) {
        final context = view.getContext();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text(S.of(context).sessionTimeoutPleaseLogin),
            backgroundColor: Theme.of(context).errorColor));
        // showDialog(context: context, builder: (context) => LoginRequiredDialog(message:S.of(context).sessionTimeoutPleaseLogin));
      }
    });
  }

  // bool checkAuth(int code, context) {
  //   if (code == ErrorStatus.FORBIDDEN) {
  //     Prefs.clearExpectLanguage();
  //     NavigatorUtils.push(context, LoginRouter.loginPage,
  //         replace: false, clearStack: true);
  //   }
  //   return false;
  // }

  void requestDataFromNetwork<T>(Method method,
      {String url,
      bool isShow: true,
      bool isClose: true,
      Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
//    Display loading circle
    DioUtils.instance.requestData<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
        isList: isList, onSuccess: (data) {
//      Request data successfully
      //view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }

      //Request list successful
    }, onSuccessList: (data) {
      if (isClose) //view.closeProgress();
      if (onSuccessList != null) {
        onSuccessList(data);
      }

      ///Request error
    }, onError: (code, msg) {
      if (isClose) //view.closeProgress();
        _onError(code, msg, onError);
    });
  }

  _onError(int code, String msg, Function(int code, String msg) onError) {
    //view.closeProgress();
    if (code != ErrorStatus.CANCEL_ERROR) {
//      view.showToast(msg);
    }

    if (onError != null && view.getContext() != null) {
      onError(code, msg);
    }
  }

  Future refreshToken() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });

    await requestFutureData<LoginResponse>(Method.post,
        endPoint: Api.refreshTokenApiCall,
        options: Options(headers: header), onSuccess: (data) {
      // view.closeProgress();
      if (data != null) {
        Log.d("onSuccess " + data.toString());
        Prefs.setUserToken(data.accessToken);
        // view.provider.addedToCart = true;
        // view.provider.setData(data);
      } else {
        Log.d('token not refreshed');
      }
    }, onError: (code, msg) {
      Log.d(msg);
      // view.closeProgress();
    });
  }
}
