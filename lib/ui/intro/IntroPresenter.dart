import 'dart:ui';

import '../../CommonUtils/preference/Prefs.dart';
import '../../base/presenter/base_presenter.dart';
import '../../res/setting.dart';
import 'IntroScreen.dart';

class IntroPresenter extends BasePresenter<IntroScreenState> {

  setAppLanguage(){
    Prefs.getAppLocal.then((value) => setSelected(value));
  }
  void setSelected(String s) {
    if (s == 'null') s = 'en';
    if (Setting.mobileLanguage.value != Locale(s)) {
      Setting.mobileLanguage.value =  Locale(s);
    }
    Prefs.setAppLocal(s);
    print("language selected $s");
  }
}
