import 'dart:convert';

import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/LoginResponse.dart';
import 'package:Cliamizer/ui/user/login_screen/LoginScreen.dart';

import '../../../CommonUtils/preference/Prefs.dart';
import '../../../network/api/network_api.dart';
import '../../../network/network_util.dart';

class LoginPresenter extends BasePresenter<LoginScreenState> {
  Future doLoginApiCall(Map<String, dynamic> bodyParams) async {
    view.showProgress(isDismiss: false);
    await requestFutureData<LoginResponse>(Method.post, endPoint: Api.refreshTokenApiCall, params: bodyParams, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {}
    }, onError: (code, msg) {});
  }

  void saveUser(LoginResponse response) async {
    Prefs.setCurrentUser(jsonEncode(response.toJson()));
    Prefs.setUserName(response.data.name);
    Prefs.setIsLogin(true).then((value) => print("login status $value"));
  }
}
