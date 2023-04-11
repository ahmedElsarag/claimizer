import 'dart:convert';

import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/LoginResponse.dart';
import 'package:Cliamizer/ui/main_screens/MainScreen.dart';
import 'package:flutter/cupertino.dart';

import '../../../CommonUtils/preference/Prefs.dart';
import '../../../generated/l10n.dart';
import '../../../network/api/network_api.dart';
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
      }
    }, onError: (code, msg) {
      view.closeProgress();
      view.provider.setError(msg);
    });
  }


  void saveUser(LoginResponse response) async {
    Prefs.setCurrentUser(jsonEncode(response.toJson()));
    Prefs.setUserToken(response.data.token);
    Prefs.setUserName(response.data.name);
    Prefs.setIsLogin(true).then((value) => print("login status $value"));
  }

}
