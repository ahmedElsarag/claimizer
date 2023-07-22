import 'dart:convert';

import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/LoginResponse.dart';
import 'package:Cliamizer/ui/main_screens/MainScreen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../../../CommonUtils/preference/Prefs.dart';
import '../../../generated/l10n.dart';
import '../../../network/api/network_api.dart';
import '../../../network/models/general_response.dart';
import '../../../network/network_util.dart';
import 'RegisterScreen.dart';

class RegisterPresenter extends BasePresenter<RegisterScreenState> {
  Future doRegisterApiCall(Map<String, dynamic> bodyParams) async {
    view.showProgress(isDismiss: false);
    await requestFutureData<LoginResponse>(Method.post, endPoint: Api.registerApiCall, params: bodyParams,
        onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.showToasts(S.of(view.context).accountCreated,'success');
        Navigator.pushAndRemoveUntil(
            view.context, CupertinoPageRoute(builder: (context) => MainScreen()), (route) => false);
        saveUser(data);
        sendFcmToken();
      }
    }, onError: (code, msg) {
      view.closeProgress();
      view.provider.setError(msg);
    });
  }

  Future sendFcmToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    print('@@@@@!!!!!!###%%$token');
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    await requestFutureData<GeneralResponse>(Method.post,params: {'token':token},
        options: Options(headers: header), endPoint: Api.fcmToken, onSuccess: (data) {
          print(data?.message);
        }, onError: (code, msg) {
          view.closeProgress();
        });
  }  void saveUser(LoginResponse response) async {
    Prefs.setCurrentUser(jsonEncode(response.toJson()));
    Prefs.setUserToken(response.data.token);
    Prefs.setUserName(response.data.name);
    Prefs.setIsLogin(true).then((value) => print("login status $value"));
  }

}
