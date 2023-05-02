import 'dart:async';

import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/user/login_screen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/SizeConfig2.dart';
import '../../CommonUtils/image_utils.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../main_screens/MainScreen.dart';
import 'SplashPresenter.dart';
import 'SplashProvider.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends BaseState<SplashScreen, SplashPresenter> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  SplashProvider mProvider = SplashProvider();

  StreamSubscription _subscription;
  String appVersion = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Align(
        alignment: FractionalOffset.center,
        child: buildLogo(context),
      ),
    );
  }

  Widget buildLogo(BuildContext context) {
    return Center(
        child: Image.asset(
      ImageUtils.getImagePath("logo"),
      width: 30.w,
      height: 30.w,
    ));
  }

  void initSplash() {
    _subscription = Stream.value(1).delay(Duration(seconds: 3)).listen((_) {
        isUserLoggedIn();
        // Navigator.pushReplacement(context, AppPageRoute(builder: (context)=>IntroStartScreen()));
    });
  }

  @override
  void initState() {
    mPresenter.setAppLanguage();
    // languageProvider = context.read<LanguageProvider>();
    // languageProvider.loadSelectedLanguage();
    initSplash();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_subscription != null) {
      _subscription.cancel();
    }
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "v ${packageInfo.version}";
    setState(() {});
  }

  @override
  SplashPresenter createPresenter() {
    return SplashPresenter();
  }

  Future isUserLoggedIn() async {
    await Prefs.isLogin ? _openHomeScreen(context) : _openLoginScreen(context);
  }

  _openLoginScreen(context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  bool get wantKeepAlive => true;

  _openHomeScreen(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
}
