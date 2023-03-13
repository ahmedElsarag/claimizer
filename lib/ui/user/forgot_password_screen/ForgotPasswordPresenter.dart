import 'dart:convert';

import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/LoginResponse.dart';
import 'package:Cliamizer/ui/user/forgot_password_screen/ForgotPasswordScreen.dart';
import 'package:Cliamizer/ui/user/login_screen/LoginScreen.dart';

import '../../../CommonUtils/preference/Prefs.dart';
import '../../../network/api/network_api.dart';
import '../../../network/network_util.dart';


class ForgotPasswordPresenter extends BasePresenter<ForgotPasswordScreenState> {
  Future doLoginApiCall(Map<String, dynamic> bodyParams) async {
    view.showProgress(isDismiss: false);
    await requestFutureData<LoginResponse>(Method.post,
        endPoint: Api.refreshTokenApiCall,
        params: bodyParams, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
      }
    }, onError: (code, msg) {

    });
  }
}
