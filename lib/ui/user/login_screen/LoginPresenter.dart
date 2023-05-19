import 'dart:convert';

import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/LoginResponse.dart';
import 'package:Cliamizer/ui/main_screens/MainScreen.dart';
import 'package:Cliamizer/ui/user/login_screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';

import '../../../CommonUtils/preference/Prefs.dart';
import '../../../generated/l10n.dart';
import '../../../network/api/network_api.dart';
import '../../../network/network_util.dart';

class LoginPresenter extends BasePresenter<LoginScreenState> {
  Future doLoginApiCall(Map<String, dynamic> bodyParams) async {
    view.showProgress(isDismiss: false);
    await requestFutureData<LoginResponse>(Method.post, endPoint: Api.loginApiCall, params: bodyParams,
        onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.showToasts(S.of(view.context).loggedInSuccessfully,'success');
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
