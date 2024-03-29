import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:Cliamizer/base/presenter/base_presenter.dart';
import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../generated/l10n.dart';
import '../../network/api/network_api.dart';
import '../../network/exception/error_status.dart';
import '../../network/network_util.dart';
import 'MainScreen.dart';

class MainPresenter extends BasePresenter<MainScreenState> {
  Future<bool> getLoginStatus() async {
    return Prefs.isLogin.then((value) {
      view.pr.isUserLoggedIn = value;
      print('login status: $value');
    });
  }

  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      view.showToasts(S.of(view.context).backAgainToCloseApp, 'status');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
